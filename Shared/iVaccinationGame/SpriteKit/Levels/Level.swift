//
//  Levels.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation


enum Level:String{
    case Meadow = "Meadow"
    case CitySkyline = "City Skyline"
    case CityStreet = "City Street"
    case CityJapan = "City Japan"
    case ScarryStreet = "Scarry Street"
    case CityNight = "City Night"
    case Wallway = "Wallway"
    case MissionAccomplished = "Mission Accomplished"
    
    func getNextLevel(currentLevel:Level? = nil)->Level{
        let dCurLevel:Level = (currentLevel ?? self)
        switch dCurLevel {
        case .Meadow:
            return .CitySkyline
        case .CitySkyline:
            return .CityStreet
        case .CityStreet:
            return .Wallway
        case .Wallway:
            return .CityJapan
        case .CityJapan:
            return .CityNight
        case .CityNight:
            return .ScarryStreet
        case .ScarryStreet:
            return .MissionAccomplished
        default:
            return .Meadow
        }
    }
}
