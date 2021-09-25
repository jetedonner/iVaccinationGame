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
        self.upwardEmitterNode.isHidden = false
    }
    
    func pickedUp(){
        self.upwardEmitterNode.isHidden = false
//        self.scene?.run(SoundManager.certPickupSound)
        SoundManager.shared.playSound(sound: .certPickup)
        self.genNewPos()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
