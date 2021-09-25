//
//  FirstLevel.swift
//  FirstLevel
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import SpriteKit

class CityJapanLevel: BaseLevel {
    
    init() {
        super.init(level: .CityJapan)
    }
    
    override func initLevel() {
        self.levelName = "City Japan"
        self.backgroundImageName = "CityJapan"
        self.zombieImageName = "ZombieGirl2"
        self.zombieCuredImageName = "ZombieGirl2Un"
        self.zombieCount = 1
        
        let exitWay1:SKAction = SKAction.moveBy(x: 60, y: 10, duration: 0.2)
        let exitWay2:SKAction = SKAction.moveBy(x: 60, y: -10, duration: 0.2)

        for idx in 0..<2{
            self.zombiePaths.append(
                BasePath(
                    initPos: CGPoint(x: 72, y: -83),
                    initScale: 0.3,
                    path: SKAction.sequence([
                        SKAction.group([
                            SKAction.scaleX(to: 0.3, duration: 0.55),
                            SKAction.move(by: CGVector(dx: -10, dy: 0), duration: 0.55),
                        ]),
                        SKAction.group([
                            SKAction.move(by: CGVector(dx: -100, dy: -250), duration: 5.5 - Double(idx) * 1.5),
                            SKAction.scale(to: 3.5, duration: (5.5 - Double(idx) * 1.5))
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
                    ]),
                    hideOnStart: true
                )
            )
        }
        
        for _ in 0..<2{
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

        for _ in 0..<2{
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
