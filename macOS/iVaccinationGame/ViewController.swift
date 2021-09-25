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

class ViewController: NSViewController, AVAudioPlayerDelegate {
    
    var gameCenterHelper:GameCenterHelper!
    var gameSceneObj:GameScene!
    
    @IBOutlet var skView: SKView!
    
//    var player: AVAudioPlayer!
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.skView.window?.acceptsMouseMovedEvents = true
    }
    
//    func playSound(fileName: String, atVolume: CGFloat, waitForCompletion: Bool){
//
//        let filename:NSString = NSString(string: fileName)
//        let nameOnly = filename.deletingPathExtension //completeURL.deletingPathExtension().s fileName.stringByDeletingPathExtension
//        let fileExt = filename.pathExtension // fileName.pathExtension
//
//        let soundPath:URL = Bundle.main.url(forResource: nameOnly, withExtension: fileExt)!
//
////        var error:NSError?
//        do{
//            self.player = try AVAudioPlayer(contentsOf: soundPath, fileTypeHint: AVFileType.mp3.rawValue)//, error: &error)
//
//            player.volume = 10.0// Float(atVolume)
//            player.prepareToPlay()
////            player.delegate = (NSApp.delegate as! AppDelegate).vc
//            player.play()
//
////                let playAction: SKAction = SKAction.run { () -> Void in
////                player.play()
////            }
//
////            if(waitForCompletion){
////                let waitAction = SKAction.wait(forDuration: player.duration)
////                let groupAction: SKAction = SKAction.group([playAction, waitAction])
////                return groupAction
////            }
//
////            return playAction
//        }catch{
//            print("Error while playing music: \(error.localizedDescription)")
////            return SKAction.wait(forDuration: 0.0)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (NSApplication.shared.delegate as! AppDelegate).vc = self
        
        if(UserDefaultsHelper.useGameCenter){
            self.gameCenterHelper = GameCenterHelper(vc: self)
            self.gameCenterHelper.loadGameCenter()
        }
        self.loadMenu()
    }
    
        func loadMenu(){
            
            if let scene = GKScene(fileNamed: "MenuScene") {
                
                if let sceneNode = scene.rootNode as! MenuScene? {

                    sceneNode.scaleMode = .aspectFill
                    
                    if let view = self.skView {
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
    
    func loadDifficultyMenu(level:Level){
        if let scene = GKScene(fileNamed: "DifficultyScene") {
            
            if let sceneNode = scene.rootNode as! DifficultyScene? {
                sceneNode.selLevel = level
                sceneNode.scaleMode = .aspectFill
                
                if let view = self.skView {
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
    
    func loadMap(){
        
        if let scene = GKScene(fileNamed: "MapScene") {
            if let sceneNode = scene.rootNode as! MapScene? {
                
                sceneNode.scaleMode = .aspectFill
                
                if let view = self.skView {
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
//        GameScene(
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                
                self.gameSceneObj = sceneNode
                
                sceneNode.scaleMode = .aspectFill
                
                if let view = self.skView {
                    view.presentScene(sceneNode)
                    view.resetCursorRects()

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
}

