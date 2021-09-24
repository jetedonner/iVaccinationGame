//
//  PauseState.swift
//  iVaccination
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import GameplayKit

class PlayingState: BaseState {
    
    init(gameScene:GameSceneBase) {
        super.init(gameScene: gameScene, stateDesc: "Playing", gameState: .gameRunning)
    }
    
    override func didEnter(from previousState: GKState?) {
        if(previousState is PauseState){
            self.gameScene.setGamePaused(isPaused: false)
        }else if(previousState is MenuState){
            
        }
    }
}
