//
//  SyringeDart.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import SpriteKit
import GameKit

class SyringeDart: SKSpriteNode {
    
    let gameScene:GameSceneBase
    
    init(gameScene:GameSceneBase, size:CGSize? = nil) {
        self.gameScene = gameScene
        
        let texture = SKTexture(imageNamed: "Syringe")
        super.init(texture: texture, color: SKColor.clear, size: (size ?? CGSize(width: 64, height: 64)))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 15.0)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.contactTestBitMask = 0b0001
    }
    
    func shootSyringe(point:CGPoint){
        
        self.gameScene.contentNode?.addChild(self)
        self.zPosition = 10000
        
        self.gameScene.currentLevel.shots += 1
        self.gameScene.runHandThrowingAnimation()
        self.gameScene.player.shootSyringe()
        self.gameScene.setSyringesHUD()
        
        if(self.gameScene.player.syringesCount == 1){
            self.gameScene.syringe2?.isHidden = true
        }else if(!self.gameScene.player.hasSyringes){
            self.gameScene.syringe1?.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.gameScene.syringePickup?.genNewPos()
            }
        }
        self.position = CGPoint(x: 0, y: -300)
        
        SoundManager.shared.playSound(sound: .shot)
        
//        self.speed = UserDefaultsHelper.speedMultiplierForDifficulty
        self.speed = self.gameScene.currentLevel.currentLevelConfig.speedFactor.multiplier
        self.run(
            SKAction.group([
                SKAction.move(to: point, duration: 0.5),
                SKAction.scale(to: 0.5, duration: 0.5)
            ]),
            completion: {
                if(!self.isHidden){
                    SoundManager.shared.playSound(sounds: [.impact1, .impact2, .impact3])
                    self.removeFromGameScene()
                }
            }
        )
        self.gameScene.updateThrowingHandTexture()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.removeFromGameScene()
        }
    }
    
    func removeFromGameScene(){
        self.isHidden = true
        self.removeAllActions()
        self.removeFromParent()
        if let idx = self.gameScene.thrownSyringeDarts.firstIndex(of: self){
            self.gameScene.thrownSyringeDarts.remove(at: idx)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
