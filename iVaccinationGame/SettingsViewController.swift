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
    
    @IBAction func closeAndResume(_ sender:Any){
        self.dismiss(sender)
        gameScene?.view?.isPaused = false
    }
}

