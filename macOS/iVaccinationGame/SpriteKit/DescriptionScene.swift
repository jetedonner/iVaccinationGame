//
//  DescriptionScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class DescriptionScene: DescriptionSceneBase {
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
        var newSelNode:SKLabelNode?

        if(node == self.lblContinue){
            newSelNode = self.lblContinue
        }else{
            return
        }

        if(newSelNode != self.selNode){
            self.selNode = newSelNode
            SoundManager.shared.playSound(sound: .menuHighlite)
        }
    }
}
