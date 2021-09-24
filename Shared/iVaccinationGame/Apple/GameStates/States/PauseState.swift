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
//        self.gameScene.setGamePaused(isPaused: !self.gameScene.gamePaused)
        self.gameScene.lblGameOver?.text = (self.gameScene.isPaused ? "Pause" : "Game Over")
        self.gameScene.lblGameOver?.alpha = (self.gameScene.isPaused ? 1.0 : 0.0)
        self.gameScene.lblGameOver?.isHidden = !self.gameScene.isPaused
    }
}
