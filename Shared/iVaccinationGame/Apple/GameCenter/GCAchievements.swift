//
//  Suake3DAchievement.swift
//  Suake3D-swift
//
//  Created by dave on 29.02.20.
//  Copyright © 2020 ch.kimhauser. All rights reserved.
//

import Foundation
import SceneKit
import GameKit

class GCAchievements:NSObject{
    
    public static var shared:GCAchievements = GCAchievements()
    
    public var achivementPerfectThrowsID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.perfectthrows"
    public var achivementPerfectThrows:GKAchievement?
    
    public var achivementStayHealthyID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.stayhealthy"
    public var achivementStayHealthy:GKAchievement?
    
    public var achivementCollectAllCertsID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.collectallcertificates"
    public var achivementCollectAllCerts:GKAchievement?
    
    public var achivementCompleteAllLevelsID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevels"
    public var achivementCompleteAllLevels:GKAchievement?
    
    public var achivementCompleteAllLevelsPerfectThrowID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.gameperfectthrows"
    public var achivementCompleteAllLevelsPerfectThrow:GKAchievement?
    
    public var achivementCompleteAllLevelsPerfectHealthID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.gameperfecthealth"
    public var achivementCompleteAllLevelsPerfectHealth:GKAchievement?
    
    public var achivementCompleteAllLevelsPerfectCertsID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.gameperfectcertificates"
    public var achivementCompleteAllLevelsPerfectCerts:GKAchievement?
    
    
    
    public var achivementCompleteAllLevelsEasyID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevelseasy"
    public var achivementCompleteAllLevelsEasy:GKAchievement?
    
    public var achivementCompleteAllLevelsMediumID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevelsmedium"
    public var achivementCompleteAllLevelsMedium:GKAchievement?
    
    public var achivementCompleteAllLevelsHardID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevelshard"
    public var achivementCompleteAllLevelsHard:GKAchievement?
    
    public var achivementCompleteAllLevelsNightmareID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevelsnightmare"
    public var achivementCompleteAllLevelsNightmare:GKAchievement?
    
    
    
    
    
    private var _perfectThrows:Int = 0
    public var PerfectThrows:Int{
        get{ return self._perfectThrows }
        set{ self._perfectThrows = newValue }
    }
    
    private var _stayHealthy:Int = 0
    public var StayHealthy:Int{
        get{ return self._stayHealthy }
        set{ self._stayHealthy = newValue }
    }
    
    private var _collectAllCerts:Int = 0
    public var CollectAllCerts:Int{
        get{ return self._collectAllCerts }
        set{ self._collectAllCerts = newValue }
    }
    
    private var _completeAllLevels:Int = 0
    public var CompleteAllLevels:Int{
        get{ return self._completeAllLevels }
        set{ self._completeAllLevels = newValue }
    }
    
    private var _completeAllLevelsEasy:Int = 0
    public var CompleteAllLevelsEasy:Int{
        get{ return self._completeAllLevelsEasy }
        set{ self._completeAllLevelsEasy = newValue }
    }
    
    private var _completeAllLevelsMedium:Int = 0
    public var CompleteAllLevelsMedium:Int{
        get{ return self._completeAllLevelsMedium }
        set{ self._completeAllLevelsMedium = newValue }
    }
    
    private var _completeAllLevelsHard:Int = 0
    public var CompleteAllLevelsHard:Int{
        get{ return self._completeAllLevelsHard }
        set{ self._completeAllLevelsHard = newValue }
    }
    
    private var _completeAllLevelsNightmare:Int = 0
    public var CompleteAllLevelsNightmare:Int{
        get{ return self._completeAllLevelsNightmare }
        set{ self._completeAllLevelsNightmare = newValue }
    }
    
    private var _completeAllLevelsPerfectThrows:Int = 0
    public var CompleteAllLevelsPerfectThrows:Int{
        get{ return self._completeAllLevelsPerfectThrows }
        set{ self._completeAllLevelsPerfectThrows = newValue }
    }
    
    private var _completeAllLevelsPerfectHealth:Int = 0
    public var CompleteAllLevelsPerfectHealth:Int{
        get{ return self._completeAllLevelsPerfectHealth }
        set{ self._completeAllLevelsPerfectHealth = newValue }
    }
    
    private var _completeAllLevelsPerfectCerts:Int = 0
    public var CompleteAllLevelsPerfectCerts:Int{
        get{ return self._completeAllLevelsPerfectCerts }
        set{ self._completeAllLevelsPerfectCerts = newValue }
    }

    func add2perfectThrows(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementPerfectThrowsID, obj2Add2: &PerfectThrows, max2Add2: PerfectThrows, point2Add: 25)
    }
    
    func add2stayHealthy(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementStayHealthyID, obj2Add2: &StayHealthy, max2Add2: StayHealthy, point2Add: 15)
    }
    
    func add2collectAllCerts(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCollectAllCertsID, obj2Add2: &CollectAllCerts, max2Add2: CollectAllCerts, point2Add: 25)
    }
    
    func add2completeAllLevels(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsID, obj2Add2: &CompleteAllLevels, max2Add2: CompleteAllLevels, point2Add: 100)
    }
    
    func add2completeAllLevelsEasy(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsEasyID, obj2Add2: &CompleteAllLevelsEasy, max2Add2: CompleteAllLevelsEasy, point2Add: 100)
    }
    
    func add2completeAllLevelsMedium(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsMediumID, obj2Add2: &CompleteAllLevelsMedium, max2Add2: CompleteAllLevelsMedium, point2Add: 100)
    }
    
    func add2completeAllLevelsHard(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsHardID, obj2Add2: &CompleteAllLevelsHard, max2Add2: CompleteAllLevelsHard, point2Add: 100)
    }
    
    func add2completeAllLevelsNightmare(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsNightmareID, obj2Add2: &CompleteAllLevelsNightmare, max2Add2: CompleteAllLevelsNightmare, point2Add: 100)
    }
    
    func add2completeAllLevelsPerfectThrow(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsPerfectThrowID, obj2Add2: &CompleteAllLevels, max2Add2: CompleteAllLevels, point2Add: 100)
    }
    
    func add2completeAllLevelsPerfectHealth(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsPerfectHealthID, obj2Add2: &CompleteAllLevelsPerfectHealth, max2Add2: CompleteAllLevelsPerfectHealth, point2Add: 100)
    }
    
    func add2completeAllLevelsPerfectCerts(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsPerfectCertsID, obj2Add2: &CompleteAllLevelsPerfectCerts, max2Add2: CompleteAllLevelsPerfectCerts, point2Add: 100)
    }

    @discardableResult
    func add2Achivement(identifier:String, obj2Add2: inout Int, max2Add2:Int, point2Add:Int = 1, message:String? = nil)->Bool{
        if(obj2Add2 <= max2Add2){
            obj2Add2 += point2Add
            if(obj2Add2 >= max2Add2){
                self.completeAchivement(identifier: identifier, message: message)
                return true
            }
        }
        return false
    }

    func completeAchivement(identifier:String, percent:Double = 100.0, message:String? = nil){
        if GKLocalPlayer.local.isAuthenticated {
            let achivement:GKAchievement = GKAchievement(identifier: identifier, player: GKLocalPlayer.local)
            achivement.showsCompletionBanner = true
            achivement.percentComplete = percent
            GKAchievement.report([achivement], withCompletionHandler: { error in

            })
        }
    }

    func resetAllCompletedAchivements(){
        GKAchievement.resetAchievements(completionHandler: { error in
            if error != nil {
                if let error = error {
                    print("Could not reset achievements due to \(error)")
                }
            }else{
                print("Your Game Center Achivements have been resetted successfully!")
            }
        })
    }
}
