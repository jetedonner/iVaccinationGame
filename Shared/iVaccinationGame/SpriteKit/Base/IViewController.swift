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
    func loadDifficultyScene(level:Level)
    func loadMapScene()
    func loadGameScene(difficulty:UserDefaultsDifficulty, level:Level)
}
