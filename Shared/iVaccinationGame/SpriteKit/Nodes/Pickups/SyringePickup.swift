//
//  SyringePickup.swift
//  SyringePickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class SyringePickup: BasePickupNode {
    
    let pickupType:SyringePickupType
    let vaccineType:VaccineType
    
    init(pickupManager:PickupManagerBase, pickupType:SyringePickupType = .one, vaccineType:VaccineType = .Perofixa){
        self.pickupType = pickupType
        self.vaccineType = vaccineType
        var textureImage:String = "Syringe"
        switch pickupType {
        case .one:
            textureImage = "Syringe"
        case .two:
            textureImage = "SyringeX2"
        case .three:
            textureImage = "SyringeX3"
//        default:
//            textureImage = "Syringe"
        }
        super.init(pickupManager:pickupManager, imageNamed: (self.vaccineType == .JnJ ? "SyringeGreen" : textureImage/* "SyringeYellow"*/), emitterFileNamed: "UpwardParticles.sks", size: CGSize(width: 76.8, height: 76.8))
        self.pickupScore = 50
    }
    
    func pickedUp(){
        self.pickedUp(afterTimeOut: false)
    }
    
    override func pickedUp(afterTimeOut:Bool = false){
        if let gameScene = self.scene as? GameScene{
            gameScene.showEarnedPoints(score: self.pickupScore, onNode: self)
            super.pickedUp(afterTimeOut: afterTimeOut)
            self.alpha = 0.0

            SoundManager.shared.playSound(sound: .syringePickup)

            gameScene.addScore(score: self.pickupScore)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameScene.player.vaccineArsenal.addVaccine(accineType: self.vaccineType, ammount: self.pickupType.rawValue * self.vaccineType.pickupMultiplyer)
                gameScene.setSyringesHUD()
                gameScene.syringe2?.isHidden = false
                gameScene.syringe1?.isHidden = false
                gameScene.updateThrowingHandTexture()
                if(!gameScene.player.hasSyringes){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        gameScene.syringePickupManager.addPickupToScene()
                    }
                }else{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(self.pickupManager.respawnRange.randomElement()!), execute: {
                        self.pickupManager.addPickupToScene()
                    })
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
