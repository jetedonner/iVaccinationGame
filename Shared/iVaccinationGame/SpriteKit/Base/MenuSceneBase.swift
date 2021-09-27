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
    
    var lblColor:SKColor?
//    var selNode:SKLabelNode?
    
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
//            super.isUserInteractionEnabled = newValue
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.lblStartGame = self.childNode(withName: "lblStartGame") as? SKLabelNode
        self.lblContinue = self.childNode(withName: "lblContinue") as? SKLabelNode
        self.lblSettings = self.childNode(withName: "lblSettings") as? SKLabelNode
        self.lblExit = self.childNode(withName: "lblExit") as? SKLabelNode
        self.lblMap = self.childNode(withName: "lblMap") as? SKLabelNode
        self.lblColor = self.lblStartGame?.fontColor
        self.selNode = self.lblStartGame
        self.isUserInteractionEnabled = true
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
        super.touchOrClick(pos: pos, viewController: viewController)
        let node = self.atPoint(pos)
        if(node == self.lblMap){
            viewController.loadMapScene()
        }else if(node == self.lblStartGame){
            viewController.loadDifficultyScene(level: .Meadow)
        }else if(node == self.lblContinue){
            viewController.loadMapScene()
        }
    }
}
