//
//  KeyboardHandler.swift
//  KeyboardHandler
//
//  Created by Kim David Hauser on 19.09.21.
//

import Foundation
import Cocoa
import SpriteKit

class KeyboardHandler{
    
    let gameScene:GameScene
    
    init(gameScene:GameScene){
        self.gameScene = gameScene
    }
    
    func keyDown(with event: NSEvent) {
        print("KeyPressed: %d", event.keyCode)
        if(self.gameScene.waitForAnyKey){
            self.gameScene.restartAfterGameOverNG(resetTime: true, loadNewLevel: true)
            return
        }
        
        switch event.keyCode {
        case 5: // G
            self.gameScene.showGameOver()
            break
        case 15: // R
            self.gameScene.restartAfterHit()
            break
        case 18: // 1
            self.gameScene.lblVacc?.text = "Vaccine: Moderna"
            self.gameScene.lblVacc?.fontColor = self.gameScene.lblTime?.fontColor
            break
        case 19: // 2
            self.gameScene.lblVacc?.text = "Vaccine: Pfizer"
            self.gameScene.lblVacc?.fontColor = .orange
            break
        case 20: // 3
            self.gameScene.lblVacc?.text = "Vaccine: Johnson & Johnson"
            self.gameScene.lblVacc?.fontColor = .green
            break
        case 21: // 4
            self.gameScene.lblVacc?.text = "Vaccine: Sputnik"
            self.gameScene.lblVacc?.fontColor = .yellow
            break
        case 35: // P
            self.gameScene.isPaused = !self.gameScene.isPaused
            self.gameScene.lblGameOver?.text = (self.gameScene.isPaused ? "Pause" : "Game Over")
            self.gameScene.lblGameOver?.alpha = (self.gameScene.isPaused ? 1.0 : 0.0)
            self.gameScene.lblGameOver?.isHidden = !self.gameScene.isPaused
            break
        case 49: // ??
//            self.lblVacc?.text = "Vaccine: Sputnik"
//            self.lblVacc?.fontColor = .yellow
            break
        case 53: // ESC => Pause and Show menu
            self.gameScene.pauseStartTime = self.gameScene.curTime
            self.gameScene.view?.isPaused = true
            let vcSettings:SettingsViewController = SettingsViewController()
            vcSettings.gameScene = self.gameScene
            if let viewCtrl = self.gameScene.view?.window?.contentViewController{
                (viewCtrl as! ViewController).presentAsSheet(vcSettings)
            }
            break
//        case 0x31:
//            if let label = self.label {
//                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
}
