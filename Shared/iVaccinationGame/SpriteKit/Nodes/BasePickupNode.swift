//
//  BasePickupNode.swift
//  BasePickupNode
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

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
        }
    }
    
    var _upwardEmitterNode = SKEmitterNode(fileNamed:"UpwardParticles.sks")
    var upwardEmitterNode:SKEmitterNode{
        get { return self._upwardEmitterNode! }
    }
    
    init(imageNamed name: String, emitterFileNamed: String) {
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        self._upwardEmitterNode = SKEmitterNode(fileNamed: emitterFileNamed)
        self.upwardEmitterNode.setScale(0.15)
        self.upwardEmitterNode.position.y += 30.0
        if(UserDefaultsHelper.devMode){
            self.addDbgBorder()
        }
        self.addChild(self.upwardEmitterNode)
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let frm = self.frame
        let newSize:CGSize = CGSize(width: frm.size.width * self.accumulatedFrameFactor, height: frm.size.height * self.accumulatedFrameFactor)
        return CGRect(x: frm.origin.x , y: frm.origin.y, width: newSize.width, height: newSize.height)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
