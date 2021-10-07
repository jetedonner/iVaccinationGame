//
//  GameSceneBaseExt2.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 02.10.21.
//

import Foundation
import SpriteKit

extension GameSceneBase{

    func restartGameNG(resetTime:Bool = true){
        self.waitForAnyKey = false
        self.imgBlood?.isHidden = true
        self.lblGameOver?.isHidden = true
        self.lblPressAnyKey?.isHidden = true
        self.effectNode.isHidden = true
        self.lblScore?.position = self.scoreLblOrigPos
        self.lblScore?.setScale(1.0)
        self.lblCerts?.position = self.certsLblOrigPos
        self.lblCerts?.setScale(1.0)
        self.player.resetPlayer()
        self.gameRunning = true
        if(resetTime){
            self.startTime = 0
        }
        for i in 0..<self.currentLevel.currentLevelConfig.zombieCountAtOnce{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() +  (i == 0 ? 0.0 : Double(self.currentLevel.currentLevelConfig.zombieRespawnRange.randomElement()!)), execute: {
                self.restartZombieActions()
            })
        }
        self.showMessage(msg: "Level: \(self.currentLevel.levelName)")
    }
    
    func resetHUDAfterBiteOrRestart(){
        self.imgBlood?.isHidden = true
    }
    
    func restartZombieActions(){
        self.currentLevel.addNewZombieGirl()
    }
    
    func bittenByZombie(zombieGirl:ZombieGirl){
        self.imgBlood?.isHidden = false
        self.imgBlood?.alpha = 1.0
        if(self.player.zombieBite(damage: self.currentLevel.zombieDamage)){
            self.imgRedOut?.run(SKAction.fadeIn(withDuration: 1.0), completion: {
                self.imgRedOut?.alpha = 0.0
                self.imgBlood?.isHidden = true
                self.player.health = 0.0
                self.showGameOver()
                self.player.resetPlayer()
                self.prgBar.setProgress(1.0)
            })
        }

        self.prgBar.setProgress(self.player.health / 100.0)

        if(self.player.health <= 75.0){
            self.medkitPickup?.genNewPos()
        }

        SoundManager.shared.playSound(sounds: [.eat1, .eat2])
        
        self.imgBlood?.run(SKAction.sequence([
            SKAction.wait(forDuration: GameVars.BLOOD_SHOW_TIME),
            SKAction.fadeOut(withDuration: GameVars.BLOOD_FADEOUT_TIME)
        ]))
        
        zombieGirl.run(SKAction.group([SKAction.sequence([SKAction.wait(forDuration: 0.25), SKAction.moveBy(x: 0, y: -300, duration: 0.55)])]), completion: {
            if(self.player.health >= 75.0){
                SoundManager.shared.playSound(sound: .pain100)
            }else if(self.player.health >= 50.0){
                SoundManager.shared.playSound(sound: .pain75)
            }else if(self.player.health >= 25.0){
                SoundManager.shared.playSound(sound: .pain50)
            }else {
                SoundManager.shared.playSound(sound: .pain25)
            }

            zombieGirl.run(SKAction.wait(forDuration: 0.75), completion: {
                self.currentLevel.removeZombieGirl(zombieGirl: zombieGirl)
                self.resetHUDAfterBiteOrRestart()
                self.restartZombieActions()
            })
        })
    }
}
