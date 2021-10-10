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
    
    override func addPickupToScene(){
        super.addPickupToScene()
//        if(self.pickupsOnScene < self.pickupsAtOnce && !self.paused){
//            self.addPickupToScene(newPickup: self.getPickup()!)
//        }
    }
    
    override func getPickup()->BasePickupNode?{
        let pickupType:SyringePickupType = SyringePickupType.allCases.getRandom()
        return SyringePickup(pickupManager: self, pickupType: pickupType, vaccineType: .Perofixa)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
