//
//  SyringePickup.swift
//  SyringePickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class SyringePickup: BasePickupNode {
    
    init(){
        super.init(imageNamed: "Syringe", emitterFileNamed: "UpwardParticles.sks", size: CGSize(width: 76.8, height: 76.8))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
