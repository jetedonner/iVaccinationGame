//
//  FirstLevel.swift
//  FirstLevel
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import SpriteKit

class ScarryStreetLevel: BaseLevel {
    
    init() {
        super.init(level: .ScarryStreet, levelName: "Scarry Street", bgImageName: "ScarryStreet")
    }
    
    override func initLevelConfig() {
        self.levelConfigs[.easy] = LevelConfig(
            difficulty: .easy,
            zombieCountAtOnce: 2,
            syringePickupsAtOnce: 2,
            certificatePickupsAtOnce: 2,
            duration: .Minutes1
        )
        let exitMove1:SKAction = SKAction.moveBy(x: 60, y: 10, duration: 0.2)
        let exitMove2:SKAction = SKAction.moveBy(x: 60, y: -10, duration: 0.2)
        
        for idx in 0..<2{
            self.zombiePaths[.easy] = [BasePath]()
            self.levelConfigs[.easy]?.zombiePaths.append(
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
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2
                    ]),
                    hideOnStart: true
                )
            )
        }
        
        for _ in 0..<2{
            let way2Go:CGFloat = CGFloat.random(in: 350 ... 900)
            let exitMove1:SKAction = SKAction.moveBy(x: 60, y: 10, duration: 0.2)
            let exitMove2:SKAction = SKAction.moveBy(x: 60, y: -10, duration: 0.2)

            self.levelConfigs[.easy]?.zombiePaths.append(
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
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2
                    ])
                )
            )
        }

        for _ in 0..<2{
            let way2Go:CGFloat = CGFloat.random(in: 350 ... 900)
            let exitMove1:SKAction = SKAction.moveBy(x: -60, y: 10, duration: 0.2)
            let exitMove2:SKAction = SKAction.moveBy(x: -60, y: -10, duration: 0.2)

            self.levelConfigs[.easy]?.zombiePaths.append(
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
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2,
                        exitMove1, exitMove2
                    ])
                )
            )
        }
        
        // ========= DIFFICULTY: MEDIUM =========
        self.levelConfigs[.medium] = LevelConfig(
            difficulty: .medium,
            zombieCountAtOnce: 3,
            syringePickupsAtOnce: 2,
            certificatePickupsAtOnce: 3,
            duration: .Minutes2
        )
        self.levelConfigs[.medium]?.zombiePaths.append(contentsOf: (self.levelConfigs[.easy]!.zombiePaths))
        self.levelConfigs[.medium]?.zombiePaths.shuffle()
        
        // ========= DIFFICULTY: HARD =========
        self.levelConfigs[.hard] = LevelConfig(
            difficulty: .hard,
            zombieCountAtOnce: 3,
            syringePickupsAtOnce: 3,
            certificatePickupsAtOnce: 3,
            duration: .Minutes3
        )
        self.levelConfigs[.hard]?.zombiePaths.append(contentsOf: (self.levelConfigs[.easy]!.zombiePaths))
        self.levelConfigs[.hard]?.zombiePaths.shuffle()
        
        // ========= DIFFICULTY: NIGHTMARE =========
        self.levelConfigs[.nightmare] = LevelConfig(
            difficulty: .nightmare,
            zombieCountAtOnce: 4,
            syringePickupsAtOnce: 4,
            certificatePickupsAtOnce: 3,
            duration: .Minutes5
        )
        self.levelConfigs[.nightmare]?.zombiePaths.append(contentsOf: (self.levelConfigs[.easy]!.zombiePaths))
        self.levelConfigs[.nightmare]?.zombiePaths.shuffle()
    }
}
