//
//  MapSceneMacOS.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

extension MapScene{
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
//        var newSelNode:SKNode?
        
        if(node == self.imgBack){
//            newSelNode = self.imgBack
            self.selNode = node
            self.imgBack.texture = self.textBackArrowSel
        }else if(node == self.posMeadow){
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
        }else if(node == self.posCitySkyline){
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
        }else{
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
        }
        
        
        ///*else if(node == self.lblMedium){
//            newSelNode = self.lblMedium
//        }else if(node == self.lblHard){
//            newSelNode = self.lblHard
//        }else if(node == self.lblNightmare){
//            newSelNode = self.lblNightmare
////        }else if(node == self.lblStartGame){
////            newSelNode = self.lblStartGame
//        }*/else{
//            return
//        }
        
//        if(newSelNode != self.selNode){
//            self.selNode = newSelNode
//            if(self.selNode == self.lblContinue){
////                self.lblContinue?.fontColor = self.lblColor
////                self.lblMedium?.fontColor = .white
////                self.lblHard?.fontColor = .white
////                self.lblNightmare?.fontColor = .white
//            }/*else if(self.selNode == self.lblMedium){
//                self.lblEasy?.fontColor = .white
//                self.lblHard?.fontColor = .white
//                self.lblNightmare?.fontColor = .white
//                self.lblMedium?.fontColor = self.lblColor
//            }else if(self.selNode == self.lblHard){
//                self.lblEasy?.fontColor = .white
//                self.lblHard?.fontColor = self.lblColor
//                self.lblNightmare?.fontColor = .white
//                self.lblMedium?.fontColor = .white
//            }else if(self.selNode == self.lblNightmare){
//                self.lblEasy?.fontColor = .white
//                self.lblNightmare?.fontColor = self.lblColor
//                self.lblHard?.fontColor = .white
//                self.lblMedium?.fontColor = .white
//            }*/
//
//            if(UserDefaultsHelper.playSounds){
//                self.selNode?.run(SoundManager.menuHighliteSound)
//            }
//        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if(self.selNode == self.imgBack){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadMenu()
            }
        }else if(self.selNode == self.posMeadow){
            print("Meadow SELECTED")
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadDifficultyMenu(level: .Meadow)
            }
        }else if(self.selNode == self.posCitySkyline){
            print("CitySkyline SELECTED")
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadDifficultyMenu(level: .CitySkyline)
            }
        }
        
        
//        }else if(self.selNode == lblHard){
//            if let viewCtrl = self.view?.window?.contentViewController{
//                (viewCtrl as! ViewController).loadGameScene(difficulty: .hard)
//            }
//        }else if(self.selNode == lblNightmare){
//            if let viewCtrl = self.view?.window?.contentViewController{
//                (viewCtrl as! ViewController).loadGameScene(difficulty: .nightmare)
//            }
//        }*/
////            NSApp.terminate(nil)
////        }else if(self.selNode == lblStartGame){
////            if let viewCtrl = self.view?.window?.contentViewController{
////                (viewCtrl as! ViewController).loadGameScene()
////            }
////        }else if(self.selNode == lblGameCenter){
//////            GKAccessPoint.shared.trigger(handler: {
//////
//////            })
////        }else if(self.selNode == lblSettings){
////            let vcSettings:SettingsViewController = SettingsViewController()
////            vcSettings.gameScene = nil
////            if let viewCtrl = self.view?.window?.contentViewController{
////                (viewCtrl as! ViewController).presentAsSheet(vcSettings)
////            }
////        }
    }
    
}
