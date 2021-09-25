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
    
    public var achivementCompleteAllLevelsID:String = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevels"
    public var achivementCompleteAllLevels:GKAchievement?
    
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
    
    private var _completeAllLevels:Int = 0
    public var CompleteAllLevels:Int{
        get{ return self._completeAllLevels }
        set{ self._completeAllLevels = newValue }
    }

    func add2perfectThrows(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementPerfectThrowsID, obj2Add2: &PerfectThrows, max2Add2: PerfectThrows, point2Add: 25)
    }
    
    func add2stayHealthy(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementStayHealthyID, obj2Add2: &StayHealthy, max2Add2: StayHealthy, point2Add: 15)
    }
    
    func add2completeAllLevels(times2Add:Int = 1){
        self.add2Achivement(identifier: achivementCompleteAllLevelsID, obj2Add2: &CompleteAllLevels, max2Add2: CompleteAllLevels, point2Add: 100)
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
//
//    func showBanner(title:String, message:String, completionHandler: (() -> Void)? = nil) {
//        if GKLocalPlayer.local.isAuthenticated {
//            DispatchQueue.main.async {
//                GKNotificationBanner.show(withTitle: title, message: message, duration: 3.0, completionHandler: completionHandler)
//            }
//        }
//    }

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
