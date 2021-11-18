//
//  UserDefaultsHelper.swift
//  UserDefaultsHelper
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit

enum UserDefaultsName:String{
    case firstStart = "firstStart"
    case roundTime = "roundTime"
    case difficulty = "difficulty"
    case level = "level"
    case playSounds = "playSounds"
    case playBGMusic = "playBGMusic"
    case playSoundEffects = "playSoundEffects"
    
    case volume = "volume"
    case useGameCenter = "useGameCenter"
    case uploadHighscore = "uploadHighscore"
    case autoNightMode = "autoNightMode"
    case devMode = "devMode"
    case devLevel = "devLevel"
    
    case dbgBorders = "dbgBorders"
    
    case levelID = "levelID"
    case oldLevelID = "oldLevelID"
    case highscore = "highscore"
    case score = "score"
    case certificates = "certificates"
    case certificate = "certificate"
    case vaccinations = "vaccinations"
    case vaccination = "vaccination"

    case playerName = "playerName"
    case useOnlineCompetitions = "useOnlineCompetitions"
    case useScoreboard = "useScoreboard"
    case useAchievements = "useAchievements"
    
    case onlineCompetitionWebserver = "onlineCompetitionWebserver"
    case onlineCompetitionWebservice = "onlineCompetitionWebservice"
    case onlineScoreboardLink = "onlineScoreboardLink"
    
    case doctorPos = "doctorPos"
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
    
    static var difficulty:Difficulty{
        get{
            var retDiff:Difficulty = .easy
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
    
    
    static var oldLevelID:Level{
        set{ self.defaults.set(newValue.getDesc(), forKey: UserDefaultsName.oldLevelID.rawValue) }
        get{
            if(self.defaults.value(forKey: UserDefaultsName.oldLevelID.rawValue) == nil){
                self.defaults.set(Level.Meadow.getDesc(), forKey: UserDefaultsName.oldLevelID.rawValue)
            }
            return Level(levelIDString: defaults.string(forKey: UserDefaultsName.oldLevelID.rawValue)!)!
        }
    }
    
    static var levelID:Level{
        set{ self.defaults.set(newValue.getDesc(), forKey: UserDefaultsName.levelID.rawValue) }
        get{
            if(self.defaults.value(forKey: UserDefaultsName.levelID.rawValue) == nil){
                self.defaults.set(Level.Meadow.getDesc(), forKey: UserDefaultsName.levelID.rawValue)
            }
            return Level(levelIDString: defaults.string(forKey: UserDefaultsName.levelID.rawValue)!)!
        }
    }
    
//    static var levelProgress:Level{
//        set{ self.defaults.set(newValue.getDesc(), forKey: UserDefaultsName.levelProgress.rawValue) }
//        get{
//            if(self.defaults.value(forKey: UserDefaultsName.levelProgress.rawValue) == nil){
//                self.defaults.set(Level.Meadow.getDesc(), forKey: UserDefaultsName.levelProgress.rawValue)
//            }
//            return Level(levelIDString: defaults.string(forKey: UserDefaultsName.levelProgress.rawValue)!)!
//        }
//    }
    
    static func resetUserDefValues(resetFirstStart:Bool = true){
        UserDefaultsHelper.highscore = 0
        UserDefaultsHelper.certificates = 0
        UserDefaultsHelper.vaccinations = 0
        UserDefaultsHelper.level = Level.NewGame.getDesc()
        UserDefaultsHelper.difficulty = .easy
        if(resetFirstStart){
            UserDefaultsHelper.firstStart = true
        }
        for level in Level.allCases{
            UserDefaultsHelper.score[level.getDesc()] = 0
            UserDefaultsHelper.certificate[level.getDesc()] = 0
            UserDefaultsHelper.vaccination[level.getDesc()] = 0
        }
        
    }
    
    static var certificates:Int{
        get{
            return self.defaults.integer(forKey: UserDefaultsName.certificates.rawValue)
        }
        set{ self.defaults.set(newValue, forKey: UserDefaultsName.certificates.rawValue) }
    }
    
    static var vaccinations:Int{
        get{
            return self.defaults.integer(forKey: UserDefaultsName.vaccinations.rawValue)
        }
        set{ self.defaults.set(newValue, forKey: UserDefaultsName.vaccinations.rawValue) }
    }
    
    static var highscore:Int{
        get{
            return self.defaults.integer(forKey: UserDefaultsName.highscore.rawValue)
        }
        set{ self.defaults.set(newValue, forKey: UserDefaultsName.highscore.rawValue) }
    }
    
    static var score:[String:Int]{
        get{
            return (self.defaults.dictionary(forKey: UserDefaultsName.score.rawValue) != nil ? self.defaults.dictionary(forKey: UserDefaultsName.score.rawValue) as! [String:Int] : [Level.Meadow.getDesc(): 0])
        }
        set{ self.defaults.set(newValue, forKey: UserDefaultsName.score.rawValue) }
    }

    static var certificate:[String:Int]{
        get{
            return (self.defaults.dictionary(forKey: UserDefaultsName.certificate.rawValue) != nil ? self.defaults.dictionary(forKey: UserDefaultsName.certificate.rawValue) as! [String:Int] : [Level.Meadow.getDesc(): 0])
        }
        set{ self.defaults.set(newValue, forKey: UserDefaultsName.certificate.rawValue) }
    }
    
    static var vaccination:[String:Int]{
        get{
            return (self.defaults.dictionary(forKey: UserDefaultsName.vaccination.rawValue) != nil ? self.defaults.dictionary(forKey: UserDefaultsName.vaccination.rawValue) as! [String:Int] : [Level.Meadow.getDesc(): 0])
        }
        set{ self.defaults.set(newValue, forKey: UserDefaultsName.vaccination.rawValue) }
    }
    
    static var level:String{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.level.rawValue) == nil){
                self.defaults.set(Level.NewGame.getDesc(), forKey: UserDefaultsName.level.rawValue)
            }
            return defaults.string(forKey: UserDefaultsName.level.rawValue)!
        }
        set{
            self.defaults.set(newValue, forKey: UserDefaultsName.level.rawValue)
        }
    }
    
    static var playerName:String{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.playerName.rawValue) == nil){
                self.defaults.set(NSFullUserName(), forKey: UserDefaultsName.playerName.rawValue)
            }
            return defaults.string(forKey: UserDefaultsName.playerName.rawValue)!
        }
        set{
            self.defaults.set(newValue, forKey: UserDefaultsName.playerName.rawValue)
        }
    }
    
    
    static var onlineCompetitionURL:String{
        get{ return self.onlineCompetitionWebserver + (self.onlineCompetitionWebserver.last == "/" ? "" : "/" ) + self.onlineCompetitionWebservice }
    }
    
    static var onlineCompetitionWebserver:String{
        get{
            if(self.defaults.string(forKey: UserDefaultsName.onlineCompetitionWebserver.rawValue) == nil){
                self.defaults.set(VersionHelper.getOnlineWebserver(), forKey: UserDefaultsName.onlineCompetitionWebserver.rawValue)
            }
            return defaults.string(forKey: UserDefaultsName.onlineCompetitionWebserver.rawValue)!
        }
        set{
            self.defaults.set(newValue, forKey: UserDefaultsName.onlineCompetitionWebserver.rawValue)
        }
    }
    
    static var onlineCompetitionWebservice:String{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.onlineCompetitionWebservice.rawValue) == nil){
                self.defaults.set(VersionHelper.getOnlineWebservice(), forKey: UserDefaultsName.onlineCompetitionWebservice.rawValue)
            }
            return defaults.string(forKey: UserDefaultsName.onlineCompetitionWebservice.rawValue)!
        }
        set{
            self.defaults.set(newValue, forKey: UserDefaultsName.onlineCompetitionWebservice.rawValue)
        }
    }
    
    static var onlineScoreboardLink:String{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.onlineScoreboardLink.rawValue) == nil){
                self.defaults.set(VersionHelper.getOnlineScoreboardLink(), forKey: UserDefaultsName.onlineScoreboardLink.rawValue)
            }
            return defaults.string(forKey: UserDefaultsName.onlineScoreboardLink.rawValue)!
        }
        set{
            self.defaults.set(newValue, forKey: UserDefaultsName.onlineScoreboardLink.rawValue)
        }
    }
    
    
    static var autoNightMode:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.autoNightMode.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.autoNightMode.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.autoNightMode.rawValue)
        }
    }
    
    static var useGameCenter:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.useGameCenter.rawValue) == nil){
                self.defaults.set(false, forKey: UserDefaultsName.useGameCenter.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.useGameCenter.rawValue)
        }
    }
    
    static var useOnlineCompetitions:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.useOnlineCompetitions.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.useOnlineCompetitions.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.useOnlineCompetitions.rawValue)
        }
    }
    
    static var useScoreboard:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.useScoreboard.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.useScoreboard.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.useScoreboard.rawValue)
        }
    }
    
    static var useAchievements:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.useAchievements.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.useAchievements.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.useAchievements.rawValue)
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
    
    static var playSoundEffects:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.playSoundEffects.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.playSoundEffects.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.playSoundEffects.rawValue)
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
    
    static var devLevel:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.devLevel.rawValue) == nil){
                self.defaults.set(false, forKey: UserDefaultsName.devLevel.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.devLevel.rawValue)
        }
    }
    
    static var dbgBorders:Bool{
        get{
            if(self.defaults.value(forKey: UserDefaultsName.dbgBorders.rawValue) == nil){
                self.defaults.set(false, forKey: UserDefaultsName.dbgBorders.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.dbgBorders.rawValue)
        }
    }
    
    static var firstStart:Bool{
        get{
//            self.defaults.set(true, forKey: UserDefaultsName.firstStart.rawValue)
            if(self.defaults.value(forKey: UserDefaultsName.firstStart.rawValue) == nil){
                self.defaults.set(true, forKey: UserDefaultsName.firstStart.rawValue)
            }
            return self.defaults.bool(forKey: UserDefaultsName.firstStart.rawValue)
        }
        set{
            self.defaults.set(newValue, forKey: UserDefaultsName.firstStart.rawValue)
        }
    }
    
    static func resetAllUserDefaults(){
        let domain = Bundle.main.bundleIdentifier!
        self.defaults.removePersistentDomain(forName: domain)
        self.loadStandardValues()
        self.defaults.synchronize()
        self.defaults.setPersistentDomain(self.defaults.dictionaryRepresentation(), forName: domain)
//        self.defaults.synchronize()
//        print(Array(self.defaults.dictionaryRepresentation().keys).count)
    }
    
    static func loadStandardValues(){
        self.defaults.register(
            defaults: NSDictionary(
                contentsOf: Bundle.main.url(forResource: "Defaults", withExtension: "plist")!
            )! as! [String : Any]
        )
        self.playerName = NSFullUserName()
    }
    
    @discardableResult
    static func inDevMode(block: @escaping ()->Any?)->Any?{
        return self.inDevMode(block: block, or: true)
    }
    
    @discardableResult
    static func inDevMode(block: @escaping ()->Any?, or:Bool = true)->Any?{
        if(self.devMode || or){
            return block()
        }
        return nil
    }
    
    @discardableResult
    static func inDevMode(block: @escaping ()->Any?, and:Bool = true)->Any?{
        if(self.devMode && and){
            return block()
        }
        return nil
    }
}
