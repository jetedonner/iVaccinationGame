//
//  BasePickupNode.swift
//  BasePickupNode
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

class BasePickupNode: SKSpriteNode {
    
    var accumulatedFrameFactor:CGFloat{
        get {
            switch UserDefaultsHelper.difficulty{
            case .easy:
                return 1.25
            case .medium:
                return 1.0
            case .hard:
                return 0.75
            case .nightmare:
                return 0.5
            }
//            return 1.0
        }
    }
    
    var _upwardEmitterNode = SKEmitterNode(fileNamed:"UpwardParticles.sks")
    var upwardEmitterNode:SKEmitterNode{
        get { return self._upwardEmitterNode! }
    }
    
    public init(imageNamed name: String, emitterFileNamed: String){
        self.init(imageNamed: name)
        self._upwardEmitterNode = SKEmitterNode(fileNamed: emitterFileNamed)
        self.upwardEmitterNode.setScale(0.15)
        self.upwardEmitterNode.position.y += 30.0
        self.addChild(self.upwardEmitterNode)
    }
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let frm = self.frame
        let newSize:CGSize = CGSize(width: frm.size.width * self.accumulatedFrameFactor, height: frm.size.height * self.accumulatedFrameFactor)
        return CGRect(x: frm.origin.x , y: frm.origin.y, width: newSize.width, height: newSize.height)
    }
    
//    func addDbgBorder(){
//        let boundingBoxNode = SKShapeNode(rectOf: self.calculateAccumulatedFrame().size)
//        boundingBoxNode.lineWidth = 3
//        boundingBoxNode.strokeColor = .red
//        boundingBoxNode.fillColor = .clear
//        boundingBoxNode.path = boundingBoxNode.path?.copy(dashingWithPhase: 0, lengths: [10,10])
//        self.addChild(boundingBoxNode)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
