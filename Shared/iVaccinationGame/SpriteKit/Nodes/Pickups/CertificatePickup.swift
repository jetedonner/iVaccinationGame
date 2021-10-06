//
//  MedKitPickup.swift
//  MedKitPickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class CertificatePickup: BasePickupNode {
    
    init(pickupManager:PickupManagerBase){
        super.init(pickupManager:pickupManager, imageNamed: "CertificatePickup", emitterFileNamed: "Upward3Particles.sks", size: CGSize(width: 64, height: 64))
        self.pickupScore = 50
    }
    
    func pickedUp(){
        self.pickedUp(afterTimeOut: false)
    }
    
    override func pickedUp(afterTimeOut:Bool = false){
        if let gameScene = self.scene as? GameScene{
            if(!afterTimeOut){
                gameScene.showEarnedPoints(score: self.pickupScore, onNode: self)
            }
            super.pickedUp(afterTimeOut: afterTimeOut)
            self.isHidden = true
            if(!afterTimeOut){
                SoundManager.shared.playSound(sound: .certPickup)
                gameScene.player.pickedUpCert()
                gameScene.addCert()
                gameScene.addScore(score: self.pickupScore)
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(gameScene.currentLevel.certRespawnRange.randomElement()!), execute: {
                self.pickupManager.addPickupToScene()
            })
        }
    }
    
    override func startTimeout(){
        super.startTimeout()
        if let gameScene = self.scene as? GameScene{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(gameScene.currentLevel.certLifetimeRange.randomElement()!), execute: {
                if(self.timeOutRunning){
                    self.pickedUp(afterTimeOut: true)
                }
            })
        }
    }
    
    override func abortTimeout(){
        super.abortTimeout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
