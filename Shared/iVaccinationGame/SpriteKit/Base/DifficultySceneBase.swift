//
//  MenuScene.swift
//  MenuScene
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit
import GameKit

class DifficultySceneBase: BaseSKScene {
    
    var lblEasy:SKLabelNode?
    var lblMedium:SKLabelNode?
    var lblHard:SKLabelNode?
    var lblNightmare:SKLabelNode?
    var lblBack:SKLabelNode?
    var lblColor:SKColor?
    
//    var selLevel:Level = .Meadow
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.lblEasy = self.childNode(withName: "lblEasy") as? SKLabelNode
        self.lblMedium = self.childNode(withName: "lblMedium") as? SKLabelNode
        self.lblHard = self.childNode(withName: "lblHard") as? SKLabelNode
        self.lblNightmare = self.childNode(withName: "lblNightmare") as? SKLabelNode
        self.lblBack = self.childNode(withName: "lblBack") as? SKLabelNode
        
        self.lblColor = self.lblEasy?.fontColor
        self.selNode = self.lblEasy
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
        super.touchOrClick(pos: pos, viewController: viewController)

        if(self.selNode == lblEasy){
            viewController.loadMapScene(difficulty: .easy, level: .Meadow)
//            viewController.loadGameScene(difficulty: .easy, level: self.selLevel)
        }else if(self.selNode == lblMedium){
            viewController.loadMapScene(difficulty: .medium, level: .Meadow)
//            viewController.loadGameScene(difficulty: .medium, level: self.selLevel)
        }else if(self.selNode == lblHard){
            viewController.loadMapScene(difficulty: .hard, level: .Meadow)
//            viewController.loadGameScene(difficulty: .hard, level: self.selLevel)
        }else if(self.selNode == lblNightmare){
            viewController.loadMapScene(difficulty: .nightmare, level: .Meadow)
//            viewController.loadGameScene(difficulty: .nightmare, level: self.selLevel)
        }else if(self.selNode == lblBack){
            viewController.loadMenuScene()
        }
    }
}
