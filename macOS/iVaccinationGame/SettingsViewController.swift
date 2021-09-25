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
            SoundManagerNG.shared.masterVolume = CGFloat(self.volume!.floatValue)
        }
        self.dismiss(sender)
        let answer = AlertBox.dialogOKCancel(question: "Ok?", text: "Settings changed! Do you want to restart the game?")
        if(answer){
            print("RELOADING GAME")
            self.gameScene!.restartLevel()
        }
        if(self.gameScene != nil){
            self.gameScene?.setGamePaused(isPaused: false)
        }
    }
}

