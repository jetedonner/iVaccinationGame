//
//  ViewController.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 13.09.21.
//

import Cocoa
import SpriteKit
import GameplayKit
import AVKit

class ViewController: NSViewController, IViewController, AVAudioPlayerDelegate {
    
    var gameCenterHelper:GameCenterHelper!
    var gameSceneObj:GameScene!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window?.acceptsMouseMovedEvents = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (NSApplication.shared.delegate as! AppDelegate).vc = self
        
        if(UserDefaultsHelper.useGameCenter){
            self.gameCenterHelper = GameCenterHelper(vc: self)
            self.gameCenterHelper.loadGameCenter()
        }
        if(UserDefaultsHelper.firstStart){
//            UserDefaultsHelper.firstStart = false
            self.loadWelcomeScene()
        }else{
            self.loadMenuScene()
        }
    }

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
    
    @IBAction func loadSettingsDialog(_ sender:Any?){
        let vcSettings:SettingsViewController = SettingsViewController()
        vcSettings.gameScene = nil
        self.presentAsSheet(vcSettings)
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
    
    func loadMapScene(difficulty:Difficulty, level:Level = .Meadow){
        UserDefaultsHelper.difficulty = difficulty
        UserDefaultsHelper.levelID = level
        if let scene = GKScene(fileNamed: "MapScene") {
            if let sceneNode = scene.rootNode as! MapScene? {
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentSceneNG(sceneNode)
                }
            }
        }
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
    
    func loadGameScene(difficulty:Difficulty = .easy, level:Level = .Meadow){
        UserDefaultsHelper.difficulty = difficulty
        UserDefaultsHelper.levelID = level

        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                self.gameSceneObj = sceneNode
                sceneNode.scaleMode = .aspectFill
                if let view = self.view as! SKView? {
                    view.presentSceneNG(sceneNode)
                    view.resetCursorRects()
                }
            }
        }
    }
}

