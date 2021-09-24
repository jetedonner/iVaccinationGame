//
//  BasePath.swift
//  BasePath
//
//  Created by Kim David Hauser on 19.09.21.
//

import Foundation
import SpriteKit

class BasePath{
    
    var initPos:CGPoint = CGPoint()
    var initScale:CGFloat = 1.0
    var path:SKAction = SKAction.wait(forDuration: 0.0)
    var exitPath:SKAction = SKAction.wait(forDuration: 0.0)
    var hideOnStart:Bool = false
    
    init(){
        
    }
    
    init(initPos:CGPoint, initScale:CGFloat, path:SKAction, exitPath:SKAction, hideOnStart:Bool = false) {
        self.initPos = initPos
        self.initScale = initScale
        self.path = path
        self.exitPath = exitPath
        self.hideOnStart = hideOnStart
    }
}
