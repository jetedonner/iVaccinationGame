//
//  MenuScene.swift
//  MenuScene
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit
import GameKit

class MenuSceneBase: BaseSKScene {
    
    var lblStartGame:SKLabelNode?
    var lblContinue:SKLabelNode?
    var lblSettings:SKLabelNode?
    var lblExit:SKLabelNode?
    var lblMap:SKLabelNode?
    var lblHighscore:SKLabelNode?
    
    var lblVersion:SKLabelNode?
    var lblColor:SKColor?
    
    var teset:SkMessageBoxNode!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.teset = SkMessageBoxNode(size: CGSize(width: self.frame.width - 200, height: 100))
        self.lblStartGame = self.childNode(withName: "lblStartGame") as? SKLabelNode
        self.lblContinue = self.childNode(withName: "lblContinue") as? SKLabelNode
        
        if(Level.NewGame.getDesc() == ICloudStorageHelper.level){
            self.lblContinue?.fontColor = SKColor.gray
        }
        
        self.lblSettings = self.childNode(withName: "lblSettings") as? SKLabelNode
        self.lblExit = self.childNode(withName: "lblExit") as? SKLabelNode
        self.lblMap = self.childNode(withName: "lblMap") as? SKLabelNode
        self.lblHighscore = self.childNode(withName: "lblHighscore") as? SKLabelNode
//        self.lblMap?.isHidden = !VersionHelper.getDevMode()

        self.lblVersion = self.childNode(withName: "lblVersion") as? SKLabelNode
        self.lblVersion?.text = "Version: \(VersionHelper.getAppVersion()) - Build: \(VersionHelper.getAppBuild())"
        self.lblColor = self.lblStartGame?.fontColor
        self.selNode = self.lblStartGame
        self.addChild(self.teset)
//        self.teset.showMessage(title: "HELLO MESSAGE BOX", msg: "Some detailed message to show")
        self.teset.showMessage(title: "Collect all certificates", msg: "GREAT! You've collected all certificates in this level!\nYou earned +100 Points")
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController)->SKNode {
        let node = super.touchOrClick(pos: pos, viewController: viewController)
//        self.atPoint(pos)
        if(node == self.lblMap){
//            viewController.loadCreditsScene()
//            viewController.loadHighscoreScene()
        }else if(node == self.lblStartGame){
            var doStart:Bool = true
            if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                
                #if os(macOS)
                let answer = AlertBox.dialogOKCancel(question: "Restart iVaccination?", text: "Another game was started, do you want to completely restart a new game - from beginning?")
                if(!answer){
                    doStart = false
                }
                #else
                    doStart = false
                AlertBox.alertTheUser(viewController: (self.view?.window?.rootViewController)!, completion: {
                    if(AlertBox.userWantToChangeSettings){
                        ICloudStorageHelper.resetAllICloudValues()
                        UserDefaultsHelper.resetUserDefValues(resetFirstStart: false)
                        viewController.loadDifficultyScene()
                    }
                }, question: "Restart iVaccination?", text: "Another game was started, do you want to completely restart a new game - from beginning?")
                #endif
            }
            if(doStart){
                ICloudStorageHelper.resetAllICloudValues()
                UserDefaultsHelper.resetUserDefValues(resetFirstStart: false)
                viewController.loadDifficultyScene()
            }
        }else if(node == self.lblContinue){
            if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                viewController.loadMapScene()
            }
        }
        return node
    }
}
