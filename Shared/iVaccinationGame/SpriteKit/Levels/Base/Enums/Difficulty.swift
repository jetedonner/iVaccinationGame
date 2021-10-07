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
