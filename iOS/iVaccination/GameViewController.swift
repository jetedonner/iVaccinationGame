//
//  GameViewController.swift
//  iVaccination
//
//  Created by Kim David Hauser on 16.09.21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var gameCenterHelper:GameCenterHelper!
    var gameSceneObj:GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaultsHelper.useGameCenter){
            self.gameCenterHelper = GameCenterHelper(vc: self)
            self.gameCenterHelper.loadGameCenter()
        }
        self.loadMenuScene()
    }
    
    func loadMap(){

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
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MenuScene? {
//                self.gameSceneObj = sceneNode
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
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
//        if let scene = GKScene(fileNamed: "MenuScene") {
//
//            if let sceneNode = scene.rootNode as! MenuScene? {
//
//                sceneNode.scaleMode = .aspectFill
//
//                if let view = self.skView {
//                    view.presentScene(sceneNode)
//
//                    view.ignoresSiblingOrder = true
//
//                    if(UserDefaultsHelper.devMode){
//                        view.showsFPS = true
//                        view.showsNodeCount = true
//                        view.showsPhysics = true
//                    }
//                }
//            }
//        }
    }
    
    func loadGameScene(){
        //        self.supportedInterfaceOrientations = .landscapeRight
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                self.gameSceneObj = sceneNode
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
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
