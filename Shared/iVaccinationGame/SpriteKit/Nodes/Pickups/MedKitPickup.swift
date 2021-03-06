//
//  MedKitPickup.swift
//  MedKitPickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class MedKitPickup: BasePickupNode {
    
    init(){
        super.init(imageNamed: "MedicinePickup", emitterFileNamed: "Upward2Particles.sks")
        self.pickupScore = 25
    }
    
    override func pickedUp(afterTimeOut:Bool = false){
        super.pickedUp(afterTimeOut: afterTimeOut)
        if let gameScene = self.scene as? GameScene{
            gameScene.player.pickedUpMedKit(healValue: 25.0)
            gameScene.prgBar.setProgress(gameScene.player.health / 100.0)
            gameScene.addScore(score: self.pickupScore)
            gameScene.showEarnedPoints(score: self.pickupScore, onNode: self)
            
            SoundManager.shared.playSound(sound: .healthPickup)

            self.run(SKAction.group([SKAction.fadeAlpha(to: (gameScene.player.health >= 100.0 ? 0.0 : 1.0), duration: 0.1)]), completion: {
                if(gameScene.player.health >= 100.0){
                    self.alpha = 0.0
                }
            })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
