//
//  MedKitPickup.swift
//  MedKitPickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class MedKitPickup: BasePickupNode {
    
    override var accumulatedFrameFactor:CGFloat{
        get { return 1.9 }
    }
    
    override init(imageNamed name: String, emitterFileNamed: String){
        super.init(imageNamed: name, emitterFileNamed: emitterFileNamed)
    }
    
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: SKTexture(imageNamed: "MedicinePickup"), color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
