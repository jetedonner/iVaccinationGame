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
        super.init(imageNamed: "CertificatePickup", emitterFileNamed: "Upward3Particles.sks")
    }
    
    override func pickedUp(){
        super.pickedUp()
        if let gameScene = self.scene as? GameScene{
            SoundManager.shared.playSound(sound: .certPickup)
            self.isHidden = true
            gameScene.addScore(score: 50)
            gameScene.showEarnedPoints(score: 50, onNode: self)
            DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + Double(gameScene.currentLevel.certRespawnRange.randomElement()!), execute: {
                self.genNewPos()
                self.isHidden = false
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
