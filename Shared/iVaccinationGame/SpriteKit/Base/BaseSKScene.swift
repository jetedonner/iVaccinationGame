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
    
    override init() {
        super.init()
    }
    
    override func sceneDidLoad() {
        self.sceneNode = self.scene
    }
    
    func touchOrClick(pos:CGPoint){
        var tmp = -1
        tmp /= -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
