//
//  FirstLevel.swift
//  FirstLevel
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import SpriteKit

class CitySkylineLevel: BaseLevel {
    
    init() {
        super.init(level: .CitySkyline, levelName: "City skyline", bgImageName: "CitySkyline")
    }
    
    override func initLevelConfig() {
        self.levelConfigs[.easy] = LevelConfig(
            difficulty: .easy,
            zombieCountAtOnce: 2,
            syringePickupsAtOnce: 2,
            certificatePickupsAtOnce: 1,
            duration: .Minutes1
        )
        let exitMove1:SKAction = SKAction.moveBy(x: 60, y: 10, duration: 0.2)
        let exitMove2:SKAction = SKAction.moveBy(x: 60, y: -10, duration: 0.2)
        
        self.levelConfigs[.easy]?.zombiePaths.append(
            BasePath(
                initPos: CGPoint(x: -126.717, y: -85.909),
                initScale: 0.5,
                path: SKAction.sequence([
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
        
        self.levelConfigs[.easy]?.zombiePaths.append(
            BasePath(
                initPos: CGPoint(x: 555, y: 3),
                initScale: 0.5,
                path: SKAction.sequence([
                    SKAction.group([
                        SKAction.moveBy(x: -200, y: -140, duration: 2.0),
                        SKAction.scale(to: 0.65, duration: 2.0)
                    ]),
                    SKAction.group([
                        SKAction.moveBy(x: 50, y: -60, duration: 2.5),
                        SKAction.scale(to: 1.0, duration: 2.5)
                    ]),
                    SKAction.group([
                        SKAction.moveBy(x: -50, y: -90, duration: 1.4),
                        SKAction.scale(to: 3.0, duration: 1.4)
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
        self.levelConfigs[.easy]?.zombiePaths.shuffle()
        
        // ========= DIFFICULTY: MEDIUM =========
        self.levelConfigs[.medium] = LevelConfig(
            difficulty: .medium,
            zombieCountAtOnce: 3,
            syringePickupsAtOnce: 2,
            certificatePickupsAtOnce: 2,
            duration: .Minutes2
        )
        self.levelConfigs[.medium]?.zombiePaths.append(contentsOf: (self.levelConfigs[.easy]!.zombiePaths))
        self.levelConfigs[.medium]?.zombiePaths.shuffle()
        
        // ========= DIFFICULTY: HARD =========
        self.levelConfigs[.hard] = LevelConfig(
            difficulty: .hard,
            zombieCountAtOnce: 4,
            syringePickupsAtOnce: 3,
            certificatePickupsAtOnce: 2,
            duration: .Minutes3
        )
        self.levelConfigs[.hard]?.zombiePaths.append(contentsOf: (self.levelConfigs[.easy]!.zombiePaths))
        self.levelConfigs[.hard]?.zombiePaths.shuffle()
        
        // ========= DIFFICULTY: NIGHTMARE =========
        self.levelConfigs[.nightmare] = LevelConfig(
            difficulty: .nightmare,
            zombieCountAtOnce: 5,
            syringePickupsAtOnce: 4,
            certificatePickupsAtOnce: 2,
            duration: .Minutes5
        )
        self.levelConfigs[.nightmare]?.zombiePaths.append(contentsOf: (self.levelConfigs[.easy]!.zombiePaths))
        self.levelConfigs[.nightmare]?.zombiePaths.shuffle()
    }
}
