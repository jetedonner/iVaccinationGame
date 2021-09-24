//
//  PauseState.swift
//  iVaccination
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import GameplayKit

class SettingsState: BaseState {
    
    init(gameScene:GameSceneBase) {
        super.init(gameScene: gameScene, stateDesc: "Settings", gameState: .settings)
    }
    
    override func didEnter(from previousState: GKState?) {
        self.gameScene.setGamePaused(isPaused: true)
        
        #if os(macOS)
        let vcSettings:SettingsViewController = SettingsViewController()
        vcSettings.gameScene = self.gameScene
        if let viewCtrl = self.gameScene.view?.window?.contentViewController{
            (viewCtrl as! ViewController).presentAsSheet(vcSettings)
        }
        #endif
    }
}
