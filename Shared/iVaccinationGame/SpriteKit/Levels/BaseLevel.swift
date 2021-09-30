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
    
    var backgroundImageName:String = ""
    
    var zombiePaths:[BasePath] = []
    var zombieCurrentPath:BasePath = BasePath()
    
    var zombieImageName:String = ""
    var zombieCuredImageName:String = ""
    var zombieCount:Int = 1
    var zombieDamage:CGFloat = 25.0
    
    var shots:Int = 0
    var hits:Int = 0
    
    var scoreBase:Int = 100
    
    var syringeRespawnYRange = -350.0..<(-100.0)
    var medkitRespawnYRange = -350.0..<(200.0)
    var certRespawnRange = 5...20
    
    init(level:Level){
        self.level = level
        self.initLevel()
        self.zombieCurrentPath = self.zombiePaths.getRandom()
    }
    
    func initLevel(){
        
    }
    
    func setupLevel(gameScene:GameSceneBase){
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName + (self.isNightTime() ? "Night" : ""))
        gameScene.zombieGirl.texture = SKTexture(imageNamed: self.zombieImageName)
        let path = self.zombiePaths.getRandom()
        gameScene.zombieGirl.position = path.initPos
        gameScene.zombieGirl.setScale(path.initScale)
        if(path.hideOnStart){
            gameScene.zombieGirl.xScale = 0.0
        }
    }
    
    func isNightTime()->Bool{
        let hour = Calendar.current.component(.hour, from: Date())
        if(hour >= 18 || hour <= 6){
            return true
        }
        return false
    }
}
