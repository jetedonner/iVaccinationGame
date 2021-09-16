//
//  UserDefaultsHelper.swift
//  UserDefaultsHelper
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation

enum UserDefaultsName:String{
    case roundTime = "roundTime"
    case difficulty = "difficulty"
    case level = "level"
    case playSounds = "playSounds"
    case playBGMusic = "playBGMusic"
    case volume = "volume"
    case useGameCenter = "useGameCenter"
    case uploadHighscore = "uploadHighscore"
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
                break
            }
            return retDiff
        }
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
            }
        }
    }
    
    static var level:String{
        get{
            switch defaults.string(forKey: UserDefaultsName.level.rawValue){
            case "Random":
                return "LandscapeNight"
            case "Standard":
                return "Landscape"
            case "Standard (Night)":
                return "LandscapeNight"
            default:
                return "Landscape"
            }
        }
    }
    
    static var useGameCenter:Bool{
        get{
            return self.defaults.bool(forKey: UserDefaultsName.useGameCenter.rawValue)
        }
    }
    
    static var uploadHighscore:Bool{
        get{
            return self.defaults.bool(forKey: UserDefaultsName.uploadHighscore.rawValue)
        }
    }
    
    static var playSounds:Bool{
        get{
            return self.defaults.bool(forKey: UserDefaultsName.playSounds.rawValue)
        }
    }
    
    static var playBGMusic:Bool{
        get{ 
            return self.defaults.bool(forKey: UserDefaultsName.playBGMusic.rawValue)
        }
    }
}
