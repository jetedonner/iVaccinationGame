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
    func loadHighscoreScene() {
//        let highScoreController:HighscoreViewController = HighscoreViewController()
//        self.present(highScoreController, animated: true, completion: {})
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HighscoreViewController")
        self.present(vc, animated: true)
    }
    
    
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
        
//        addFloaterMenu(with: [("Facebook", UIImage(named: "AppIcon")),("Instagram", UIImage(named: "AppIcon"))], mainItem: ("", UIImage(named: "AppIcon")), dropShadow: true)
    }
    
//    // Delegate method to capture name and index on the respective button tapped.
//    func userDidTapOnItem(at index: Int, with model: String) {
//                   print(model)
//                   print(index)
//    }
    
    
    
    
//    func didMoveToView(view:SKView!) {
//
//        _scrollingNode.enableScrollingOnView(view)
//        _scrollingNode.scrollToTop()
//
//    }
//
//    func willMoveFromView(view:SKView!) {
//        _scrollingNode.disableScrollingOnView(view)
//    }
    
    func loadWelcomeScene(){
        if let scene = GKScene(fileNamed: "WelcomeScene") {
            if let sceneNode = scene.rootNode as! WelcomeScene? {
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentSceneNG(sceneNode)
                }
            }
        }
    }
    
//    func loadHighscoreScene(){
//        if let scene = GKScene(fileNamed: "HighscoreScene") {
//            if let sceneNode = scene.rootNode as! HighscoreScene? {
//                sceneNode.scaleMode = .aspectFill
//                if let view = self.view as! SKView? {
//                    view.presentSceneNG(sceneNode)
//                    sceneNode.enableScrollingList(view: view)
//                }
//            }
//        }
//    }
    
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
        self.loadMapScene(moveDoctor: false)
    }
    
    func loadMapScene(moveDoctor:Bool){
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
