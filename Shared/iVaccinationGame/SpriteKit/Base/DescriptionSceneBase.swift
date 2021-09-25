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
//    var lblMedium:SKLabelNode?
//    var lblHard:SKLabelNode?
//    var lblNightmare:SKLabelNode?
//    var sceneNode:SKScene!
//    var lblColor:NSColor?
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
        super.sceneDidLoad()
        self.lblContinue = self.childNode(withName: "lblContinue") as? SKLabelNode
        self.isUserInteractionEnabled = true
    }
}
