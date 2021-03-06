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
            self.lblMap,
            self.lblHighscore
        ].contains(node)){
            newSelNode = node as? SKLabelNode
        }else{
            return
        }

        if(newSelNode != self.selNode){
            self.selNode = newSelNode
            if(self.selNode == self.lblSettings){
                self.lblSettings?.fontColor = self.lblColor
                self.lblStartGame?.fontColor = .white
                self.lblExit?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblHighscore?.fontColor = .white
                if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                    self.lblContinue?.fontColor = .white
                }
            }else if(self.selNode == self.lblExit){
                self.lblSettings?.fontColor = .white
                self.lblStartGame?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblHighscore?.fontColor = .white
                self.lblExit?.fontColor = self.lblColor
                if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                    self.lblContinue?.fontColor = .white
                }
            }else if(self.selNode == self.lblStartGame){
                self.lblSettings?.fontColor = .white
                self.lblStartGame?.fontColor = self.lblColor
                self.lblExit?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblHighscore?.fontColor = .white
                if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                    self.lblContinue?.fontColor = .white
                }
            }else if(self.selNode == self.lblContinue){
                self.lblSettings?.fontColor = .white
                self.lblExit?.fontColor = .white
                self.lblStartGame?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblHighscore?.fontColor = .white
                if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                    self.lblContinue?.fontColor = self.lblColor
                }
            }else if(self.selNode == self.lblMap){
                self.lblSettings?.fontColor = .white
                self.lblMap?.fontColor = self.lblColor
                self.lblHighscore?.fontColor = .white
                self.lblExit?.fontColor = .white
                self.lblStartGame?.fontColor = .white
                if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                    self.lblContinue?.fontColor = .white
                }
            }else if(self.selNode == self.lblHighscore){
                self.lblSettings?.fontColor = .white
                self.lblMap?.fontColor = .white
                self.lblHighscore?.fontColor = self.lblColor
                self.lblExit?.fontColor = .white
                self.lblStartGame?.fontColor = .white
                if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                    self.lblContinue?.fontColor = .white
                }
            }
            if(Level.NewGame.getDesc() != ICloudStorageHelper.level || (Level.NewGame.getDesc() == ICloudStorageHelper.level && newSelNode != self.lblContinue)){
                SoundManager.shared.playSound(sound: .menuHighlite)
            }
        }
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController)->SKNode {
        let node = super.touchOrClick(pos: pos, viewController: viewController)
        
        if(node == lblExit){
            NSApp.terminate(nil)
        }else if(node == lblSettings){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadSettingsDialog(nil, menuScene: self)
            }
        }else if(node == lblMap){
            NSApp.orderFrontStandardAboutPanel(nil)
//            if let viewCtrl = self.view?.window?.contentViewController{
//                (viewCtrl as! ViewController).loadCreditsScene()
//            }
        }else if(node == lblHighscore){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadHighscoreDialog(nil)
            }
        }
        return node
    }
}
