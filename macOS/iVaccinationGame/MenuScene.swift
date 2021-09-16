//
//  MenuScene.swift
//  MenuScene
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit
import GameKit

class MenuScene: SKScene {
    
    var lblStartGame:SKLabelNode?
    var lblSettings:SKLabelNode?
    var lblExit:SKLabelNode?
    var sceneNode:SKScene!
    var lblColor:NSColor?
    var selNode:SKLabelNode?
//    var viewCtrl:ViewController?
    
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
//            super.isUserInteractionEnabled = newValue
        }
    }
    
    override func sceneDidLoad() {
        
//        self.view?.allowedTouchTypes = .indirect
        self.sceneNode = self.scene
        self.lblStartGame = self.childNode(withName: "lblStartGame") as? SKLabelNode
        self.lblSettings = self.childNode(withName: "lblSettings") as? SKLabelNode
        self.lblExit = self.childNode(withName: "lblExit") as? SKLabelNode
        self.lblColor = self.lblStartGame?.fontColor
        self.selNode = self.lblStartGame
        self.isUserInteractionEnabled = true
    }
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
        var newSelNode:SKLabelNode?
        
        if(node == self.lblSettings){
            newSelNode = self.lblSettings
        }else if(node == self.lblExit){
            newSelNode = self.lblExit
        }else if(node == self.lblStartGame){
            newSelNode = self.lblStartGame
        }else{
            return
        }
        
        if(newSelNode != self.selNode){
            self.selNode = newSelNode
            if(self.selNode == self.lblSettings){
                self.lblSettings?.fontColor = self.lblColor
                self.lblStartGame?.fontColor = .white
                self.lblExit?.fontColor = .white
            }else if(self.selNode == self.lblExit){
                self.lblSettings?.fontColor = .white
                self.lblStartGame?.fontColor = .white
                self.lblExit?.fontColor = self.lblColor
            }else if(self.selNode == self.lblStartGame){
                self.lblSettings?.fontColor = .white
                self.lblStartGame?.fontColor = self.lblColor
                self.lblExit?.fontColor = .white
            }
            self.selNode?.run(SKAction.playSoundFileNamed("Media.scnassets/Menu1.mp3", waitForCompletion: false))
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if(self.selNode == lblExit){
            NSApp.terminate(nil)
        }else if(self.selNode == lblStartGame){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadGameScene()
            }
        }else if(self.selNode == lblSettings){
            GKAccessPoint.shared.trigger(handler: {
            
            })
//            NSApp.terminate(nil)
//            if let viewCtrl = self.view?.window?.contentViewController{
//                (viewCtrl as! ViewController).gameCenterHelper.showDashboard()
//            }
        }
    }
}
