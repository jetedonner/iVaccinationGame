//
//  DescriptionScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class WelcomeScene: WelcomeSceneBase {
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
        var newSelNode:SKNode?

        if(node == self.lblContinue){
            newSelNode = self.lblContinue
        }else if(node == self.chkDontShow){
            newSelNode = self.chkDontShow
        }else{
            return
        }

        if(newSelNode != self.selNode){
            self.selNode = newSelNode
            SoundManager.shared.playSound(sound: .menuHighlite)
        }
    }
}
