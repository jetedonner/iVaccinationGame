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
    
    #if os(macOS)
    var syringeRespawnYRange = -350.0..<(-100.0)
    #endif
    
    #if os(iOS)
    var syringeRespawnYRange = -350.0..<(-100.0) //UIFloatRange = UIFloatRange(minimum: -200.0, maximum: 0.0)
//    let underFive = 0.0..<5.0
    #endif
    
    init(){
        self.initLevel()
        self.zombieCurrentPath = self.zombiePaths.randomElement()!
    }
    
    func initLevel(){
        
    }
    
    func setupLevel(gameScene:GameSceneBase){
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
        
        var nightMode:Bool = false
        if(hour >= 18 || hour <= 6){
            nightMode = true
        }
        
        gameScene.bg?.texture = SKTexture(imageNamed: self.backgroundImageName + (nightMode ? "Night" : ""))
//        gameScene.zombieGirl.texture = SKTexture(imageNamed: self.zombieImageName)
//        if let path = self.zombiePaths.randomElement(){
//            gameScene.zombieGirl.position = path.initPos
//            gameScene.zombieGirl.setScale(path.initScale)
        gameScene.zmbGrl.texture = SKTexture(imageNamed: self.zombieImageName)
        if let path = self.zombiePaths.randomElement(){
            gameScene.zmbGrl.position = path.initPos
            gameScene.zmbGrl.setScale(path.initScale)
        }
    }
}
