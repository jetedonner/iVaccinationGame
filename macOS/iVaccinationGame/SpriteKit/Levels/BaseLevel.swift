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
    
    init(){
        self.initLevel()
        self.zombieCurrentPath = self.zombiePaths.randomElement()!
    }
    
    func initLevel(){
        
    }
    
    func setupLevel(gameScene:GameScene){
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName)
        gameScene.zombieGirl.texture = SKTexture(imageNamed: self.zombieImageName)
        if let path = self.zombiePaths.randomElement(){
            gameScene.zombieGirl.position = path.initPos
            gameScene.zombieGirl.setScale(path.initScale)
        }
    }
}