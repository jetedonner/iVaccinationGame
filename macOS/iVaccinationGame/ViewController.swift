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

class ViewController: NSViewController {
    
    var gameCenterHelper:GameCenterHelper!

    @IBOutlet var skView: SKView!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.skView.window?.acceptsMouseMovedEvents = true
//        self.skView.allowedTouchTypes = .direct
//        self.skView.window?.initialFirstResponder = self.skView.scene
    }
    
//    override func mouseMoved(with event: NSEvent) {
//        super.mouseMoved(with: event)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameCenterHelper = GameCenterHelper(vc: self)
        self.gameCenterHelper.loadGameCenter()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "MenuScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MenuScene? {
//                (scene as! MenuScene)!.viewCtrl = self
                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
                
//                sceneNode.mouse
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.skView {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    func loadGameScene(){
        if let scene = GKScene(fileNamed: "GameScene") {

            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {

                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs

                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill

                // Present the scene
                if let view = self.skView {
                    view.presentScene(sceneNode)
                    view.resetCursorRects()

                    view.ignoresSiblingOrder = true

                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
}

