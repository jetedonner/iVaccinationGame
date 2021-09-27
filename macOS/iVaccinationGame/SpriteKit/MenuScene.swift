//
//  MenuScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class MenuScene: MenuSceneBase {
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
        var newSelNode:SKLabelNode?
        
        if([
            self.lblSettings,
            self.lblExit,
            self.lblStartGame,
            self.lblContinue,
            self.lblMap
        ].contains(node)){
            newSelNode = node as? SKLabelNode
        }else{
            return
        }2

        if(newSelNode != self.selNode){
            self.selNode = newSelNode
            if(self.selNode == self.lblSettings){
                self.lblSettings?.fontColor = self.lblColor
                self.lblStartGame?.fontColor = .white
                self.lblExit?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblContinue?.fontColor = .white
            }else if(self.selNode == self.lblExit){
                self.lblSettings?.fontColor = .white
                self.lblStartGame?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblExit?.fontColor = self.lblColor
                self.lblContinue?.fontColor = .white
            }else if(self.selNode == self.lblStartGame){
                self.lblSettings?.fontColor = .white
                self.lblStartGame?.fontColor = self.lblColor
                self.lblExit?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblContinue?.fontColor = .white
            }else if(self.selNode == self.lblContinue){
                self.lblSettings?.fontColor = .white
                self.lblExit?.fontColor = .white
                self.lblStartGame?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblContinue?.fontColor = self.lblColor
            }else if(self.selNode == self.lblMap){
                self.lblSettings?.fontColor = .white
                self.lblMap?.fontColor = self.lblColor
                self.lblExit?.fontColor = .white
                self.lblStartGame?.fontColor = .white
                self.lblContinue?.fontColor = .white
            }
            SoundManager.shared.playSound(sound: .menuHighlite)
        }
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
        super.touchOrClick(pos: pos, viewController: viewController)
        
        if(self.selNode == lblExit){
            NSApp.terminate(nil)
        }else if(self.selNode == lblSettings){
            let vcSettings:SettingsViewController = SettingsViewController()
            vcSettings.gameScene = nil
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).presentAsSheet(vcSettings)
            }
        }
    }
}
