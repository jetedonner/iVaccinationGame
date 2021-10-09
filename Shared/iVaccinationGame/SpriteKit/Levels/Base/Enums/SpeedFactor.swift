//
//  SpeedFactor.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 07.10.21.
//

import Foundation
import SpriteKit

enum SpeedFactor:CGFloat{
    case easy = 1.0
    case medium = 1.15
    case hard = 1.35
    case nightmare = 1.5
    
    var multiplier:CGFloat{
        get{ return self.rawValue }
    }
}
