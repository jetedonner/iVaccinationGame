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
        self.player.resetPlayer()
        self.gameRunning = true
        if(resetTime){
            self.startTime = 0
        }
//        self.zombieGirl.removeAllActions()
//        self.zombieGirl.isPaused = false
        self.restartZombieActions()
        
        self.showMessage(msg: "Level: \(self.currentLevel.levelName)")
//        self.restartAfterHit(resetTime: resetTime)
    }
    
    func resetHUDAfterBiteOrRestart(){
        self.imgBlood?.isHidden = true
    }
    
    func restartZombieActions(){
        self.currentLevel.addNewZombieGirl()
//        self.currentLevel.zombieGirls
//        self.zombieGirl.removeAllActions()
//        self.explosionEmitterNode?.removeFromParent()
//        self.currentLevel.zombieCurrentPath = self.currentLevel.zombiePaths[.easy]!.getRandom()
//        if(self.currentLevel.zombieCurrentPath.hideOnStart){
//            self.zombieGirl.xScale = 0.0
//        }else{
//            self.zombieGirl.xScale = self.currentLevel.zombieCurrentPath.initScale
//        }
//        self.zombieGirl.yScale = self.currentLevel.zombieCurrentPath.initScale
//        self.zombieGirl.position = self.currentLevel.zombieCurrentPath.initPos
//        self.zombieGirl.texture =  SKTexture(imageNamed: "ZombieGirl2")
//        self.zombieGirl.speed = UserDefaultsHelper.speedMultiplierForDifficulty
//        self.zombieGirl.run(self.currentLevel.zombieCurrentPath.path, completion: {
//            self.imgBlood?.isHidden = false
//            self.imgBlood?.alpha = 1.0
//            if(self.player.zombieBite(damage: self.currentLevel.zombieDamage)){
//                self.imgRedOut?.run(SKAction.fadeIn(withDuration: 1.0), completion: {
//                    self.imgRedOut?.alpha = 0.0
//                    self.imgBlood?.isHidden = true
//                    self.showGameOver()
//                    self.player.resetPlayer()
//                    self.prgBar.setProgress(1.0)
//                })
//            }
//            
//            self.prgBar.setProgress(self.player.health / 100.0)
//            
//            if(self.player.health <= 75.0){
//                self.medkitPickup?.genNewPos()
//            }
//            
//            SoundManager.shared.playSound(sounds: [.eat1, .eat2])
//            self.zombieGirl.run(SKAction.group([SKAction.sequence([SKAction.wait(forDuration: 0.25), SKAction.moveBy(x: 0, y: -300, duration: 0.55)])]), completion: {
//                if(self.player.health >= 75.0){
//                    SoundManager.shared.playSound(sound: .pain100)
//                }else if(self.player.health >= 50.0){
//                    SoundManager.shared.playSound(sound: .pain75)
//                }else if(self.player.health >= 25.0){
//                    SoundManager.shared.playSound(sound: .pain50)
//                }else {
//                    SoundManager.shared.playSound(sound: .pain25)
//                }
//                
//                self.zombieGirl.run(SKAction.wait(forDuration: 0.75), completion: {
//                    self.restartZombieAction()
//                })
//            })
//        })
//        self.zombieGirl.zPosition = 101
    }
    
    func bittenByZombie(zombieGirl:ZombieGirl){
        self.imgBlood?.isHidden = false
        self.imgBlood?.alpha = 1.0
        if(self.player.zombieBite(damage: self.currentLevel.zombieDamage)){
            self.imgRedOut?.run(SKAction.fadeIn(withDuration: 1.0), completion: {
                self.imgRedOut?.alpha = 0.0
                self.imgBlood?.isHidden = true
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
