//
//  Levels.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation


//enum Level:String{
//    case Meadow = "Meadow"
//    case CitySkyline = "City Skyline"
//    case CityStreet = "City Street"
//    case CityJapan = "City Japan"
//    case ScarryStreet = "Scarry Street"
//    case CityNight = "City Night"
//    case Wallway = "Wallway"
//    case MissionAccomplished = "Mission Accomplished"
//
//    func getNextLevel(currentLevel:Level? = nil)->Level{
//        let dCurLevel:Level = (currentLevel ?? self)
//        switch dCurLevel {
//        case .Meadow:
//            return .CitySkyline
//        case .CitySkyline:
//            return .CityStreet
//        case .CityStreet:
//            return .Wallway
//        case .Wallway:
//            return .CityJapan
//        case .CityJapan:
//            return .CityNight
//        case .CityNight:
//            return .ScarryStreet
//        case .ScarryStreet:
//            return .MissionAccomplished
//        default:
//            return .Meadow
//        }
//    }
//}

enum Level:Int, CaseIterable{
    case Meadow = 1 // "Meadow"
    case CitySkyline = 2 // "City Skyline"
    case CityStreet = 3 // "City Street"
    case Wallway = 4 // "Wallway"
    case CityJapan = 5 // "City Japan"
    case CityNight = 6 // "City Night"
    case ScarryStreet = 7 // "Scarry Street"
    case MissionAccomplished = 8 // "Mission Accomplished"
    
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
            return "City Japan"
        case .CityJapan:
            return "City Night"
        case .CityNight:
            return "Scarry Street"
        case .ScarryStreet:
            return "Mission Accomplished"
        default:
            return "[NONE]"
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
