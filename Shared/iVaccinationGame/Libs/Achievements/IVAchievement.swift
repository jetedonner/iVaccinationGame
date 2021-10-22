//
//  IVAchievement.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 15.10.21.
//

import Foundation
#if os(macOS)
import Cocoa
#else
import UIKit
#endif

protocol IVAchievementDelegate{
    func checkAchievementAccomplished(gameScene:GameSceneBase, achievement:IVAchievement)->Bool
}

class IVAchievement{
    let achievementId:AchievementId
    var achievementTitle:String = ""
    var achievementDesc:String = ""
    var achievementImage:String = ""
    var achievementScore:Int = 100
    var check: (_ gameScene:GameSceneBase, _ achievement:IVAchievement)->Bool
    
    init(achievementId:AchievementId, achievementTitle:String, achievementDesc:String, achievementImage:String, achievementScore:Int, check: @escaping (_ gameScene:GameSceneBase, _ achievement:IVAchievement)->Bool ){
        self.achievementId = achievementId
        self.achievementTitle = achievementTitle
        self.achievementDesc = achievementDesc
        self.achievementImage = achievementImage
        self.check = check
    }
    
    func checkAchievementAccomplished(gameScene:GameSceneBase, achievement:IVAchievement)->Bool{
        return self.check(gameScene, achievement)
    }
}
