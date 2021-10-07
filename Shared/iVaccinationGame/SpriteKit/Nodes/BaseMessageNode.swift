//
//  BaseMessageNode.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 26.09.21.
//

import Foundation
import SpriteKit


//enum MessageNodeType:String{
//    case scrore = "Score"
//}

class BaseMessageNode: SKLabelNode {
    
//    let messageType:MessageNodeType
    let fadeOutTime:TimeInterval = 1.5
    
    init(text:String, node:SKNode/*, messageType:MessageNodeType = .scrore*/) {
//        self.messageType = messageType
        super.init()
        self.fontColor = SKColor.init(named: "mainAccent")
        self.fontName = "Helvetica Neue Medium"
        self.fontSize = 42.0
        self.addMessageToNode(msg: text, node: node)
    }
    
    func addMessageToNode(msg:String, node:SKNode){
        self.text = msg
        self.zPosition = 1000
        self.setScale(1.0)
        self.position = CGPoint(x: node.position.x, y: node.position.y + node.frame.height / 2 + 20)
        self.alpha = 1.0
        node.parent?.addChild(self)
        self.run(
            SKAction.group([
                SKAction.move(by: CGVector(dx: 0, dy: 150), duration: self.fadeOutTime),
                SKAction.fadeOut(withDuration: self.fadeOutTime),
                SKAction.scale(to: 0.25, duration: self.fadeOutTime)
            ]),
            completion: {
                self.removeFromParent()
            }
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
