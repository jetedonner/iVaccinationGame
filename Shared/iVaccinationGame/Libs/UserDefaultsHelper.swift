//
//  UserDefaultsHelper.swift
//  UserDefaultsHelper
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit

enum UserDefaultsName:String{
    case roundTime = "roundTime"
    case difficulty = "difficulty"
    case level = "level"
    case playSounds = "playSounds"
    case playBGMusic = "playBGMusic"
    case volume = "volume"
    case useGameCenter = "useGameCenter"
    case uploadHighscore = "uploadHighscore"
    case devMode = "devMode"
    
    case levelID = "levelID"
    case score = "score"
    case cretificates = "cretificates"
}


enum UserDefaultsDifficulty:String{
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case nightmare = "Nightmare"
}

class UserDefaultsHelper{
    
    static let defaults = UserDefaults.standard
    
    static var roundTime:TimeInterval{
        get{
            var retTime:TimeInterval = 60
            switch defaults.string(forKey: UserDefaultsName.roundTime.rawValue){
            case "10 Seconds":
                retTime = 10
                break
            case "30 Seconds":
                retTime = 30
                break
            case "1 Minute":
                retTime = 60
                break
            case "2 Minutes":
                retTime = 120
                break
            case "3 Minutes":
                retTime = 180
                break
            default:
                retTime = 30
                break
            }
            return retTime
        }
    }
    
    static var difficulty:UserDefaultsDifficulty{
        get{
            var retDiff:UserDefaultsDifficulty = .easy
            switch defaults.string(forKey: UserDefaultsName.difficulty.rawValue){
            case "Easy":
                retDiff = .easy
                break
            case "Medium":
                retDiff = .medium
                break
            case "Hard":
                retDiff = .hard
                break
            case "Nightmare":
                retDiff = .nightmare
                break
            default:
                retDiff = .easy
                break
            }
            return retDiff
        }
        set{ defaults.set(newValue.rawValue, forKey: UserDefaultsName.difficulty.rawValue) }
    }
    
    static var speedMultiplierForDifficulty:CGFloat{
        get{
            switch self.difficulty{
            case .easy:
                return 1.5
            case .medium:
                return 2.0
            case .hard:
                return 2.75
            case .nightmare:
                return 3.75
//            default:
//                return 1.5
            }
        }
    }
    
//    static var _levelID:Level = .Meadow
//    static var levelID:Level{
//        get{ self._levelID }
//        set{ self._levelID = newValue }
//    }
    
    static var levelID:Level{
        set{ self.defaults.set(newValue.getDesc(), forKey: UserDefaultsName.levelID.rawValue) }
        get{
            if(self.defaults.value(forKey: UserDefaultsName.levelID.rawValue) == nil){
                self.defaults.set(Level.Meadow.getDesc(), forKey: UserDefaultsName.levelID.rawValue)
            }
            let levelIDString = defaults.string(forKey: UserDefaultsName.levelID.rawValue)!
            switch levelIDString {
            case Level.Meadow.getDesc():
                return .Meadow
            case Level.CitySkyline.getDesc():
                return .CitySkyline
            case Level.CityStreet.getDesc():
                return .CityStreet
            case Level.CityNight.getDesc():
                return .CityNight
            case Level.CityJapan.getDesc():
                return .CityJapan
            case Level.Wallway.getDesc():
                return .Wallway
            case Level.ScarryStreet.getDesc():
                return .ScarryStreet
            default:
                return .Meadow
            }
        }
    }
    
    static var score:Int{
        get{
//            if(self.defaults.integer(forKey: UserDefaultsName.score.rawValue) == nil){
//                self.defaults.set(0, forKey: UserDefaultsName.score.rawValue)
//            }
            return self.defaults.integer(forKey: UserDefaultsName.score.rawValue)
        }
        set{ self.defaults.set(newValue, forKey: UserDefaultsName.score.rawValue) }
    }
    
    static var level:String{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.level.rawValue) == nil){
                self.defaults.set("City Skyline", forKey: UserDefaultsName.level.rawValue)
            }
            return defaults.string(forKey: UserDefaultsName.level.rawValue)!
        }
    }
    
    static var useGameCenter:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.useGameCenter.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.useGameCenter.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.useGameCenter.rawValue)
        }
    }
    
    static var uploadHighscore:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.uploadHighscore.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.uploadHighscore.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.uploadHighscore.rawValue)
        }
    }
    
    static var playSounds:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.playSounds.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.playSounds.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.playSounds.rawValue)
        }
    }
    
    static var playBGMusic:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.playBGMusic.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.playBGMusic.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.playBGMusic.rawValue)
        }
    }
    
    static var volume:Float{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.volume.rawValue) == nil){
                self.defaults.set(0.5, forKey: UserDefaultsName.volume.rawValue)
            }
            return self.defaults.float(forKey: UserDefaultsName.volume.rawValue)
        }
        set{ self.defaults.set(newValue, forKey: UserDefaultsName.volume.rawValue) }
    }
    
    static var devMode:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.devMode.rawValue) == nil){
                self.defaults.set(false, forKey: UserDefaultsName.devMode.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.devMode.rawValue)
        }
    }
}
