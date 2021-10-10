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
    var zombieRespawnTimeRange:CountableClosedRange<Int> = 2...4
    
    var syringePickupsAtOnce:Int = 1
    
    var certificatePickupsAtOnce:Int = 1
    var certificateRespawnTimeRange:CountableClosedRange<Int> = 5...13
    
    var duration:Duration = .Minutes1
    var gameDuration:Double{
        get{ return Double(self.duration.rawValue) }
    }
    
    var speedFactor:SpeedFactor{
        get{ return self.difficulty.getSpeedFactor() }
    }
    
    var zombiePaths:[BasePath] = []
    
    init(difficulty:Difficulty,
         zombieCountAtOnce:Int,
         syringePickupsAtOnce:Int,
         certificatePickupsAtOnce:Int,
         duration:Duration,
         zombieRespawnTimeRange:CountableClosedRange<Int> = 2...4,
         certificateRespawnTimeRange:CountableClosedRange<Int> = 5...13) {
        self.difficulty = difficulty
        self.zombieCountAtOnce = zombieCountAtOnce
        self.syringePickupsAtOnce = syringePickupsAtOnce
        self.certificatePickupsAtOnce = certificatePickupsAtOnce
        if(VersionHelper.getDevMode() && UserDefaultsHelper.devMode){
            self.duration = Duration.Seconds30// Duration(rawValue: Int(UserDefaultsHelper.roundTime))!
        }else{
            self.duration = duration
        }
        self.zombieRespawnTimeRange = zombieRespawnTimeRange
        self.certificateRespawnTimeRange = certificateRespawnTimeRange
    }
}
