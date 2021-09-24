//
//  SyringeDart.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import SpriteKit

class SyringeDart: SKSpriteNode {
    
    init(size:CGSize? = nil) {
        let texture = SKTexture(imageNamed: "Syringe")
        super.init(texture: texture, color: SKColor.clear, size: (size ?? texture.size()))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
