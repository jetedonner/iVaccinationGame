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
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.lblContinue = self.childNode(withName: "lblContinue") as? SKLabelNode
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController)->SKNode {
        let node = super.touchOrClick(pos: pos, viewController: viewController)
        if(node == lblContinue){
            viewController.loadGameScene(difficulty: .easy, level: .Meadow)
        }
        return node
    }
}
