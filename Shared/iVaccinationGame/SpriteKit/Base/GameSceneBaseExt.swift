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
        self.lblMessage?.alpha = 1.0
        self.lblMessage?.run(SKAction.sequence([SKAction.wait(forDuration: 2.5), SKAction.fadeAlpha(to: 0.0, duration: 0.5)]))
    }
    
    func addScore(score:Int){
        self.score += score
        self.lblScore?.text = self.score.description + " Points"
        self.lblScore?.run(SKAction.scale(by: 1.5, duration: 0.35),completion: {
            self.lblScore?.xScale = 1.0
            self.lblScore?.yScale = 1.0
        })
    }
    
    func showEarnedPoints(score:Int = 100, onNode:SKNode? = nil){
        var aboveNode:SKNode? = onNode
        if(aboveNode == nil){
            aboveNode = self.zombieGirl
        }
        let earnedMsg:BaseMessageNode = BaseMessageNode(text: "+\(score) Points", node: aboveNode!, messageType: .scrore)

//        self.lblEarnedPoints.text = "+ \(score) Points"
//        self.lblEarnedPoints.removeAllActions()
//        self.lblEarnedPoints.zPosition = 1000
//        self.lblEarnedPoints.setScale(1.0)
//        self.lblEarnedPoints.position = CGPoint(x: aboveNode!.position.x, y: aboveNode!.position.y + (aboveNode!.frame.height / 2) + 20)
//        self.lblEarnedPoints.alpha = 1.0
//        self.lblEarnedPoints.run(SKAction.group([SKAction.move(by: CGVector(dx: 0, dy: 150), duration: self.earnedPointLblTime), SKAction.fadeOut(withDuration: self.earnedPointLblTime), SKAction.scale(to: 0.25, duration: self.earnedPointLblTime)]))
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
        if(self.syringesLeft <= 0){
            self.imgThrowingHand?.texture = self.emptyHands
        }else{
            self.imgThrowingHand?.texture = self.fullHands
        }
    }
}
