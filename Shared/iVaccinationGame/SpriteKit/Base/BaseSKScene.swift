//
//  BaseSKScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class BaseSKScene: SKScene {
    
    override init() {
        super.init()
    }
        
//    @objc
    func touchOrClick(pos:CGPoint){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
