//
//  Levels.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation

enum Level:Int, CaseIterable{
    case NewGame = 0
    case Meadow = 1
    case CitySkyline = 2
    case CityStreet = 3
    case Wallway = 4
    case CityJapan = 5
    case CityNight = 6
    case ScarryStreet = 7
    case MissionAccomplished = 8
    
    init?(levelIDString:String){
        switch levelIDString {
        case Level.NewGame.getDesc():
            self.init(rawValue: Level.NewGame.rawValue)
        case Level.Meadow.getDesc():
            self.init(rawValue: Level.Meadow.rawValue)
        case Level.CitySkyline.getDesc():
            self.init(rawValue: Level.CitySkyline.rawValue)
        case Level.CityStreet.getDesc():
            self.init(rawValue: Level.CityStreet.rawValue)
        case Level.CityNight.getDesc():
            self.init(rawValue: Level.CityNight.rawValue)
        case Level.CityJapan.getDesc():
            self.init(rawValue: Level.CityJapan.rawValue)
        case Level.Wallway.getDesc():
            self.init(rawValue: Level.Wallway.rawValue)
        case Level.ScarryStreet.getDesc():
            self.init(rawValue: Level.ScarryStreet.rawValue)
        case Level.MissionAccomplished.getDesc():
            self.init(rawValue: Level.MissionAccomplished.rawValue)
        default:
            self.init(rawValue: Level.Meadow.rawValue)
        }
    }
    
    func getDesc(currentLevel:Level? = nil)->String{
        let dCurLevel:Level = (currentLevel ?? self)
        switch dCurLevel {
        case .NewGame:
            return "New game"
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
        case .NewGame:
            return .Meadow
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
