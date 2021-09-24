//
//  MedKitPickup.swift
//  MedKitPickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class MedKitPickup: BasePickupNode {
    
    init(imageNamed name: String, emitterFileNamed: String){
        super.init(imageNamed: name, emitterFileNamed: emitterFileNamed)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
