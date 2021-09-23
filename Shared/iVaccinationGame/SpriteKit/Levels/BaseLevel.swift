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
    
    var backgroundImageName:String = ""
    
    var zombiePaths:[BasePath] = []
    var zombieCurrentPath:BasePath = BasePath()
    
    var zombieImageName:String = ""
    var zombieCuredImageName:String = ""
    var zombieCount:Int = 1
    var zombieDamage:CGFloat = 25.0
    
    var shots:Int = 0
    var hits:Int = 0
    
    var syringeRespawnYRange = -350.0..<(-100.0)
    var medkitRespawnYRange = -350.0..<(200.0)
    
    init(){
        self.initLevel()
        self.zombieCurrentPath = self.zombiePaths.randomElement()!
    }
    
    func initLevel(){
        
    }
    
    func setupLevel(gameScene:GameSceneBase){
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName + (self.isNightTime() ? "Night" : ""))
        gameScene.zmbGrl.texture = SKTexture(imageNamed: self.zombieImageName)
        if let path = self.zombiePaths.randomElement(){
            gameScene.zmbGrl.position = path.initPos
            gameScene.zmbGrl.setScale(path.initScale)
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
