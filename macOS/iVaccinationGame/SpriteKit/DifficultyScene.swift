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
        
        if(node == self.lblEasy){
            newSelNode = self.lblEasy
        }else if(node == self.lblMedium){
            newSelNode = self.lblMedium
        }else if(node == self.lblHard){
            newSelNode = self.lblHard
        }else if(node == self.lblNightmare){
            newSelNode = self.lblNightmare
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
            }else if(self.selNode == self.lblMedium){
                self.lblEasy?.fontColor = .white
                self.lblHard?.fontColor = .white
                self.lblNightmare?.fontColor = .white
                self.lblMedium?.fontColor = self.lblColor
            }else if(self.selNode == self.lblHard){
                self.lblEasy?.fontColor = .white
                self.lblHard?.fontColor = self.lblColor
                self.lblNightmare?.fontColor = .white
                self.lblMedium?.fontColor = .white
            }else if(self.selNode == self.lblNightmare){
                self.lblEasy?.fontColor = .white
                self.lblNightmare?.fontColor = self.lblColor
                self.lblHard?.fontColor = .white
                self.lblMedium?.fontColor = .white
            }
            
            SoundManager.shared.playSound(sound: .menuHighlite)
        }
    }
    
    override func touchOrClick(pos: CGPoint) {
        super.touchOrClick(pos: pos)
//        let node = self.scene!.atPoint(pos)
        
        if(self.selNode == lblEasy){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadGameScene(difficulty: .easy, level: self.selLevel)
            }
        }else if(self.selNode == lblMedium){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadGameScene(difficulty: .medium, level: self.selLevel)
            }
        }else if(self.selNode == lblHard){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadGameScene(difficulty: .hard, level: self.selLevel)
            }
        }else if(self.selNode == lblNightmare){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadGameScene(difficulty: .nightmare, level: self.selLevel)
            }
        }
    }
}
