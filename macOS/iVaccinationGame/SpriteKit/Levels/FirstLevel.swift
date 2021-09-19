//
//  FirstLevel.swift
//  FirstLevel
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import SpriteKit

class FirstLevel: BaseLevel {
    
    override init() {
        super.init()
    }
    
    override func initLevel() {
        self.levelName = "City skyline"
        
        self.backgroundImageName = "Landscape"
        
        self.zombieInitPos.append(CGPoint(x: -126.717, y: -85.909))
        self.zombieInitScale.append(0.5)
        self.zombieImageName = "ZombieGirl2"
        self.zombieCuredImageName = "ZombieGirl2Un"
        self.zombieCount = 1
        
        self.zombiePaths.append(
            SKAction.sequence([
                SKAction.group([
                    SKAction.moveBy(x: 100, y: -40, duration: 2.0),
                    SKAction.scale(to: 0.65, duration: 2.0)
                ]),
                SKAction.group([
                    SKAction.moveBy(x: -205, y: -80, duration: 2.5),
                    SKAction.scale(to: 1.0, duration: 2.5)
                ]),
                SKAction.group([
                    SKAction.moveBy(x: 560, y: -170, duration: 2.9),
                    SKAction.scale(to: 3.0, duration: 2.9)
                ])
            ])
        )
        
        self.zombieExitPaths.append(
            SKAction.sequence([
                SKAction.moveBy(x: 60, y: 10, duration: 0.2),
                SKAction.moveBy(x: 60, y: -10, duration: 0.2),
                SKAction.moveBy(x: 60, y: 10, duration: 0.2),
                SKAction.moveBy(x: 60, y: -10, duration: 0.2),
                SKAction.moveBy(x: 60, y: 10, duration: 0.2),
                SKAction.moveBy(x: 60, y: -10, duration: 0.2),
                SKAction.moveBy(x: 60, y: 10, duration: 0.2),
                SKAction.moveBy(x: 60, y: -10, duration: 0.2),
                SKAction.moveBy(x: 60, y: 10, duration: 0.2),
                SKAction.moveBy(x: 60, y: -10, duration: 0.2),
                SKAction.moveBy(x: 60, y: 10, duration: 0.2),
                SKAction.moveBy(x: 60, y: -10, duration: 0.2),
                SKAction.moveBy(x: 60, y: 10, duration: 0.2),
                SKAction.moveBy(x: 60, y: -10, duration: 0.2)
            ])
        )
    }
}
