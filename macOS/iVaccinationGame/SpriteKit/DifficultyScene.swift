//
//  DifficultyScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class DifficultyScene: DifficultySceneBase {
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
        var newSelNode:SKLabelNode?
        
        if([
            self.lblEasy,
            self.lblMedium,
            self.lblHard,
            self.lblNightmare,
            self.lblBack
        ].contains(node)){
            newSelNode = node as? SKLabelNode
        }else{
            return
        }
        
        if(newSelNode != self.selNode){
            self.selNode = newSelNode
            if(self.selNode == self.lblEasy){
                self.lblEasy?.fontColor = self.lblColor
                self.lblMedium?.fontColor = .white
                self.lblHard?.fontColor = .white
                self.lblNightmare?.fontColor = .white
                self.lblBack?.fontColor = .white
            }else if(self.selNode == self.lblMedium){
                self.lblEasy?.fontColor = .white
                self.lblHard?.fontColor = .white
                self.lblNightmare?.fontColor = .white
                self.lblMedium?.fontColor = self.lblColor
                self.lblBack?.fontColor = .white
            }else if(self.selNode == self.lblHard){
                self.lblEasy?.fontColor = .white
                self.lblHard?.fontColor = self.lblColor
                self.lblNightmare?.fontColor = .white
                self.lblMedium?.fontColor = .white
                self.lblBack?.fontColor = .white
            }else if(self.selNode == self.lblNightmare){
                self.lblEasy?.fontColor = .white
                self.lblNightmare?.fontColor = self.lblColor
                self.lblHard?.fontColor = .white
                self.lblMedium?.fontColor = .white
                self.lblBack?.fontColor = .white
            }else if(self.selNode == self.lblBack){
                self.lblEasy?.fontColor = .white
                self.lblNightmare?.fontColor = .white
                self.lblHard?.fontColor = .white
                self.lblMedium?.fontColor = .white
                self.lblBack?.fontColor = self.lblColor
            }
            
            SoundManager.shared.playSound(sound: .menuHighlite)
        }
    }
}
