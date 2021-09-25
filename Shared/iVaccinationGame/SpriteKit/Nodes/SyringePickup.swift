//
//  SyringePickup.swift
//  SyringePickup
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class SyringePickup: BasePickupNode {
    
    init(){
        super.init(imageNamed: "Syringe", emitterFileNamed: "UpwardParticles.sks", size: CGSize(width: 76.8, height: 76.8))
    }
    
    override func pickedUp(){
        super.pickedUp()
        if let gameScene = self.scene as? GameScene{
            self.alpha = 0.0
            
            SoundManager.shared.playSound(sound: .syringePickup)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameScene.syringesLeft = 2
                gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
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
