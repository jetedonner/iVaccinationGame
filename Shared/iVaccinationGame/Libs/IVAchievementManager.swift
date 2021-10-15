//
//  IVAchievementManager.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 15.10.21.
//

import Foundation
import Cocoa

enum AchievementId:String {
    case achivementPerfectThrowsID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.perfectthrows"
    case achivementStayHealthyID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.stayhealthy"
    case achivementCollectAllCertsID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.collectallcertificates"
    case achivementCompleteAllLevelsID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevels"
    case achivementCompleteAllLevelsPerfectThrowID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.gameperfectthrows"
    case achivementCompleteAllLevelsPerfectHealthID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.gameperfecthealth"
    case achivementCompleteAllLevelsPerfectCertsID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.gameperfectcertificates"
    case achivementCompleteAllLevelsEasyID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevelseasy"
    case achivementCompleteAllLevelsMediumID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevelsmedium"
    case achivementCompleteAllLevelsHardID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevelshard"
    case achivementCompleteAllLevelsNightmareID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevelsnightmare"
}

class IVAchievementManager:IVAchievementDelegate{
    
    let blackAndWhiteSuffix:String = "BW"
    var achievements:[IVAchievement]!
    let gameScene:GameSceneBase
    
    init(gameScene:GameSceneBase){
        self.gameScene = gameScene
        
        self.achievements = [
            IVAchievement(
                achievementId: AchievementId.achivementPerfectThrowsID,
                achievementTitle: "Perfect shots",
                achievementDesc: "Try to hit the zombies with every single syringe you shoot at them",
                achievementImage: "PerfectShot",
                check: self.checkAchievementAccomplished
            ),
            IVAchievement(
                achievementId: AchievementId.achivementStayHealthyID,
                achievementTitle: "Stay healthy",
                achievementDesc: "Try to stay healthy - to complete this task you must avoid to be bitten by the zombies",
                achievementImage: "StayHealthy",
                check: self.checkAchievementAccomplished
            )
        ]
        
//        self.achievements[1].checkAchievementAccomplished(gameScene: <#T##GameScene#>)
    }
    
    func checkAchievementAccomplished(achievementId:AchievementId) -> Bool {
        let achievement:IVAchievement = self.achievements.filter({$0.achievementId == achievementId})[0]
        return self.checkAchievementAccomplished(gameScene: self.gameScene, achievement: achievement)
//        if(achievement.achievementId == AchievementId.achivementPerfectThrowsID){
//            return gameScene.currentLevel.shots == gameScene.currentLevel.hits
//        }
//        return false
    }
    
    func checkAchievementAccomplished(gameScene: GameSceneBase, achievement:IVAchievement) -> Bool {
        if(achievement.achievementId == AchievementId.achivementPerfectThrowsID){
            return gameScene.currentLevel.shots == gameScene.currentLevel.hits
        }
        return false
    }
}
