//
//  MedKitPickup.swift
//  MedKitPickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class MedKitPickup: BasePickupNode {
    
    init(){
        super.init(imageNamed: "MedicinePickup", emitterFileNamed: "Upward2Particles.sks")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
