//
//  BaseSKScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class BaseSKScene: SKScene {
    
    var sceneNode:SKScene!
    var selNode:SKNode?
    
    override init() {
        super.init()
    }
    
    override func sceneDidLoad() {
        self.sceneNode = self.scene
    }
    
    func touchOrClick(pos:CGPoint, viewController:IViewController)->SKNode{
        return self.atPoint(pos)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
