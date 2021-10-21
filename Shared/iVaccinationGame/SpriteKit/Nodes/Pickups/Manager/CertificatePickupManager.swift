//
//  CertificatePickupManager.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 03.10.21.
//

import Foundation
import SpriteKit

class CertificatePickupManager:PickupManagerBase{
    
    var generatedCerts:Int = 0
    var certPickups:[CertificatePickup] = []
    
    init(gameScene:GameSceneBase){
        super.init(gameScene: gameScene, removeAfterTimeOut: true)
        self.removeTimeoutRange = 7...15
        self.respawnRange = gameScene.currentLevel.currentLevelConfig.certificateRespawnTimeRange //4...10
    }
    
    override func getPickup()->BasePickupNode?{
        return CertificatePickup(pickupManager: self)
    }
    
    override func addPickupToScene(newPickup:BasePickupNode){
        super.addPickupToScene(newPickup: newPickup)
        self.generatedCerts += 1
//        self.pickupsOnScene += 1
//        self.pickups.append(newPickup)
//        self.gameScene.addChild(newPickup)
//        newPickup.genNewPos(overridePos: CGPoint(x: -101, y: -349))
//        newPickup.zPosition = 10001
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
