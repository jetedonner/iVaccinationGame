//
//  SettingsViewController.swift
//  SettingsViewController
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import Cocoa

class SettingsViewController: NSViewController {
    
    var gameScene:GameSceneBase?
    
    @IBOutlet var volume:NSSlider?
    @IBOutlet var playBGMusic:NSSwitch?
    @IBOutlet var playSounds:NSSwitch?
    @IBOutlet var sharedUserDefaultsController:NSUserDefaultsController?
    
    @IBAction func resetGCAchivements(_ sender:Any){
        GCAchievements.shared.resetAllCompletedAchivements()
    }
    
    @IBAction func testGCAchivements(_ sender:Any){
        GCAchievements.shared.add2perfectThrows()
        GCAchievements.shared.add2stayHealthy()
        GCAchievements.shared.add2completeAllLevels()
    }
    
    @IBAction func closeAndDiscardChanges(_ sender:Any){
        self.sharedUserDefaultsController?.revert(nil)
        if(gameScene != nil){
            self.dismiss(sender)
            self.gameScene?.setGamePaused(isPaused: false)
        }
    }
    
    @IBAction func closeAndResume(_ sender:Any){
        if(gameScene != nil){
            if(self.playBGMusic!.state == .on){
                gameScene?.songPlayer?.play()
            }else{
                gameScene?.songPlayer?.stop()
            }
            gameScene?.songPlayer?.volume = self.volume!.floatValue
            SoundManager.shared.masterVolume = CGFloat(self.volume!.floatValue)
            UserDefaultsHelper.volume = self.volume!.floatValue
        }
        self.dismiss(sender)
        let answer = AlertBox.dialogOKCancel(question: "Ok?", text: "Settings changed! Do you want to abort the current level?")
        if(answer){
//            print("RELOADING GAME")
            self.gameScene!.runLevel(levelID: UserDefaultsHelper.levelID)
//            self.gameScene!.loadLevel(levelID: UserDefaultsHelper.levelID)
//            self.gameScene!.restartAfterGameOverNG(resetTime: true)
//            self.gameScene!.showMessage(msg: "Level: \(self.currentLevel.levelName)")
//            self.gameScene!.restartLevel()
        }
        if(self.gameScene != nil){
            self.gameScene?.setGamePaused(isPaused: false)
        }
    }
}

