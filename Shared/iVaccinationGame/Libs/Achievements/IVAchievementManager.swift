//
//  IVAchievementManager.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 15.10.21.
//

import Foundation
//import Cocoa

enum AchievementId:String {
    case achivementPerfectThrowsID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.perfectthrows"
    case achivementStayHealthyID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.stayhealthy"
    case achivementCollectAllCertsID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.collectallcertificates"
//    case achivementCompleteAllLevelsEasyID = "grp.ch.kimhauser.swift.ivaccinationgame.achivements.completealllevels.easy"
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
                achievementScore: 100,
                check: self.checkAchievementAccomplished
            ),
            IVAchievement(
                achievementId: AchievementId.achivementStayHealthyID,
                achievementTitle: "Stay healthy",
                achievementDesc: "Try to stay healthy - to complete this task you must avoid to be bitten by the zombies",
                achievementImage: "StayHealthy",
                achievementScore: 100,
                check: self.checkAchievementAccomplished
            ),
            IVAchievement(
                achievementId: AchievementId.achivementCollectAllCertsID,
                achievementTitle: "Collect all certificates",
                achievementDesc: "Try to collect all certificates before they disapear again after some time",
                achievementImage: "Certificates",
                achievementScore: 100,
                check: self.checkAchievementAccomplished
            ),
            IVAchievement(
                achievementId: AchievementId.achivementCompleteAllLevelsEasyID,
                achievementTitle: "Complete all easy levels",
                achievementDesc: "Your first task should be to try to complete all level in easy mode",
                achievementImage: "Levels",
                achievementScore: 100,
                check: self.checkAchievementAccomplished
            )
        ]
    }
    
    func checkAndShowAchievementsAccomplished(gameScene:GameSceneBase, achievementIds:[AchievementId]) {
        var accomplishedAchievements:[IVAchievement] = []
        for achievementId in achievementIds{
            if let achievement = self.achievements.filter({$0.achievementId == achievementId}).first{
                if(self.checkAchievementAccomplished(achievementId: achievementId)){
                    accomplishedAchievements.append(achievement)
                    self.gameScene.onlineHelper.achievementAccomplished(gameScene: self.gameScene, achievementId: achievementId, player: UserDefaultsHelper.playerName)
                }
            }
        }
        if(accomplishedAchievements.count > 0){
            self.showAchievementsAccomplishedMsgs(achievements: accomplishedAchievements, idx: 0)
        }
    }
    
    func checkAndShowAchievementAccomplished(gameScene:GameSceneBase, achievementId:AchievementId) {
        if(self.checkAchievementAccomplished(achievementId: achievementId)){
            gameScene.onlineHelper.achievementAccomplished(gameScene: gameScene, achievementId: achievementId, player: UserDefaultsHelper.playerName)
        }
    }
    
    func checkAchievementAccomplished(achievementId:AchievementId) -> Bool {
        let achievement:IVAchievement = self.achievements.filter({$0.achievementId == achievementId})[0]
        return self.checkAchievementAccomplished(gameScene: self.gameScene, achievement: achievement)
    }
    
    func checkAchievementAccomplished(gameScene: GameSceneBase, achievement:IVAchievement) -> Bool {
        if(achievement.achievementId == AchievementId.achivementPerfectThrowsID){
            return (gameScene.currentLevel.zombiesSpawned == gameScene.player.zombiesCured) && (gameScene.currentLevel.shots > 0) && gameScene.currentLevel.shots == gameScene.currentLevel.hits
        }else if(achievement.achievementId == AchievementId.achivementStayHealthyID){
            return (!gameScene.gameLost) && gameScene.player.bites == 0
        }else if(achievement.achievementId == AchievementId.achivementCollectAllCertsID){
            return gameScene.player.certsPickedUp == gameScene.certificatePickupManager.generatedPickups
        }else if(achievement.achievementId == AchievementId.achivementCompleteAllLevelsEasyID){
            return UserDefaultsHelper.levelID == .MissionAccomplished && UserDefaultsHelper.difficulty == .easy
        }
        return false
    }
        
    func showAchievementsAccomplishedMsgs(achievements:[IVAchievement], idx:Int = 0){
        if(idx < achievements.count){
            self.showAchievementAccomplishedMsg(achievement: achievements[idx], completion: {
                self.showAchievementsAccomplishedMsgs(achievements: achievements, idx: idx + 1)
            })
        }/*else{
            if(!self.gameScene.gameRunning){
                var tmp = -1
                tmp /= -1
                self.gameScene.waitForAnyKey = true
            }
        }*/
    }
    
    func showAchievementAccomplishedMsg(achievement:IVAchievement, completion:(() -> Void)? = nil){
        self.gameScene.msgBox.showMessage(title: achievement.achievementTitle, msg: achievement.achievementDesc, imgNamed: achievement.achievementImage, timeout: GameVars.MSGBOX_TIME, completion: completion)
    }
}
