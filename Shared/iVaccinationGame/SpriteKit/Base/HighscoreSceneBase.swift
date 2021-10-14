//
//  MenuScene.swift
//  MenuScene
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit
import GameKit

class HighscoreSceneBase: BaseSKScene {
    
    var bg:SKSpriteNode?
    var lblContinue:SKLabelNode?
    var scrollingList:JADSKScrollingNode!
    var lblTest:SKLabelNode = SKLabelNode(text: "TEST LABLE For scrolling")
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.bg = self.childNode(withName: "BG") as? SKSpriteNode
        self.lblContinue = self.childNode(withName: "lblContinue") as? SKLabelNode
        self.scrollingList = JADSKScrollingNode(size: CGSize(width: 200, height: 300))
        self.scrollingList.addChild(self.lblTest)
        self.addChild(self.scrollingList)
        self.scrollingList.zPosition = 100001
    }
    
    
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
        super.touchOrClick(pos: pos, viewController: viewController)
        if(self.selNode == lblContinue){
            viewController.loadMenuScene()
        }else{
            
        }
    }
}
