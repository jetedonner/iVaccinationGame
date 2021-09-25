//
//  MedKitPickup.swift
//  MedKitPickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class CertificatePickup: BasePickupNode {
    
    init(){
        super.init(imageNamed: "CertificatePickup", emitterFileNamed: "Upward3Particles.sks")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
