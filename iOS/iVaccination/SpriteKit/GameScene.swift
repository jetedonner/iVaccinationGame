//
//  GameScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 16.09.21.
//

import SpriteKit
import GameplayKit

class GameScene: GameSceneBase {
    
    var chTimeout:TimeInterval = 0.75
    var chScale:CGFloat = 1.65
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
        super.touchOrClick(pos: pos, viewController: viewController)
        if let gameScene = (self.scene as? GameScene){

            if(!gameScene.gameRunning && gameScene.waitForAnyKey){
                gameScene.clickedAtPoint(point: pos)
                return
            }
            
            self.chIOS.zPosition = 999
            self.chIOS.position = pos
            self.chIOS.setScale(0.75)
            self.chIOS.alpha = 1.0
            self.chIOS.run(SKAction.group([SKAction.scale(to: self.chScale, duration: self.chTimeout), SKAction.fadeAlpha(to: 0.0, duration: self.chTimeout)]))

            gameScene.clickedAtPoint(point: pos)
        }
    }
}
