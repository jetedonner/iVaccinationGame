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
    
    private var _healed:Bool = false
    var isHealed:Bool{
        get{ return self._healed }
        set{ self._healed = newValue }
    }
    
    private var _hits:Int = 0
    var hits:Int{
        get{ return self._hits }
        set{ self._hits = newValue }
    }
    
    private var _health:CGFloat = 0.0
    var health:CGFloat{
        get{ return self._health }
        set{ self._health = newValue }
    }
    
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
