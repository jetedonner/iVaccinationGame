//
//  FirstLevel.swift
//  FirstLevel
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import SpriteKit

class CityStreetLevel: BaseLevel {
    
    init() {
        super.init(level: .CityStreet)
    }
    
    override func initLevel() {
        self.levelName = "City street"
        self.backgroundImageName = "CityStreet"
        self.zombieImageName = "ZombieGirl2"
        self.zombieCuredImageName = "ZombieGirl2Un"
        self.zombieCount = 1
        
        for _ in 0..<4{
            let way2Go:CGFloat = CGFloat.random(in: 350 ... 900)
            let exitWay1:SKAction = SKAction.moveBy(x: 60, y: 10, duration: 0.2)
            let exitWay2:SKAction = SKAction.moveBy(x: 60, y: -10, duration: 0.2)
            
            self.zombiePaths.append(
                BasePath(
                    initPos: CGPoint(x: -566.0, y: -174.75),
                    initScale: 1.0,
                    path: SKAction.sequence([
                            SKAction.moveBy(x: way2Go, y: 0, duration: 6.5),
                            SKAction.group([
                                SKAction.moveBy(x: -100, y: -210, duration: 1.0),
                                SKAction.scale(to: 3.65, duration: 1.0)
                            ])
                        ]),
                    exitPath: SKAction.sequence([
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2
                    ])
                )
            )
        }
        
        for _ in 0..<4{
            let way2Go:CGFloat = CGFloat.random(in: 350 ... 900)
            let exitWay1:SKAction = SKAction.moveBy(x: -60, y: 10, duration: 0.2)
            let exitWay2:SKAction = SKAction.moveBy(x: -60, y: -10, duration: 0.2)
            
            self.zombiePaths.append(
                BasePath(
                    initPos: CGPoint(x: 566.0, y: -174.75),
                    initScale: 1.0,
                    path: SKAction.sequence([
                            SKAction.moveBy(x: -way2Go, y: 0, duration: 6.5),
                            SKAction.group([
                                SKAction.moveBy(x: 100, y: -210, duration: 1.0),
                                SKAction.scale(to: 3.65, duration: 1.0)
                            ])
                        ]),
                    exitPath: SKAction.sequence([
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2,
                        exitWay1, exitWay2
                    ])
                )
            )
        }
    }
}
