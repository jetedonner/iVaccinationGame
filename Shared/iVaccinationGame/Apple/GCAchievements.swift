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
    
    
//    public var achivements10HeadshotsID = "grp.ch.kimhauser.swift.suake3d.achievements.10headshots"
//    public var achivements10Headshots:GKAchievement?
//
//    public var achivements3GoodiesID = "grp.ch.kimhauser.swift.suake3d.achievements.3goodiesShooting"
//    public var achivements3Goodies:GKAchievement?
//
//    public var achivements20GoodiesID = "grp.ch.kimhauser.swift.suake3d.achievements.20goodies"
//    public var achivements20Goodies:GKAchievement?
//    public var achivements10PortationsID = "grp.ch.kimhauser.swift.suake3d.achievements.10portations"
//    public var achivements10Portations:GKAchievement?
//    public var achivementsAllFlags2MinutesID = "grp.ch.kimhauser.swift.suake3d.achivements.allflags2minutes"
//    public var achivementsAllFlags2Minutes:GKAchievement?
//    public var achivements10RedeemerID = "grp.ch.kimhauser.swift.suake3d.achievements.10redeemerkills"
//    public var achivements10Redeemer:GKAchievement?
    
    
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
//
//    private let headShots10AchievementCount:Int = 10
//    public var HeadShots10AchievementCount:Int{
//        get{ return headShots10AchievementCount }
//        //set{ headShots10AchievementCount = newValue }
//    }
//
//    private var redeemerKills:Int = 0
//    public var RedeemerKills:Int{
//        get{ return redeemerKills }
//        set{ redeemerKills = newValue }
//    }
//
//    private let redeemerKills10AchievementCount:Int = 10
//    public var RedeemerKills10AchievementCount:Int{
//        get{ return redeemerKills10AchievementCount }
//        //set{ headShots10AchievementCount = newValue }
//    }
//
//    private var goodiesWithShooting:Int = 0
//    public var GoodiesWithShooting:Int{
//        get{ return goodiesWithShooting }
//        set{ goodiesWithShooting = newValue }
//    }
//
//    private var goodiesWithMoving:Int = 0
//    public var GoodiesWithMoving:Int{
//        get{ return goodiesWithMoving }
//        set{ goodiesWithMoving = newValue }
//    }
//
//    private let goodiesWithShooting3AchievementMessage:String = "You catched 3 Goodies with shooting - well done!!!"
//    private let goodiesWithShooting3AchievementCount:Int = 3
//    public var GoodiesWithShooting3AchievementCount:Int{
//        get{ return goodiesWithShooting3AchievementCount }
//    }
//
//    private let goodiesWithMoving20AchievementCount:Int = 20
//    public var GoodiesWithMoving20AchievementCount:Int{
//        get{ return goodiesWithMoving20AchievementCount }
//        //set{ headShots10AchievementCount = newValue }
//    }
//
//    private var portations:Int = 0
//    public var Portations:Int{
//        get{ return portations }
//        set{ portations = newValue }
//    }
//
//    private let portations10AchievementCount:Int = 10
//    public var Portations10AchievementCount:Int{
//        get{ return portations10AchievementCount }
//        //set{ headShots10AchievementCount = newValue }
//    }
//
//    private var allFlags2Minutes:Int = 0
//    public var AllFlags2Minutes:Int{
//        get{ return allFlags2Minutes }
//        set{ allFlags2Minutes = newValue }
//    }
//
//    private let allFlags2MinutesAchievementCount:Int = 180 // Seconds
//    public var AllFlags2MinutesAchievementCount:Int{
//        get{ return allFlags2MinutesAchievementCount }
//        //set{ headShots10AchievementCount = newValue }
//    }
//
//    func add2GoodiesAchivement(point2Add:Int = 1){
//
//        self.add2Achivement(identifier: achivements3GoodiesID, obj2Add2: &GoodiesWithShooting, max2Add2: GoodiesWithShooting3AchievementCount, point2Add: point2Add, message: goodiesWithShooting3AchievementMessage)
//
//        self.add2Achivement(identifier: achivements20GoodiesID, obj2Add2: &GoodiesWithMoving, max2Add2: GoodiesWithMoving20AchievementCount, point2Add: point2Add)
//    }
//
    func add2perfectThrows(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementPerfectThrowsID, obj2Add2: &PerfectThrows, max2Add2: PerfectThrows, point2Add: 25)
    }
    
    func add2stayHealthy(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementStayHealthyID, obj2Add2: &StayHealthy, max2Add2: StayHealthy, point2Add: 15)
    }
//
//    func add2RedeemerAchivement(point2Add:Int = 1){
//        self.add2Achivement(identifier: achivements10RedeemerID, obj2Add2: &RedeemerKills, max2Add2: RedeemerKills10AchievementCount, point2Add: point2Add)
//    }
//
//    func add2PortalAchivement(point2Add:Int = 1){
//        self.add2Achivement(identifier: achivements10PortationsID, obj2Add2: &Portations, max2Add2: portations10AchievementCount, point2Add: point2Add)
//    }
//
//    func add2AllFlagsAchivement(point2Add:Int = 1){
//        self.add2Achivement(identifier: achivementsAllFlags2MinutesID, obj2Add2: &AllFlags2Minutes, max2Add2: AllFlags2MinutesAchievementCount, point2Add: point2Add)
//    }
//
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
//
//    func showBanner(title:String, message:String, completionHandler: (() -> Void)? = nil) {
//        if GKLocalPlayer.local.isAuthenticated {
//            DispatchQueue.main.async {
//                GKNotificationBanner.show(withTitle: title, message: message, duration: 3.0, completionHandler: completionHandler)
//            }
//        }
//    }
//
    func completeAchivement(identifier:String, percent:Double = 100.0, message:String? = nil){
        if GKLocalPlayer.local.isAuthenticated {
            let achivement:GKAchievement = GKAchievement(identifier: identifier, player: GKLocalPlayer.local)
            achivement.showsCompletionBanner = true
            achivement.percentComplete = percent
            GKAchievement.report([achivement], withCompletionHandler: { error in

            })
//            if(message != nil){
//                self.showBanner(title: "Achivement completed", message: message!)
//            }
        }
    }
//
//    public var achievements:[GKAchievement]!
//
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
//
//    func getAllCompletedAchivements(){
//        if GKLocalPlayer.local.isAuthenticated {
//            GKAchievement.loadAchievements(completionHandler: { achievements, error in
//                if error != nil {
//                    if let error = error {
//                        print("Error in loading achievements: \(error)")
//                    }
//                }
//                if achievements != nil {
//                    self.achievements = achievements
//                    for achievement in achievements! {
//                        if(achievement.isCompleted){
//                            print("Achievements: ID: " + achievement.identifier + ", " + achievement.percentComplete.description + "% complete")
//                            if(achievement.identifier == GameCenterHelper.achievements.achivements10HeadshotsID){
//                                print("Achievement: Headshot 10 completed")
//                                self.HeadShots = self.HeadShots10AchievementCount
//                            }else if(achievement.identifier == GameCenterHelper.achievements.achivements20GoodiesID){
//                                print("Achievement: Goodies 20 completed")
//                                self.GoodiesWithMoving = self.GoodiesWithMoving20AchievementCount
////                            }else if(achievement.identifier == GameCenterHelper.achievements.achivements20GoodiesID){
////                                print("Achievement: Goodies 20 completed")
//                            }
//                            //                            if(achievement.identifier == self.achivements10HeadshotsID){
//                            //                                self.headShots = self.headShots10AchievementCount
//                            //                            }
//                        }
//                    }
//                }
//            })
//        }
//    }
}
