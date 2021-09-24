//
//  SyringePickup.swift
//  SyringePickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class SyringePickup: BasePickupNode {
    
//    override var accumulatedFrameFactor:CGFloat{
//        get { return 0.8 }
//    }
    
    init(imageNamed name: String, emitterFileNamed: String){
        super.init(imageNamed: name, emitterFileNamed: emitterFileNamed, size: CGSize(width: 76.8, height: 76.8))
    }
    
    
//    #if os(iOS)
//    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//    }
//    #else
//    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
//        super.init(texture: texture, color: color, size: size)
//    }
//    #endif
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
