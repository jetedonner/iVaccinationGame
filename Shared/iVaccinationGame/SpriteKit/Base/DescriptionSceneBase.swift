//
//  MenuScene.swift
//  MenuScene
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit
import GameKit

class DescriptionSceneBase: BaseSKScene {
    
    var lblContinue:SKLabelNode?
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
        self.lblContinue = self.childNode(withName: "lblContinue") as? SKLabelNode
        self.isUserInteractionEnabled = true
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
        super.touchOrClick(pos: pos, viewController: viewController)
        if(self.selNode == lblContinue){
            viewController.loadGameScene(difficulty: .easy, level: .Meadow)
        }
    }
}
