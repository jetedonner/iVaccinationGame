//
//  SyringePickup.swift
//  SyringePickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

enum SyringePickupType:Int{
    case two = 2
    case four = 4
    case six = 6
}

class SyringePickup: BasePickupNode {
    
    let pickupType:SyringePickupType
    
    init(pickupType:SyringePickupType = .two){
        self.pickupType = pickupType
        super.init(imageNamed: "Syringe", emitterFileNamed: "UpwardParticles.sks", size: CGSize(width: 76.8, height: 76.8))
        self.pickupScore = 25
    }
    
    override func pickedUp(){
        super.pickedUp()
        if let gameScene = self.scene as? GameScene{
            self.alpha = 0.0
            
            SoundManager.shared.playSound(sound: .syringePickup)
            
            gameScene.addScore(score: self.pickupScore)
            gameScene.showEarnedPoints(score: self.pickupScore, onNode: self)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameScene.syringesLeft += self.pickupType.rawValue
                gameScene.setSyringesLeft(syringesLeft: gameScene.syringesLeft)
                gameScene.syringe2?.isHidden = false
                gameScene.syringe1?.isHidden = false
                gameScene.updateThrowingHandTexture()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
