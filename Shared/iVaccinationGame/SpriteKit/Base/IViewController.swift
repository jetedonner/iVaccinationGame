//
//  IViewController.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 27.09.21.
//

import Foundation
import SpriteKit

protocol IViewController{
    func loadMenuScene()
    func loadDifficultyScene()
    func loadCreditsScene()
    func loadMapScene()
    func loadMapScene(difficulty:UserDefaultsDifficulty, level:Level)
    func loadGameScene(difficulty:UserDefaultsDifficulty, level:Level)
}
