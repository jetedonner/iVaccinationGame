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
    var zombieCount:Int = 1
    var zombieDamage:CGFloat = 25.0
    var zombieGirls:[ZombieGirl] = []
    var zombiesSpawned:Int = 0
    
    var shots:Int = 0
    var hits:Int = 0
    
    var scoreBase:Int = 100
    
    var syringeRespawnYRange = -350.0..<(-100.0)
    var medkitRespawnYRange = -350.0..<(200.0)
    var certRespawnRange = 5...15
    var certLifetimeRange = 7...15
    
    init(level:Level, levelName:String, bgImageName:String){
        self.level = level
        self.levelName = levelName
        self.backgroundImageName = bgImageName
        self.initLevelConfig()
    }
    
    func initLevelConfig() {
//        self.gameScene.certificatePickupManager.paused = false
//        self.gameScene.syringePickupManager.paused = false
//        self.loadConfigPlistFile()
    }
    
    func endLevel(){
        for zombieGirl in zombieGirls {
//            zombieGirl.isPaused = true
            zombieGirl.removeAllActions()
//            zombieGirl.removeFromParent()
        }
        zombieGirls.removeAll()
        self.gameScene.certificatePickupManager.paused = true
        self.gameScene.syringePickupManager.paused = true
    }
    
    func loadConfigPlistFile(){
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Meadow-Easy", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
        }
//        print(nsDictionary?.description)
        
//        let tmp = Difficulty(rawValue: nsDictionary?["Difficulty"] as! String)
//        print(tmp)
        self.difficulty = Difficulty(rawValue: nsDictionary?["Difficulty"] as! String)!
        print(self.difficulty)
//        print(nsDictionary?.description)
        
        self.gameScene.certificatePickupManager.pickupsAtOnce = Int(nsDictionary?["CertificateCount"] as! String)!
        self.gameScene.syringePickupManager.pickupsAtOnce = Int(nsDictionary?["SyringeCount"] as! String)! //nsDictionary?["SyringeCount"] as! Int
        self.zombieCount = Int(nsDictionary?["ZombieCount"] as! String)! //nsDictionary?["ZombieCount"] as! Int
        self.levelName = nsDictionary?["LevelName"] as! String
        self.duration = Duration(rawValue: nsDictionary?["Duration"] as! Int)!
//        print(self.duration)
    }
    
    func setupLevelConfig(gameScene:GameSceneBase, difficulty:Difficulty){
        self.gameScene = gameScene
        self.difficulty = difficulty
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName + (UserDefaultsHelper.autoNightMode && self.isNightTime() ? "Night" : ""))
        
        self.gameScene.gameDuration = (UserDefaultsHelper.devMode ? UserDefaultsHelper.roundTime /*GameVars.DEV_ROUND_TIME*/ : self.currentLevelConfig.gameDuration)
        self.gameScene.certificatePickupManager.pickupsAtOnce = self.currentLevelConfig.certificatePickupsAtOnce
        self.gameScene.certificatePickupManager.paused = false
        self.gameScene.syringePickupManager.pickupsAtOnce = self.currentLevelConfig.syringePickupsAtOnce
        self.gameScene.syringePickupManager.paused = false
//        self.loadConfigPlistFile()
    }
    
    func addNewZombieGirl(){
        if(self.gameScene.gameRunning){
            let path:BasePath = (self.levelConfigs[self.difficulty]?.zombiePaths.getRandom())!
            self.addZombieGirl(gameScene: self.gameScene, path: path)
        }
    }
    
    func addZombieGirl(gameScene:GameSceneBase, path:BasePath){
        self.zombiesSpawned += 1
        let newZombieGirl:ZombieGirl = ZombieGirl(zombieImageName: self.zombieImageName)
        newZombieGirl.currentPath = path
        newZombieGirl.position = path.initPos
//        if(UserDefaultsHelper.devMode && UserDefaultsHelper.dbgBorders){
//            newZombieGirl.addDbgBorder()
//        }
        UserDefaultsHelper.inDevMode(block: {
            newZombieGirl.addDbgBorder()
        }, and: UserDefaultsHelper.dbgBorders)
        
        newZombieGirl.setScale(path.initScale)
        newZombieGirl.speed = self.currentLevelConfig.speedFactor.multiplier
        newZombieGirl.addPhysicBody()
        newZombieGirl.zPosition = 1000
        if(path.hideOnStart){
            newZombieGirl.xScale = 0.0
        }
        if(self.zombieGirls.count > 0){
            newZombieGirl.zPosition = self.zombieGirls.last!.zPosition - 1
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
    }
    
    func setupLevel(gameScene:GameSceneBase){
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName + (UserDefaultsHelper.autoNightMode && self.isNightTime() ? "Night" : ""))
    }
    
    func isNightTime()->Bool{
        let hour = Calendar.current.component(.hour, from: Date())
        if(hour >= 18 || hour <= 6){
            return true
        }
        return false
    }
}
