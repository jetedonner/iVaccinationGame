//
//  FirstLevel.swift
//  FirstLevel
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import SpriteKit

class MeadowLevel: BaseLevel {
    
    init() {
        super.init(level: .Meadow, levelName: "Meadow", bgImageName: "Meadow")
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
        
        let scn:SKScene = SKScene(fileNamed: "MeadowLeftActions.sks")!
        let scn2:SKScene = SKScene(fileNamed: "MeadowRightActions.sks")!
        self.levelConfigs[.easy]?.zombiePaths.append(
            BasePath(
                initPos: CGPoint(x: -192.1, y: -88.134),
                initScale: 0.35,
                path:
                    (scn.value(forKey: "actions") as! NSDictionary).value(forKey: "MeadowLeft") as! SKAction,
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
                initPos: CGPoint(x: 536.3, y: -98.659),
                initScale: 0.45,
                path:
                    (scn2.value(forKey: "actions") as! NSDictionary).value(forKey: "MeadowRight") as! SKAction,
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
        
        self.levelConfigs[.medium] = LevelConfig(
            difficulty: .medium,
            zombieCountAtOnce: 3,
            syringePickupsAtOnce: 3,
            certificatePickupsAtOnce: 2,
            duration: .Minutes1
        )
        
        self.levelConfigs[.medium]?.zombiePaths.append(
            (self.levelConfigs[.easy]?.zombiePaths[0])!
        )
        self.levelConfigs[.medium]?.zombiePaths.append(
            (self.levelConfigs[.easy]?.zombiePaths[1])!
        )
    }
    
//    override func initLevel() {
//        self.levelName = "Meadow"
//        self.backgroundImageName = "Meadow"
//        self.zombieCount = 1
//        self.certRespawnRange = 5...10
//        self.duration = .Minutes1
//        
//        let exitMove1:SKAction = SKAction.moveBy(x: 60, y: 10, duration: 0.2)
//        let exitMove2:SKAction = SKAction.moveBy(x: 60, y: -10, duration: 0.2)
//        
//        let scn:SKScene = SKScene(fileNamed: "MeadowLeftActions.sks")!
//        let scn2:SKScene = SKScene(fileNamed: "MeadowRightActions.sks")!
//        
//        self.zombiePaths[.easy] = [BasePath]()
//        self.zombiePaths[.easy]?.append(
//            BasePath(
//                initPos: CGPoint(x: -192.1, y: -88.134),
//                initScale: 0.35,
//                path:
//                    (scn.value(forKey: "actions") as! NSDictionary).value(forKey: "MeadowLeft") as! SKAction,
//                exitPath: SKAction.sequence([
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2
//                ])
//            )
//        )
//        self.zombiePaths[.easy]?.append(
//            BasePath(
//                initPos: CGPoint(x: 536.3, y: -98.659),
//                initScale: 0.45,
//                path:
//                    (scn2.value(forKey: "actions") as! NSDictionary).value(forKey: "MeadowRight") as! SKAction,
//                exitPath: SKAction.sequence([
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2,
//                    exitMove1, exitMove2
//                ])
//            )
//        )
//    }
}
