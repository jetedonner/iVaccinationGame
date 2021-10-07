//
//  SpeedFactor.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 07.10.21.
//

import Foundation

enum SpeedFactor:CGFloat{
    case easy = 1.0
    case medium = 1.25
    case hard = 1.5
    case nightmare = 1.75
    
    var multiplier:CGFloat{
        get{ return self.rawValue }
    }
}
