//
//  MenuScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class MenuScene: MenuSceneBase {
    
    override func touchOrClick(pos: CGPoint) {
        super.touchOrClick(pos: pos)
//        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(pos)
        var newSelNode:SKLabelNode?
        
        if(self.selNode == lblExit){
            NSApp.terminate(nil)
        }else if(self.selNode == lblStartGame){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadDifficultyMenu(level: .Meadow)
            }
        }else if(self.selNode == lblGameCenter){
//            GKAccessPoint.shared.trigger(handler: {
//
//            })
        }else if(self.selNode == lblSettings){
            let vcSettings:SettingsViewController = SettingsViewController()
            vcSettings.gameScene = nil
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).presentAsSheet(vcSettings)
            }
        }else if(self.selNode == lblMap){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadMap()
            }
        }
    }
}
