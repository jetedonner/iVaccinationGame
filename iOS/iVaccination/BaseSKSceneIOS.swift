//
//  BaseSKSceneIOS.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

extension BaseSKScene{
    
    func touchDown(atPoint pos : CGPoint) {
        print("touchDown")
        self.touchOrClick(pos: pos)
//        if let gameScene = (self.scene as? GameScene){
//
//            if(!gameScene.gameRunning && gameScene.waitForAnyKey){
//                gameScene.restartAfterGameOverNG()
//                return
//            }
//            self.chIOS.zPosition = 999
//            self.chIOS.position = pos
//            self.chIOS.setScale(0.75)
//            self.chIOS.alpha = 1.0
//            self.chIOS.run(SKAction.group([SKAction.scale(to: 1.45, duration: self.chTimeout), SKAction.fadeAlpha(to: 0.0, duration: self.chTimeout)]))
//
//
//            gameScene.clickedAtPoint(point: pos)
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
