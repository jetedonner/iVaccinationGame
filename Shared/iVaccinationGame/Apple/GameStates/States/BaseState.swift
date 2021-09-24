//
//  BaseState.swift
//  iVaccination
//
//  Created by Kim David Hauser on 24.09.21.
//

import Foundation
import GameplayKit

class BaseState: GKState {
    
    let stateDesc:String
    let gameScene:GameSceneBase
    let gameState:GameState
    
    init(gameScene:GameSceneBase, stateDesc:String, gameState:GameState) {
        self.gameScene = gameScene
        self.stateDesc = stateDesc
        self.gameState = gameState
        super.init()
    }
}
