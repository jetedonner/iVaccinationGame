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
    
    @IBOutlet var swtDevMode:NSSwitch?
    @IBOutlet var cmdTestAch:NSButton?
    @IBOutlet var cmdResetAch:NSButton?
    @IBOutlet var lblDevMode:NSTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(VersionHelper.getDevMode()){
            self.swtDevMode?.isHidden = false
            self.lblDevMode?.isHidden = false
            self.showHideAchButtons(hide: (self.swtDevMode?.state == .off))
        }else{
            self.swtDevMode?.isHidden = true
            self.lblDevMode?.isHidden = true
            self.showHideAchButtons(hide: true)
        }
    }
    
    @IBAction func switchDevMode(_ sender:Any){
        self.showHideAchButtons(hide: (self.swtDevMode?.state == .off))
    }
    
    func showHideAchButtons(hide:Bool){
        self.cmdTestAch?.isHidden = hide
        self.cmdResetAch?.isHidden = hide
    }
    
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
            self.gameScene?.setGamePaused(isPaused: false)
        }
        self.dismiss(sender)
    }
    
    @IBAction func closeAndResume(_ sender:Any){
        if(gameScene != nil){
            if(self.playBGMusic!.state == .on){
                SoundManager.shared.playBGSound()
//                gameScene?.songPlayer?.play()
            }else{
                SoundManager.shared.stopBGSound()
//                gameScene?.songPlayer?.stop()
            }
            SoundManager.shared.songPlayer?.volume = self.volume!.floatValue
            SoundManager.shared.masterVolume = CGFloat(self.volume!.floatValue)
            UserDefaultsHelper.volume = self.volume!.floatValue
        }
        self.dismiss(sender)
        if(self.gameScene != nil){
            let answer = AlertBox.dialogOKCancel(question: "Ok?", text: "Settings changed! Do you want to abort the current level?")
            if(answer){
                self.gameScene!.runLevel(levelID: UserDefaultsHelper.levelID)
            }else{
                self.gameScene?.setGamePaused(isPaused: false)
            }
        }
    }
}

