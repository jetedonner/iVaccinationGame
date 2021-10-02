//
//  Levels.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation

enum Level:Int, CaseIterable{
    case Meadow = 1
    case CitySkyline = 2
    case CityStreet = 3
    case Wallway = 4
    case CityJapan = 5
    case CityNight = 6
    case ScarryStreet = 7
    case MissionAccomplished = 8
    
    func getDesc(currentLevel:Level? = nil)->String{
        let dCurLevel:Level = (currentLevel ?? self)
        switch dCurLevel {
        case .Meadow:
            return "Meadow"
        case .CitySkyline:
            return "City Skyline"
        case .CityStreet:
            return "City Street"
        case .Wallway:
            return "Wallway"
        case .CityJapan:
            return "City Japan"
        case .CityNight:
            return "City Night"
        case .ScarryStreet:
            return "Scarry Street"
        case .MissionAccomplished:
            return "Mission Accomplished"
        }
    }
    
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
