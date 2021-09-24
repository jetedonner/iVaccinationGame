//
//  GameScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 13.09.21.
//
//import Cocoa
import Foundation
import SpriteKit
import GameplayKit
import AVKit
import AVFoundation

class GameScene: GameSceneBase {
    
    var imgCH:NSImage?
    
    var keyboardHandler:KeyboardHandler!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.keyboardHandler = KeyboardHandler(gameScene: self)
    }
    
    override func keyDown(with event: NSEvent) {
        self.keyboardHandler.keyDown(with: event)
    }
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        self.mousePos = event.location(in: self.bg!)
    }
}
