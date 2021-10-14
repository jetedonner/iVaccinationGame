//
//  DescriptionScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class HighscoreScene: CreditsSceneBase {
    
    var colorAccent:SKColor = SKColor.init(named: "mainAccent")!
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
        var newSelNode:SKNode?

        if(node == self.lblContinue){
            newSelNode = self.lblContinue
            self.lblContinue?.fontColor = self.colorAccent
        }else{
            newSelNode = self.bg
            self.lblContinue?.fontColor = .white
//            return
        }

        if(newSelNode != self.selNode && newSelNode == self.lblContinue){
            self.selNode = newSelNode
            SoundManager.shared.playSound(sound: .menuHighlite)
        }else{
            self.selNode = newSelNode
        }
    }
}
