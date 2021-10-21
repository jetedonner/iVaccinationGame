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
            if let viewCtrl = self.gameScene.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadMapScene(moveDoctor: !self.gameScene.gameLost)
            }
            return
        }
        
        switch event.keyCode {
        case KeyCode.KEY_G.rawValue: // G
            self.gameScene.showGameOver()
            break
//        case KeyCode.KEY_R.rawValue: // R
////            self.gameScene.restartAfterHit()
//            break
        case KeyCode.KEY_1.rawValue: // 1
//            self.gameScene.lblVacc?.text = "Vaccine: Moderna"
//            self.gameScene.lblVacc?.fontColor = self.gameScene.lblTime?.fontColor
            break
        case KeyCode.KEY_2.rawValue: // 2
//            self.gameScene.lblVacc?.text = "Vaccine: Pfizer"
//            self.gameScene.lblVacc?.fontColor = .orange
            break
        case KeyCode.KEY_3.rawValue: // 3
//            self.gameScene.lblVacc?.text = "Vaccine: Johnson & Johnson"
//            self.gameScene.lblVacc?.fontColor = .green
            break
        case KeyCode.KEY_4.rawValue: // 4
//            self.gameScene.lblVacc?.text = "Vaccine: Sputnik"
//            self.gameScene.lblVacc?.fontColor = .yellow
            break
        case KeyCode.KEY_S.rawValue: // S
            self.gameScene.setGamePaused(isPaused: true)
            break
        case KeyCode.KEY_W.rawValue: // S
//            SoundManager.shared.playSound(sound: .shot)
            self.gameScene.msgBox.showMessage(title: "Perfect shot", msg: "GREAT! You didn't miss a single shot and hit every zombie!\nYou earned +100 Points")
            break
        case KeyCode.KEY_P.rawValue: // P
            if(self.gameScene.gameStateMachine.currentState is PlayingState){
                self.gameScene.gameStateMachine.enter(PauseState.self)
            }else if(self.gameScene.gameStateMachine.currentState is PauseState){
                self.gameScene.gameStateMachine.enter(PlayingState.self)
            }
            break
        case KeyCode.KEY_SPACE.rawValue: // SPACE
            self.gameScene.clickedAtPoint(point: self.gameScene.mousePos)
            break
        case KeyCode.KEY_ESC.rawValue: // ESC => Pause and Show menu
            #if os(macOS)// || os(iOS)
            self.gameScene.gameStateMachine.enter(SettingsState.self)
            #endif
            break
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
}
