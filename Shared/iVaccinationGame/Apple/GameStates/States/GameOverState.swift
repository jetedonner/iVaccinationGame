//
//  PauseState.swift
//  iVaccination
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import GameplayKit

class GameOverState: BaseState {
    
    init(gameScene:GameSceneBase) {
        super.init(gameScene: gameScene, stateDesc: "Gameover", gameState: .gameOver)
    }
}
