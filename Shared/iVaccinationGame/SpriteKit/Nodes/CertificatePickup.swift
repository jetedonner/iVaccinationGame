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
        super.init(imageNamed: "CertificatePickup", emitterFileNamed: "Upward3Particles.sks", size: CGSize(width: 64, height: 64))
        self.pickupScore = 50
    }
    
    override func pickedUp(){
        self.pickedUp(afterTimeOut: false)
    }
    
    func pickedUp(afterTimeOut:Bool = false){
        super.pickedUp()
        if let gameScene = self.scene as? GameScene{
            self.isHidden = true
            if(!afterTimeOut){
                SoundManager.shared.playSound(sound: .certPickup)
                gameScene.player.pickedUpCert()
                gameScene.addCert()
                gameScene.addScore(score: self.pickupScore)
                gameScene.showEarnedPoints(score: self.pickupScore, onNode: self)
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(gameScene.currentLevel.certRespawnRange.randomElement()!), execute: {
                self.genNewPos()
                self.isHidden = false
                self.startTimeout()
            })
        }
    }
    
    override func startTimeout(){
        if let gameScene = self.scene as? GameScene{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(gameScene.currentLevel.certLifetimeRange.randomElement()!), execute: {
                self.pickedUp(afterTimeOut: true)
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
