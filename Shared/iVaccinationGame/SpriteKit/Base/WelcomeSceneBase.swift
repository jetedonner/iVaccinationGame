//
//  MenuScene.swift
//  MenuScene
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit
import GameKit

class WelcomeSceneBase: BaseSKScene {
    
    var lblContinue:SKLabelNode?
    var chkDontShow:SKShapeNode?
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.lblContinue = self.childNode(withName: "lblContinue") as? SKLabelNode
        self.chkDontShow = self.childNode(withName: "chkDontShow") as? SKShapeNode
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController)->SKNode{
        let node = super.touchOrClick(pos: pos, viewController: viewController)
        if(node == lblContinue){
            viewController.loadMenuScene()
        }else if(node == self.chkDontShow){
            if(self.chkDontShow?.fillColor != self.chkDontShow?.strokeColor){
                self.chkDontShow?.fillColor = self.chkDontShow!.strokeColor
                UserDefaultsHelper.firstStart = false
            }else{
                self.chkDontShow?.fillColor = .clear
                UserDefaultsHelper.firstStart = true
            }
        }
        return node
    }
}
