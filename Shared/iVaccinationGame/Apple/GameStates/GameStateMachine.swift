//
//  GameStateMachine.swift
//  iVaccination
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import SpriteKit
import GameplayKit

class GameStateMachine: GKStateMachine {
    
    let gameScene:GameSceneBase
    
    init(gameScene:GameSceneBase){
        self.gameScene = gameScene
        super.init(states: [
            PauseState(gameScene: gameScene),
            GameOverState(gameScene: gameScene),
            SettingsState(gameScene: gameScene),
            MenuState(gameScene: gameScene),
            PlayingState(gameScene: gameScene),
            GameCenterState(gameScene: gameScene)
        ])
        self.enter(MenuState.self)
    }
}
