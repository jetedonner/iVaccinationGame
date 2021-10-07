//
//  GameSceneBaseExt.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import SpriteKit

extension GameSceneBase{
    
    func showMessage(msg:String){
        self.lblMessage?.text = msg
        self.lblMessage?.isHidden = false
        self.lblMessage?.alpha = 1.0
        self.lblMessage?.run(SKAction.sequence([SKAction.wait(forDuration: 2.5), SKAction.fadeAlpha(to: 0.0, duration: 0.5)]))
    }
    
    func addCert(certCount:Int = 1){
//        self.player.addCert(cerCount: certCount)
        self.player.pickedUpCert()
        self.lblCerts?.text = self.player.certsPickedUp.description + " Certs"
        self.lblCerts?.run(SKAction.scale(by: 1.15, duration: 0.35),completion: {
            self.lblCerts?.xScale = 1.0
            self.lblCerts?.yScale = 1.0
        })
    }
    
    func addScore(score:Int){
        self.player.addScore(score: score)
        self.lblScore?.text = self.player.score.description + " Points"
        self.lblScore?.run(SKAction.scale(by: 1.15, duration: 0.35),completion: {
            self.lblScore?.xScale = 1.0
            self.lblScore?.yScale = 1.0
        })
    }
    
    func showEarnedPoints(score:Int = 100, onNode:SKNode? = nil){
//        let aboveNode:SKNode? = onNode
        _ = BaseMessageNode(text: "+\(score) Points", node: onNode!)
    }
    
    func runHandThrowingAnimation(){
        self.imgThrowingHand?.removeAllActions()
        let throwAct:SKAction = SKAction.group([SKAction.rotate(byAngle: 1.6, duration: 0.25), SKAction.moveBy(x: -20, y: -200, duration: 0.25)])
        self.imgThrowingHand?.run(throwAct, completion: {
            self.imgThrowingHand?.zRotation = self.handInitRot!
            self.imgThrowingHand?.position = self.handInitPos!
            self.setupHandAnimation()
        })
    }
    
    func setupHandAnimation(){
        let oneLoop:SKAction = SKAction.sequence([SKAction.group([SKAction.rotate(byAngle: -0.1, duration: 0.5), SKAction.move(by: CGVector(dx: 0, dy: -10), duration: 0.5)]), SKAction.group([SKAction.rotate(byAngle: 0.1, duration: 0.5), SKAction.move(by: CGVector(dx: 0, dy: 10), duration: 0.5)])])
        oneLoop.timingMode = .easeInEaseOut
        self.imgThrowingHand?.run(SKAction.repeatForever(SKAction.sequence([SKAction.repeat(oneLoop, count: 2), SKAction.wait(forDuration: 0.35), SKAction.repeat(oneLoop, count: 2), SKAction.wait(forDuration: 0.15)])))
    }
    
    func updateThrowingHandTexture(){
        if(!self.player.hasSyringes){
            self.imgThrowingHand?.texture = self.emptyHands
        }else{
            self.imgThrowingHand?.texture = self.fullHands
        }
    }
}
