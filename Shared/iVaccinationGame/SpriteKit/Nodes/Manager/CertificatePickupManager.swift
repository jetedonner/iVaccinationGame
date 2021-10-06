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
    
//    override func addPickupToSceneNG(pickupManager:PickupManagerBase)->BasePickupNode?{
//        
//        return super.addPickupToSceneNG(newPickup: CertificatePickup(pickupManager: self))
////        for _ in 0..<self.gameScene.currentLevel.currentLevelConfig.certificatePickupsAtOnce{
////            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(self.respawnRange.randomElement()!), execute: {
//////                super.addPickupToScene(newPickup: CertificatePickup())
////                _ = super.addPickupToScene(newPickup: CertificatePickup())
////            })
////        }
////        return super.addPickupToScene(newPickup: CertificatePickup())
//    }
    
//    override func addPickupToScene()->BasePickupNode?{
//        for _ in 0..<self.gameScene.currentLevel.currentLevelConfig.certificatePickupsAtOnce{
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(self.respawnRange.randomElement()!), execute: {
////                super.addPickupToScene(newPickup: CertificatePickup())
//                _ = super.addPickupToScene(newPickup: CertificatePickup())
//            })
//        }
//        return super.addPickupToScene(newPickup: CertificatePickup())
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
