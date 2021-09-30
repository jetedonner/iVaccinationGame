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

    var gameCenterHelper:GameCenterHelper!
    var gameSceneObj:GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (UIApplication.shared.delegate as! AppDelegate).vc = self
        
        if(UserDefaultsHelper.useGameCenter){
            self.gameCenterHelper = GameCenterHelper(vc: self)
            self.gameCenterHelper.loadGameCenter()
        }
        self.loadMenuScene()
    }
    
    func loadMapScene(){

        if let scene = GKScene(fileNamed: "MapScene") {
            if let sceneNode = scene.rootNode as! MapScene? {

                sceneNode.scaleMode = .aspectFill

                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)

                    view.ignoresSiblingOrder = true

                    if(UserDefaultsHelper.devMode){
                        view.showsFPS = true
                        view.showsNodeCount = true
                        view.showsPhysics = true
                    }
                }
            }
        }
    }
    
    func loadMenuScene(){
        if let scene = GKScene(fileNamed: "MenuScene") {
            
            if let sceneNode = scene.rootNode as! MenuScene? {
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    if(UserDefaultsHelper.devMode){
                        view.showsFPS = true
                        view.showsNodeCount = true
                        view.showsPhysics = true
                    }
                }
            }
        }
    }
    
    func loadGameScene(difficulty:UserDefaultsDifficulty = .easy, level:Level = .Meadow){
        UserDefaultsHelper.difficulty = difficulty
        UserDefaultsHelper.levelID = level
        if let scene = GKScene(fileNamed: "GameScene") {
            
            if let sceneNode = scene.rootNode as! GameScene? {
                self.gameSceneObj = sceneNode
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    if(UserDefaultsHelper.devMode){
                        view.showsFPS = true
                        view.showsNodeCount = true
                        view.showsPhysics = true
                    }
                }
            }
        }
        self.registerSettingsBundle()
    }
    
    func loadDifficultyScene(level:Level){
        if let scene = GKScene(fileNamed: "DifficultyScene") {
            
            if let sceneNode = scene.rootNode as! DifficultyScene? {
                sceneNode.selLevel = level
                sceneNode.scaleMode = .aspectFill
                
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    if(UserDefaultsHelper.devMode){
                        view.showsFPS = true
                        view.showsNodeCount = true
                        view.showsPhysics = true
                    }
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

//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .portrait
//        } else {
//            return .portrait
//        }
//    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
