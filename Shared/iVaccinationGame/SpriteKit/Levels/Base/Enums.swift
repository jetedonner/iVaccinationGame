//
//  Enums.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 02.10.21.
//

import Foundation
import SpriteKit

enum Difficulty:String{
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case nightmare = "Nightmare"
    
    func getSpeedFactor()->SpeedFactor{
        switch self {
        case .easy:
            return .easy
        case .medium:
            return .medium
        case .hard:
            return .hard
        case .nightmare:
            return .nightmare
        }
    }
}

enum Duration:Int{
    case Seconds10 = 10
    case Seconds30 = 30
    case Minutes1 = 60
    case Minutes2 = 120
    case Minutes3 = 180
    case Minutes5 = 300
}

enum SpeedFactor:CGFloat{
    case easy = 1.0
    case medium = 1.15
    case hard = 1.25
    case nightmare = 1.5
    
    var multiplier:CGFloat{
        get{ return self.rawValue }
    }
}
