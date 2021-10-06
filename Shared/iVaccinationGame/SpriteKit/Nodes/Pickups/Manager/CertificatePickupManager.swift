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
        self.removeTimeoutRange = 7...15
        self.respawnRange = 4...10
    }
    
    override func getPickup()->BasePickupNode?{
        return CertificatePickup(pickupManager: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
