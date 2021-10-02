//
//  BaseLevel.swift
//  BaseLevel
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import SpriteKit

class BaseLevel {
    
    var levelName:String = "Name not implemented"
    var level:Level = .Meadow
    
    var levelConfigs:[Difficulty:LevelConfig] = [:]
    var currentLevelConfig:LevelConfig{
        get{ return self.levelConfigs[self.difficulty]! }
    }
    
    var duration:Duration = .Minutes1
    
    var gameScene:GameSceneBase!
    var difficulty:Difficulty = .easy
    
    var backgroundImageName:String = ""
    
    var zombiePaths:[Difficulty:[BasePath]] = [:]
    var zombieCurrentPath:BasePath = BasePath()
    
    var zombieImageName:String = "ZombieGirl2"
    var zombieCuredImageName:String = "ZombieGirl2Un"
//    self.zombieImageName = "ZombieGirl2"
//    self.zombieCuredImageName = "ZombieGirl2Un"
    var zombieCount:Int = 1
    var zombieDamage:CGFloat = 25.0
    var zombieGirls:[ZombieGirl] = []
    
    var shots:Int = 0
    var hits:Int = 0
    
    var scoreBase:Int = 100
    
    var syringeRespawnYRange = -350.0..<(-100.0)
    var medkitRespawnYRange = -350.0..<(200.0)
    var certRespawnRange = 5...15
    
    init(level:Level){
        self.level = level
        self.initLevel()
        self.initLevelConfig()
        self.zombieCurrentPath = self.zombiePaths[.easy]!.getRandom()
    }
    
    func initLevelConfig() {
    
    }
    
    func initLevel(){
        
    }
    
    func endLevel(){
        for zombieGirl in zombieGirls {
            zombieGirl.isPaused = true
            zombieGirl.removeAllActions()
            zombieGirl.removeFromParent()
        }
        zombieGirls.removeAll()
    }
    
    func setupLevelConfig(gameScene:GameSceneBase, difficulty:Difficulty){
        self.gameScene = gameScene
        self.difficulty = difficulty
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName + (UserDefaultsHelper.autoNightMode && self.isNightTime() ? "Night" : ""))
        
        self.gameScene.gameDuration = self.currentLevelConfig.gameDuration
    }
    
    func addNewZombieGirl(){
        let path:BasePath = (self.levelConfigs[self.difficulty]?.zombiePaths.getRandom())!
        self.addZombieGirl(gameScene: self.gameScene, path: path)
    }
    
    func addZombieGirl(gameScene:GameSceneBase, path:BasePath){
        let newZombieGirl:ZombieGirl = ZombieGirl(zombieImageName: self.zombieImageName)
        newZombieGirl.currentPath = path
        newZombieGirl.position = path.initPos
        newZombieGirl.setScale(path.initScale)
        newZombieGirl.speed = self.currentLevelConfig.speedFactor.multiplier
        newZombieGirl.addPhysicBody()
        newZombieGirl.zPosition = 101
        if(UserDefaultsHelper.devMode){
            newZombieGirl.addDbgBorder()
        }
        if(path.hideOnStart){
            newZombieGirl.xScale = 0.0
        }
        self.zombieGirls.append(newZombieGirl)
        gameScene.sceneNode.addChild(newZombieGirl)
        newZombieGirl.run(newZombieGirl.currentPath.path, completion: {
            self.gameScene.bittenByZombie(zombieGirl: newZombieGirl)
        })
    }
    
    func removeZombieGirl(zombieGirl:ZombieGirl){
        
        self.zombieGirls = self.zombieGirls.filter { $0 != zombieGirl }
        zombieGirl.removeFromParent()
//        for zombie in self.zombieGirls{
//            if(zombie == zombieGirl){
//                zombsieGirl.removeFromParent()
//                self.zombieGirls.remove
//            }
//        }
    }
    
    func setupLevel(gameScene:GameSceneBase){
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName + (UserDefaultsHelper.autoNightMode && self.isNightTime() ? "Night" : ""))
//        gameScene.zombieGirl.texture = SKTexture(imageNamed: self.zombieImageName)
//        let path = self.zombiePaths[.easy]!.getRandom()
//        gameScene.zombieGirl.position = path.initPos
//        gameScene.zombieGirl.setScale(path.initScale)
//        if(path.hideOnStart){
//            gameScene.zombieGirl.xScale = 0.0
//        }
    }
    
    func isNightTime()->Bool{
        let hour = Calendar.current.component(.hour, from: Date())
        if(hour >= 18 || hour <= 6){
            return true
        }
        return false
    }
}
