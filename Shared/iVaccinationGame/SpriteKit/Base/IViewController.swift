//
//  IViewController.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 27.09.21.
//

import Foundation
import SpriteKit

protocol IViewController{
    
    var gameCenterHelper:GameCenterHelper!{ get set }
    
    func loadMenuScene()
    func loadDifficultyScene()
    func loadCreditsScene()
    func loadMapScene()
    func loadMapScene(difficulty:Difficulty, level:Level)
    func loadGameScene(difficulty:Difficulty, level:Level)
}
