//
//  ZombieGirl.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 22.09.21.
//

import Foundation
import SpriteKit
#if os(iOS)
import UIKit
#endif

#if os(macOS)
import Cocoa
#endif

class ZombieGirl: SKSpriteNode {
    
    init(zombieImageName:String){
        super.init(texture: SKTexture(imageNamed: zombieImageName), color: .clear, size: CGSize(width: 108, height: 163))
    }
    
    #if os(iOS)
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    #else
    override init(texture: SKTexture?, color: NSColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    #endif
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
