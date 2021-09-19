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
    
    var zombieInitPos:[CGPoint] = []
    var zombieInitScale:[CGFloat] = []
    var zombieImageName:String = ""
    var zombieCuredImageName:String = ""
    var zombieCount:Int = 1
    var zombieDamage:CGFloat = 25.0
    
    var zombiePaths:[SKAction] = []
    var zombieExitPaths:[SKAction] = []
    
    init(){
        self.initLevel()
    }
    
    func initLevel(){
        
    }
    
    func setupLevel(gameScene:GameScene){
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName)
        gameScene.zombieGirl.texture = SKTexture(imageNamed: self.zombieImageName)
        gameScene.zombieGirl.position = self.zombieInitPos.randomElement()!
        gameScene.zombieGirl.setScale(self.zombieInitScale.randomElement()!)
    }
}
