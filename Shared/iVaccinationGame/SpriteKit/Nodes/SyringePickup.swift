//
//  SyringePickup.swift
//  SyringePickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

enum SyringePickupType:Int{
    case one = 1
    case two = 2
    case four = 4
    case six = 6
}

class SyringePickup: BasePickupNode {
    
    let pickupType:SyringePickupType
    let vaccineType:VaccineType
    
    init(pickupType:SyringePickupType = .two, vaccineType:VaccineType = .Perofixa){
        self.pickupType = pickupType
        self.vaccineType = vaccineType
        super.init(imageNamed: (self.vaccineType == .JnJ ? "SyringeGreen" : "SyringeYellow"), emitterFileNamed: "UpwardParticles.sks", size: CGSize(width: 76.8, height: 76.8))
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
                gameScene.player.vaccineArsenal.addVaccine(accineType: self.vaccineType, ammount: self.pickupType.rawValue)
                gameScene.setSyringesHUD()
//                gameScene.syringesLeft += self.pickupType.rawValue
//                gameScene.setSyringesLeft(syringesLeft: gameScene.syringesLeft)
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
