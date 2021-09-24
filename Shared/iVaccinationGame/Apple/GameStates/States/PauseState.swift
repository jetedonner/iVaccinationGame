//
//  PauseState.swift
//  iVaccination
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import GameplayKit

class PauseState: BaseState {
    
    init(gameScene:GameSceneBase) {
        super.init(gameScene: gameScene, stateDesc: "Paused", gameState: .paused)
    }
    
    override func didEnter(from previousState: GKState?) {
        self.gameScene.setGamePaused(isPaused: true)
    }
}
