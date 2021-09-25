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
//        self.isHidden = false
        self.gameScene.syringesLeft -= 1
        self.gameScene.lblSyringesLeft?.text = self.gameScene.syringesLeft.description + " / 2"
        if(self.gameScene.syringesLeft == 1){
            self.gameScene.syringe2?.isHidden = true
        }else if(self.gameScene.syringesLeft == 0){
            self.gameScene.syringe1?.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                var isBehindGKAccessPoint:Bool = true
//                var isBehindHand:Bool = true
//                var newPoint:CGPoint = CGPoint(x: 0, y: 0)
//                repeat{
//                    let newX:CGFloat = CGFloat.random(in: ((self.gameScene.frame.width / -2) + 20) ... ((self.gameScene.frame.width / 2) - 20))
//                    let newY:CGFloat = CGFloat(Double.random(in: self.gameScene.currentLevel.syringeRespawnYRange))
//                    newPoint = CGPoint(x: newX, y: newY)
//
//                    let accsPntCoord:CGRect = GKAccessPoint.shared.frameInScreenCoordinates
//                    print("GKAccessPointCoord: \(accsPntCoord)")
//                    isBehindGKAccessPoint = accsPntCoord.contains(newPoint)
//                    isBehindHand = self.gameScene.imgThrowingHand!.frame.contains(newPoint)
//                }while(isBehindHand || isBehindGKAccessPoint)
//                self.gameScene.syringePickup?.position = newPoint
//                self.gameScene.syringePickup?.alpha = 1.0
                self.gameScene.syringePickup?.genNewPos()
            }
        }
        self.position = CGPoint(x: 0, y: -300)
        
//        self.gameScene.syringe?.position = CGPoint(x: 0, y: -300)
//        self.gameScene.syringe?.scale(to: CGSize(width: 64, height: 64))
        if(UserDefaultsHelper.playSounds){
//            self.gameScene.scene?.run(SoundManager.shotSound)
            SoundManager.shared.playSound(sound: .shot)
        }
//        self.gameScene.syringe?.speed = UserDefaultsHelper.speedMultiplierForDifficulty
//        self.gameScene.syringe?.run(
        self.speed = UserDefaultsHelper.speedMultiplierForDifficulty
        self.run(
            SKAction.group([
                SKAction.move(to: point, duration: 0.5),
                SKAction.scale(to: 0.5, duration: 0.5)
            ]),
            completion: {
//                if(!self.gameScene.syringe!.isHidden){
//                    self.gameScene.syringe?.run(SoundManager.impactSound)
//                }
                if(!self.isHidden){
//                    self.gameScene.scene!.run(SoundManager.impactSound)
                    //TODO: SoundVariants
                    SoundManager.shared.playSound(sound: .impact1)
                    self.removeFromGameScene()
                }
            }
        )
        self.gameScene.updateThrowingHandTexture()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.removeFromGameScene()
//            self.gameScene.syringe?.isHidden = true
//            self.gameScene.thrownSyringeDarts.remove(at: self.gameScene.thrownSyringeDarts.firstIndex(of: self)!)
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
