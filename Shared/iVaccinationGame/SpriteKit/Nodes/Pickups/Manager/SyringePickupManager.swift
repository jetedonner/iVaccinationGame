//
//  CertificatePickupManager.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 03.10.21.
//

import Foundation
import SpriteKit

class SyringePickupManager:PickupManagerBase{
    
    var syringePickups:[SyringePickup] = []
    
    init(gameScene:GameSceneBase){
        super.init(gameScene: gameScene, removeAfterTimeOut: false)
        self.removeTimeoutRange = 7...15
        self.respawnRange = 4...10
    }
    
    override func getPickup()->BasePickupNode?{
        return SyringePickup(pickupManager: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
