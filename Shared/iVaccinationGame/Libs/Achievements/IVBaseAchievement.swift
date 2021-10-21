//
//  IVBaseAchievement.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 18.10.21.
//

import Foundation
import SpriteKit

class IVBaseAchievement{
    
    let achievementId:AchievementId
    let achievementTitle:String
    let achievementDesc:String
    let achievementPoints:Int
    
    init(achievementId:AchievementId, achievementTitle:String, achievementDesc:String, achievementPoints:Int){
        self.achievementId = achievementId
        self.achievementTitle = achievementTitle
        self.achievementDesc = achievementDesc
        self.achievementPoints = achievementPoints
    }
    
}
