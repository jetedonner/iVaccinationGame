//
//  GameViewController.swift
//  iVaccination
//
//  Created by Kim David Hauser on 16.09.21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, IViewController {
    
    var gameCenterHelper: GameCenterHelper!
//    var gameCenterHelper:GameCenterHelper!
    var gameSceneObj:GameScene!
    
//    init(){
//        super.init()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).vc = self
        
        if(UserDefaultsHelper.useGameCenter){
            self.gameCenterHelper = GameCenterHelper(vc: self)
            self.gameCenterHelper.loadGameCenter()
        }
        self.loadMenuScene()
    }
    
    func loadCreditsScene(){
        if let scene = GKScene(fileNamed: "CreditsScene") {
            if let sceneNode = scene.rootNode as! CreditsScene? {
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentSceneNG(sceneNode)
                }
            }
        }
    }
    
    func loadMapScene(difficulty:Difficulty, level:Level = .Meadow){
        UserDefaultsHelper.difficulty = difficulty
        UserDefaultsHelper.levelID = level
        self.loadMapScene()
    }
    
    func loadMapScene(){
        if let scene = GKScene(fileNamed: "MapScene") {
            if let sceneNode = scene.rootNode as! MapScene? {
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentSceneNG(sceneNode)
                }
            }
        }
    }
    
    func loadMenuScene(){
        if let scene = GKScene(fileNamed: "MenuScene") {
            if let sceneNode = scene.rootNode as! MenuScene? {
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentSceneNG(sceneNode)
                }
            }
        }
    }
    
    func loadGameScene(difficulty:Difficulty = .easy, level:Level = .Meadow){
        UserDefaultsHelper.difficulty = difficulty
        UserDefaultsHelper.levelID = level
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                self.gameSceneObj = sceneNode
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentSceneNG(sceneNode)
                }
            }
        }
        self.registerSettingsBundle()
    }
    
    func loadDifficultyScene(){
        if let scene = GKScene(fileNamed: "DifficultyScene") {
            if let sceneNode = scene.rootNode as! DifficultyScene? {
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentSceneNG(sceneNode)
                }
            }
        }
    }
    
    func registerSettingsBundle(){
            let appDefaults = [String:AnyObject]()
            UserDefaults.standard.register(defaults: appDefaults)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
