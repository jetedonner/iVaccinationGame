//
//  FirstLevel.swift
//  FirstLevel
//
//  Created by Kim David Hauser on 18.09.21.
//

import Foundation
import SpriteKit

class ThirdLevel: BaseLevel {
    
    override init() {
        super.init()
    }
    
    override func initLevel() {
        self.levelName = "Flushing meadow"
        self.backgroundImageName = "Meadows"
        self.zombieImageName = "ZombieGirl2"
        self.zombieCuredImageName = "ZombieGirl2Un"
        self.zombieCount = 1
        
        let exitMove1:SKAction = SKAction.moveBy(x: 60, y: 10, duration: 0.2)
        let exitMove2:SKAction = SKAction.moveBy(x: 60, y: -10, duration: 0.2)
        
        let scn:SKScene = SKScene(fileNamed: "MeadowLeftActions.sks")!
        let scn2:SKScene = SKScene(fileNamed: "MeadowRightActions.sks")!
//        SKAction(named: "MeadowLeftActions", from: URL "Scenes/MeadowLeftActions.sks")
//        let testAction = SKAction(named: "MeadowLeftActions")!
        
        self.zombiePaths.append(
            BasePath(
                initPos: CGPoint(x: -192.1, y: -88.134),
                initScale: 0.35,
                path:
                    (scn.value(forKey: "actions") as! NSDictionary).value(forKey: "MeadowLeft") as! SKAction
                    /*SKAction.sequence([
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
                ])*/,
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
        self.zombiePaths.append(
            BasePath(
                initPos: CGPoint(x: 536.3, y: -98.659),
                initScale: 0.45,
                path:
                    (scn2.value(forKey: "actions") as! NSDictionary).value(forKey: "MeadowRight") as! SKAction
                    /*SKAction.sequence([
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
                ])*/,
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
}
