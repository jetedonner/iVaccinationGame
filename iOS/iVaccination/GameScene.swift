//
//  GameScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 16.09.21.
//

import SpriteKit
import GameplayKit

class GameScene: GameSceneBase {
    
//    override func sceneDidLoad() {
//        super.sceneDidLoad()
//    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("touchDown")
        
        if let gameScene = (self.scene as? GameScene){
            
            if(!gameScene.gameRunning && gameScene.waitForAnyKey){
                gameScene.restartAfterGameOverNG()
                return
            }
            
            if(gameScene.syringesLeft <= 0){
//                location.y -= 30.0
                let node = gameScene.atPoint(pos)
//                if let imgCH = gameScene.imgCH{
//                    location.x += imgCH.size.width / 2
//                    location.y -= imgCH.size.height / 2
//                }
//                let node = gameScene.atPoint(location)
                if(node == gameScene.syringePickup || node.parent == gameScene.syringePickup){
                    gameScene.syringePickup?.alpha = 0.0
                    if(UserDefaultsHelper.playSounds){
                        gameScene.contentNode?.run(SoundManager.syringePickupSound)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        gameScene.syringesLeft = 2
                        gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
                        gameScene.syringe2?.isHidden = false
                        gameScene.syringe1?.isHidden = false
                    }
                }
                if(gameScene.health >= 100.0){
                    return
                }
            }
            
            let node = gameScene.atPoint(pos)
            if(node == gameScene.medkitPickup || node.parent == gameScene.medkitPickup){
                gameScene.health += 25.0
                gameScene.prgBar.setProgress(gameScene.health / 100.0)
                gameScene.medkitPickup?.run(SKAction.group([SKAction.fadeAlpha(to: (gameScene.health >= 100.0 ? 0.0 : 1.0), duration: 2.0), SoundManager.healthPickupSound]), completion: {
                    if(gameScene.health >= 100.0){
                        gameScene.medkitPickup?.alpha = 0.0
                    }
                })
                return
            }
                
            gameScene.runHandThrowingAnimation()
            gameScene.syringe?.isHidden = false
            gameScene.syringesLeft -= 1
            gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
            if(gameScene.syringesLeft == 1){
                gameScene.syringe2?.isHidden = true
            }else if(gameScene.syringesLeft == 0){
                gameScene.syringe1?.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {

                    let newX:CGFloat = CGFloat.random(in: ((self.frame.width / -2) + 20) ... ((self.frame.width / 2) - 20))
                    let newY:CGFloat = CGFloat(Double.random(in: gameScene.currentLevel.syringeRespawnYRange))

                    gameScene.syringePickup?.position = CGPoint(x: newX, y: newY)
                    gameScene.syringePickup?.alpha = 1.0
                }
            }
            gameScene.syringe?.position = CGPoint(x: 0, y: -300)
            gameScene.syringe?.scale(to: CGSize(width: 64, height: 64))
            if(UserDefaultsHelper.playSounds){
                self.scene?.run(SoundManager.shotSound)
                SoundManager.playAudio(audioName: "throwing-whip")
            }
            gameScene.syringe?.speed = UserDefaultsHelper.speedMultiplierForDifficulty
            gameScene.syringe?.run(
                SKAction.group([
                    SKAction.move(to: pos, duration: 0.5),
                    SKAction.scale(to: 0.5, duration: 0.5)
                ])
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameScene.syringe?.isHidden = true
            }
        }
//        if let menuScene = (self.scene as? MenuScene){
//            menuScene.mouseDown(with: event)
//            return
//        }
//        if let gameScene = (self.scene as? GameScene){
//            super.mouseDown(with: event)
//
//            if(!gameScene.gameRunning && gameScene.waitForAnyKey){
//                gameScene.restartAfterGameOverNG()
//                return
//            }
//            var location = event.location(in: gameScene.bg!)
//
//            if(gameScene.syringesLeft <= 0){
//                location.y -= 30.0
//                if let imgCH = gameScene.imgCH{
//                    location.x += imgCH.size.width / 2
//                    location.y -= imgCH.size.height / 2
//                }
//                let node = gameScene.atPoint(location)
//                if(node == gameScene.syringePickup || node.parent == gameScene.syringePickup){
//                    gameScene.syringePickup?.alpha = 0.0
//                    if(UserDefaultsHelper.playSounds){
//                        gameScene.contentNode?.run(SoundManager.syringePickupSound)
//                    }
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        gameScene.syringesLeft = 2
//                        gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
//                        gameScene.syringe2?.isHidden = false
//                        gameScene.syringe1?.isHidden = false
//                    }
//                }
//                if(gameScene.health >= 100.0){
//                    return
//                }
//            }
//            if let imgCH = gameScene.imgCH{
//                location.x += imgCH.size.width / 2
//                location.y -= imgCH.size.height / 2
//                location.y += 30.0
//            }
//            let node = gameScene.atPoint(location)
//            if(node == gameScene.medkitPickup || node.parent == gameScene.medkitPickup){
//                gameScene.health += 25.0
//                gameScene.prgBar.setProgress(gameScene.health / 100.0)
//                gameScene.medkitPickup?.run(SKAction.group([SKAction.fadeAlpha(to: (gameScene.health >= 100.0 ? 0.0 : 1.0), duration: 2.0), SoundManager.healthPickupSound]), completion: {
//                    if(gameScene.health >= 100.0){
//                        gameScene.medkitPickup?.alpha = 0.0
//                    }
//                })
//                return
//            }
//
//            if(gameScene.syringesLeft <= 0){
//                return
//            }
//            var pointIn = event.location(in: gameScene.bg!)
//            if let imgCH = gameScene.imgCH{
//                pointIn.x += imgCH.size.width / 2
//                pointIn.y -= imgCH.size.height / 2
//            }
//            gameScene.runHandThrowingAnimation()
//            gameScene.syringe?.isHidden = false
//            gameScene.syringesLeft -= 1
//            gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
//            if(gameScene.syringesLeft == 1){
//                gameScene.syringe2?.isHidden = true
//            }else if(gameScene.syringesLeft == 0){
//                gameScene.syringe1?.isHidden = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
//
//                    let newX:CGFloat = CGFloat.random(in: ((self.frame.width / -2) + 20) ... ((self.frame.width / 2) - 20))
//                    let newY:CGFloat = (gameScene.syringePickup?.position.y)!
//
//                    gameScene.syringePickup?.position = CGPoint(x: newX, y: newY)
//                    gameScene.syringePickup?.alpha = 1.0
//                }
//            }
//            gameScene.syringe?.position = CGPoint(x: 0, y: -300)
//            gameScene.syringe?.scale(to: CGSize(width: 64, height: 64))
//            if(UserDefaultsHelper.playSounds){
//                self.scene?.run(SoundManager.shotSound)
////                SoundManager.playAudio(audioName: "throwing-whip")
//            }
//            gameScene.syringe?.speed = UserDefaultsHelper.speedMultiplierForDifficulty
//            gameScene.syringe?.run(
//                SKAction.group([
//                    SKAction.move(to: pointIn, duration: 0.5),
//                    SKAction.scale(to: 0.5, duration: 0.5)
//                ])
//            )
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                gameScene.syringe?.isHidden = true
//            }
//        }
        
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("touchUp")
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
}
