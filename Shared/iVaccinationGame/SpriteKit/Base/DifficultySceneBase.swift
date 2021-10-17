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
    
    var initLevel:Level = .Meadow
    
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
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController)->SKNode {
        let node = super.touchOrClick(pos: pos, viewController: viewController)

        var difficulty:Difficulty = .easy
        if(node == lblEasy){
            difficulty = .easy
//            viewController.loadMapScene(difficulty: .easy, level: self.initLevel)
        }else if(node == lblMedium){
            difficulty = .medium
//            viewController.loadMapScene(difficulty: .medium, level: self.initLevel)
        }else if(node == lblHard){
            difficulty = .hard
//            viewController.loadMapScene(difficulty: .hard, level: self.initLevel)
        }else if(node == lblNightmare){
            difficulty = .nightmare
//            viewController.loadMapScene(difficulty: .nightmare, level: self.initLevel)
        }else if(node == lblBack){
            viewController.loadMenuScene()
            return node
        }
        ICloudStorageHelper.difficulty = difficulty.rawValue
        UserDefaultsHelper.difficulty = difficulty
        viewController.loadMapScene(difficulty: difficulty, level: self.initLevel)
        return node
    }
}
