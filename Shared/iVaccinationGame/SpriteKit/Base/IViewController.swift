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
    
    func loadWelcomeScene()
    func loadMenuScene()
    func loadDifficultyScene()
    func loadCreditsScene()
    func loadHighscoreScene()
    func loadMapScene(moveDoctor:Bool)
    func loadMapScene(difficulty:Difficulty, level:Level)
    func loadGameScene(difficulty:Difficulty, level:Level)
}
