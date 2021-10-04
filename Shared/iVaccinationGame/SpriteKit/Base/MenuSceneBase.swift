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
    var lblVersion:SKLabelNode?
    var lblColor:SKColor?
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.lblStartGame = self.childNode(withName: "lblStartGame") as? SKLabelNode
        self.lblContinue = self.childNode(withName: "lblContinue") as? SKLabelNode
        
        if(Level.NewGame.getDesc() == ICloudStorageHelper.level){
            self.lblContinue?.fontColor = SKColor.gray
        }
        
        self.lblSettings = self.childNode(withName: "lblSettings") as? SKLabelNode
        self.lblExit = self.childNode(withName: "lblExit") as? SKLabelNode
        self.lblMap = self.childNode(withName: "lblMap") as? SKLabelNode
        self.lblMap?.isHidden = !VersionHelper.getDevMode()

        self.lblVersion = self.childNode(withName: "lblVersion") as? SKLabelNode
        self.lblVersion?.text = "Version: \(VersionHelper.getAppVersion()) - Build: \(VersionHelper.getAppBuild())"
        self.lblColor = self.lblStartGame?.fontColor
        self.selNode = self.lblStartGame
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
        super.touchOrClick(pos: pos, viewController: viewController)
        let node = self.atPoint(pos)
        if(node == self.lblMap){
            viewController.loadCreditsScene()
        }else if(node == self.lblStartGame){
            var doStart:Bool = true
            if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                
                let answer = AlertBox.dialogOKCancel(question: "Restart iVaccination?", text: "Another game was started, do you want to completely restart a new game - from beginning?")
                if(!answer){
                    doStart = false
                }
            }
            if(doStart){
                ICloudStorageHelper.resetAllICloudValues()
                UserDefaultsHelper.resetUserDefValues()
                viewController.loadDifficultyScene()
            }
        }else if(node == self.lblContinue){
            if(Level.NewGame.getDesc() != ICloudStorageHelper.level){
                viewController.loadMapScene()
            }
        }
    }
}
