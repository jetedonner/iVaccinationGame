//
//  LevelConfig.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 02.10.21.
//

import Foundation
import SpriteKit

class LevelConfig{
    
    var difficulty:Difficulty = .easy
    var zombieCountAtOnce:Int = 1
    var zombieRespawnRange = 2...4
    
    var syringePickupsAtOnce:Int = 1
    var certificatePickupsAtOnce:Int = 1
    var duration:Duration = .Minutes1
    var gameDuration:Double{
        get{ return Double(self.duration.rawValue) }
    }
    
    var speedFactor:SpeedFactor{
        get{ return self.difficulty.getSpeedFactor() }
    }
    
    var zombiePaths:[BasePath] = []
    
    init(difficulty:Difficulty, zombieCountAtOnce:Int, syringePickupsAtOnce:Int, certificatePickupsAtOnce:Int, duration:Duration) {
        self.difficulty = difficulty
        self.zombieCountAtOnce = zombieCountAtOnce
        self.syringePickupsAtOnce = syringePickupsAtOnce
        self.certificatePickupsAtOnce = certificatePickupsAtOnce
        self.duration = duration
    }
}
