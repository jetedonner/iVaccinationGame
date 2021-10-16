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
    
    @IBOutlet var cmbTime:NSPopUpButton?
    @IBOutlet var cmbDifficulty:NSPopUpButton?
    @IBOutlet var cmbLevel:NSPopUpButton?
    
    @IBOutlet var cmdAbortGame:NSButton?
    @IBOutlet var cmdTestAch:NSButton?
    @IBOutlet var cmdResetAch:NSButton?
    @IBOutlet var cmdResetICloud:NSButton?
    @IBOutlet var cmdResetUserDef:NSButton?
    @IBOutlet var cmdResetALL:NSButton?
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
            self.swtDevMode?.state = .off
            self.showHideAchButtons(hide: true)
        }
        if(self.gameScene == nil || (self.gameScene != nil && (!self.gameScene!.gameRunning))){
            self.cmdAbortGame?.isHidden = true
        }
    }
    
    @IBAction func abortGame(_ sender:Any){
        self.gameScene?.endGame()
        self.gameScene?.getViewController().loadMenuScene()
        self.dismiss(sender)
    }
    
    @IBAction func switchDbgBorders(_ sender:Any){
//        self.showHideAchButtons(hide: (self.swtDevMode?.state == .off))
    }
    
    @IBAction func switchDevMode(_ sender:Any){
        self.showHideAchButtons(hide: (self.swtDevMode?.state == .off))
    }
    
    func showHideAchButtons(hide:Bool){
        self.cmdTestAch?.isHidden = hide
        self.cmdResetAch?.isHidden = hide
        self.cmdResetUserDef?.isHidden = hide
        self.cmdResetICloud?.isHidden = hide
        self.cmdResetALL?.isHidden = hide
    }
    
    @IBAction func resetALL(_ sender:Any){
        ICloudStorageHelper.resetAllICloudValues()
        UserDefaultsHelper.resetUserDefValues()
        GCAchievements.shared.resetAllCompletedAchivements()
        _ = AlertBox.dialogOK(message: "All values reset", text: "All values and achievements reset ok!")
    }
    
    @IBAction func resetICloud(_ sender:Any){
        ICloudStorageHelper.resetAllICloudValues()
        _ = AlertBox.dialogOK(message: "iCloud values reset", text: "All iCloud values reset ok!")
    }
    
    @IBAction func resetUserDef(_ sender:Any){
        UserDefaultsHelper.resetUserDefValues()
        _ = AlertBox.dialogOK(message: "UserDefault game values reset", text: "All GAME UserDefault values reset ok!")
    }
    
    @IBAction func resetUserDefComplete(_ sender:Any){
        UserDefaultsHelper.resetAllUserDefaults()
        UserDefaultsHelper.loadStandardValues()
        _ = AlertBox.dialogOK(message: "UserDefault values COMPLETELY reset", text: "REALLY ALL UserDefault values reset ok!")
    }
    
    @IBAction func resetGCAchivements(_ sender:Any){
        GCAchievements.shared.resetAllCompletedAchivements()
        _ = AlertBox.dialogOK(message: "All achievements reset", text: "All achievements reset ok!")
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
            }else{
                SoundManager.shared.stopBGSound()
            }
            SoundManager.shared.songPlayer?.volume = self.volume!.floatValue
            SoundManager.shared.masterVolume = CGFloat(self.volume!.floatValue)
            UserDefaultsHelper.volume = self.volume!.floatValue
        }
        self.dismiss(sender)
        if(self.gameScene != nil){
            self.gameScene?.setGamePaused(isPaused: false)
//            let answer = AlertBox.dialogOKCancel(question: "Ok?", text: "Settings changed! Do you want to abort the current level?")
//            if(answer){
//                self.gameScene!.runLevelConfig(levelID: UserDefaultsHelper.levelID, difficulty: UserDefaultsHelper.difficulty)
//            }else{
//                self.gameScene?.setGamePaused(isPaused: false)
//            }
        }
    }
}

