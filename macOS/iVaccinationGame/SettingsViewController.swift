//
//  SettingsViewController.swift
//  SettingsViewController
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import Cocoa

class SettingsViewController: NSViewController {
    
    
    var gameScene:GameScene?
    
    @IBOutlet var volume:NSSlider?
    @IBOutlet var sharedUserDefaultsController:NSUserDefaultsController?
    
    @IBAction func closeAndDiscardChanges(_ sender:Any){
        self.sharedUserDefaultsController?.revert(nil)
        if(gameScene != nil){
            self.dismiss(sender)
        }
        gameScene?.view?.isPaused = false
    }
    
    @IBAction func closeAndResume(_ sender:Any){
        if(gameScene != nil){
//            gameScene?.view?.isPaused = false
            gameScene?.songPlayer?.volume = self.volume!.floatValue
        }
        self.dismiss(sender)
        let answer = AlertBox.dialogOKCancel(question: "Ok?", text: "Settings changed! Do you want to restart the game?")
        if(answer){
            print("RELOADING GAME")
        }
        if(gameScene != nil){
            gameScene?.view?.isPaused = false
//            gameScene?.songPlayer?.volume = self.volume!.floatValue
        }
    }
}

