//
//  SKLocationNode.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 07.10.21.
//

import Foundation
import SpriteKit

class SKLocationNode{
    
    let imgNode:SKSpriteNode
    var circle:SKShapeNode!
    
    var _showCircle:Bool!
    var showCircle:Bool{
        get{ return self._showCircle }
        set{ self._showCircle = newValue }
    }
    
    init(imgNode:SKSpriteNode, showCircle:Bool = false){
        self.imgNode = imgNode
        self.showCircle = showCircle
        self.addCircle()
        if(!self.showCircle){
            self.circle.isHidden = !self.showCircle
        }
    }
    
    func addCircle(){
        self.circle = SKShapeNode(ellipseOf: CGSize(width: 130, height: 80)) // Create circle
        circle.position = CGPoint(x: 0, y: 0)  // Center (given scene anchor point is 0.5 for x&y)
        circle.strokeColor = SKColor.black
        circle.glowWidth = 1.0
        let bgColor:SKColor = SKColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.45)
        circle.fillColor = bgColor
        self.imgNode.addChild(circle)
        circle.run(SKAction.repeatForever(SKAction.sequence([SKAction.group([SKAction.scale(to: 1.2, duration: 0.75), SKAction.fadeAlpha(to: 0.25, duration: 0.75)]), SKAction.group([SKAction.scale(to: 1.0, duration: 0.0), SKAction.fadeAlpha(to: 1.0, duration: 0.0)])])))
    }
}
