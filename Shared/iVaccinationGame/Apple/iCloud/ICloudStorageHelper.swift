//
//  ICloudStorageHelper.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation

class ICloudStorageHelper{
    
    static let highscoreKey = "highscore"
    static let levelKey = "level"
    static let difficultyKey = "difficulty"
    static let scoreKey = "score"
    
    static var highscore:Int{
        get{ return Int(NSUbiquitousKeyValueStore.default.longLong(forKey: self.highscoreKey)) }
        set{ NSUbiquitousKeyValueStore.default.set(newValue, forKey: self.highscoreKey) }
    }
    
    static var level:String{
        get{ return (NSUbiquitousKeyValueStore.default.string(forKey: self.levelKey) != nil ? NSUbiquitousKeyValueStore.default.string(forKey: self.levelKey)! : "Meadow") }
        set{ NSUbiquitousKeyValueStore.default.set(newValue, forKey: self.levelKey) }
    }
    
    static var score:[String:Int]{
        get{
            return (NSUbiquitousKeyValueStore.default.dictionary(forKey: self.scoreKey) != nil ? NSUbiquitousKeyValueStore.default.dictionary(forKey: self.scoreKey) as! [String:Int] : ["Meadow": 0])
        }
        set{ NSUbiquitousKeyValueStore.default.set(newValue, forKey: self.scoreKey) }
    }
    
    static var difficulty:String{
        get{ return (NSUbiquitousKeyValueStore.default.string(forKey: self.difficultyKey) != nil ? NSUbiquitousKeyValueStore.default.string(forKey: self.difficultyKey)! : "Easy") }
        set{ NSUbiquitousKeyValueStore.default.set(newValue, forKey: self.difficultyKey) }
    }
}
