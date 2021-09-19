//
//  SKSpriteNodeExt.swift
//  SKSpriteNodeExt
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    
    func drawBorder(color: NSColor, width: CGFloat) {
        let shapeNode = SKShapeNode(rect: frame)
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = color
        shapeNode.lineWidth = width
        addChild(shapeNode)
    }
}
