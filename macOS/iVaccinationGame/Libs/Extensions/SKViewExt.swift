//
//  SkViewExt.swift
//  SkViewExt
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

extension SKView {
    
    open override func mouseDown(with event: NSEvent) {
        if let menuScene = (self.scene as? MenuScene){
            menuScene.mouseDown(with: event)
            return
        }
        if let gameScene = (self.scene as? GameScene){
            super.mouseDown(with: event)
            
            if(!gameScene.gameRunning){
                gameScene.restartAfterGameOverNG()
                return
            }
            var location = event.location(in: gameScene.bg!)
            
            if(gameScene.syringesLeft <= 0){
                location.y -= 30.0
                if let imgCH = gameScene.imgCH{
                    location.x += imgCH.size.width / 2
                    location.y -= imgCH.size.height / 2
                }
                let node = gameScene.atPoint(location)
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
            if let imgCH = gameScene.imgCH{
                location.x += imgCH.size.width / 2
                location.y -= imgCH.size.height / 2
            }
            let node = gameScene.atPoint(location)
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
            
            if(gameScene.syringesLeft <= 0){
                return
            }
            var pointIn = event.location(in: gameScene.bg!)
            if let imgCH = gameScene.imgCH{
                pointIn.x += imgCH.size.width / 2
                pointIn.y -= imgCH.size.height / 2
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
                    let newY:CGFloat = (gameScene.syringePickup?.position.y)!
                    
                    gameScene.syringePickup?.position = CGPoint(x: newX, y: newY)
                    gameScene.syringePickup?.alpha = 1.0
                }
            }
            gameScene.syringe?.position = CGPoint(x: 0, y: -300)
            gameScene.syringe?.scale(to: CGSize(width: 64, height: 64))
            if(UserDefaultsHelper.playSounds){
                self.scene?.run(SoundManager.shotSound)
            }
            gameScene.syringe?.speed = UserDefaultsHelper.speedMultiplierForDifficulty
            gameScene.syringe?.run(
                SKAction.group([
                    SKAction.move(to: pointIn, duration: 0.5),
                    SKAction.scale(to: 0.5, duration: 0.5)
                ])
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameScene.syringe?.isHidden = true
            }
        }
    }
}

extension SKView {
    override open func resetCursorRects() {
        if let gameScene = (self.scene as? GameScene){
            gameScene.imgCH = self.resize(image: NSImage(named:NSImage.Name("CH_first_red.png"))!, w: 64, h: 64)
            let image = gameScene.imgCH
            let spot = NSPoint(x: 0, y: 0)
            let customCursor = NSCursor(image: image!, hotSpot: spot)
            addCursorRect(visibleRect, cursor:customCursor)
        }
    }

    func resize(image: NSImage, w: Int, h: Int) -> NSImage {
        let destSize = NSMakeSize(CGFloat(w), CGFloat(h))
        let newImage = NSImage(size: destSize)
        newImage.lockFocus()
        image.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = destSize
        return NSImage(data: newImage.tiffRepresentation!)!
    }
}
