//
//  SKSpriteNodeExt.swift
//  SKSpriteNodeExt
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

extension SKSpriteNode{
    func addDbgBorder(){
        let boundingBoxNode = SKShapeNode(rectOf: self.calculateAccumulatedFrame().size)
        boundingBoxNode.lineWidth = 3
        boundingBoxNode.strokeColor = .red
        boundingBoxNode.fillColor = .clear
        boundingBoxNode.path = boundingBoxNode.path?.copy(dashingWithPhase: 0, lengths: [10,10])
        self.addChild(boundingBoxNode)
    }
}
