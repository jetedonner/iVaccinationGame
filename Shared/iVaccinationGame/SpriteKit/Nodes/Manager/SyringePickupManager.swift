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
        super.init(gameScene: gameScene, removeAfterTimeOut: true)
        self.removeTimeoutRange = 7...15
        self.respawnRange = 4...10
    }
    
    override func addPickupToScene()->BasePickupNode?{
        for _ in 0..<self.gameScene.currentLevel.currentLevelConfig.syringePickupsAtOnce{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(self.respawnRange.randomElement()!), execute: {
//                super.addPickupToScene(newPickup: CertificatePickup())
                _ = super.addPickupToScene(newPickup: SyringePickup())
            })
        }
        return super.addPickupToScene(newPickup: SyringePickup())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
