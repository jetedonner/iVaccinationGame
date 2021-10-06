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
    
    init(pickupManager:PickupManagerBase, pickupType:SyringePickupType = .two, vaccineType:VaccineType = .Perofixa){
        self.pickupType = pickupType
        self.vaccineType = vaccineType
        super.init(pickupManager:pickupManager, imageNamed: (self.vaccineType == .JnJ ? "SyringeGreen" : "SyringeYellow"), emitterFileNamed: "UpwardParticles.sks", size: CGSize(width: 76.8, height: 76.8))
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
                gameScene.player.vaccineArsenal.addVaccine(accineType: self.vaccineType, ammount: self.pickupType.rawValue)
                gameScene.setSyringesHUD()
                gameScene.syringe2?.isHidden = false
                gameScene.syringe1?.isHidden = false
                gameScene.updateThrowingHandTexture()
                if(!gameScene.player.hasSyringes){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        gameScene.syringePickupManager.addPickupToScene()// .addPickupToScene(newPickup: gameScene.syringePickupManager.getPickup()!)
                    }
                }else{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(self.pickupManager.respawnRange.randomElement()!), execute: {
                        self.pickupManager.addPickupToScene()// .addPickupToScene(newPickup: self.pickupManager.getPickup()!)
                    })
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
