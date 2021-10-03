//
//  CertificatePickupManager.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 03.10.21.
//

import Foundation
import SpriteKit

class CertificatePickupManager:PickupManagerBase{
    
    var certPickups:[CertificatePickup] = []
    
    init(gameScene:GameSceneBase){
        super.init(gameScene: gameScene, removeAfterTimeOut: true)
        self.removeTimeoutRange = 5...15
        self.respawnRange = 4...15
    }
    
    override func addPickupToScene()->BasePickupNode?{
        return super.addPickupToScene(newPickup: CertificatePickup())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
