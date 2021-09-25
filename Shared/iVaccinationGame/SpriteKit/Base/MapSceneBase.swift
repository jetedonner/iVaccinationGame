//
//  MenuScene.swift
//  MenuScene
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit
import GameKit

class MapSceneBase: BaseSKScene {
    
//    var lblContinue:SKLabelNode?
//    var lblMedium:SKLabelNode?
//    var lblHard:SKLabelNode?
//    var lblNightmare:SKLabelNode?
//    var sceneNode:SKScene!
    var imgBG:SKSpriteNode!
    var imgBack:SKSpriteNode!
    var lblScore:SKLabelNode!
    var lblLevel:SKLabelNode!
    
//    var lblColor:NSColor?
    var posMeadow:SKShapeNode?
    var posCitySkyline:SKShapeNode?
    
    var textMeadow:SKTexture = SKTexture(imageNamed: "Map3")
    var textCitySkyline:SKTexture = SKTexture(imageNamed: "Map3_done")
    
    var selNode:SKNode?
    
    var textBackArrowSel:SKTexture = SKTexture(imageNamed: "BackArrowSel")
    var textBackArrow:SKTexture = SKTexture(imageNamed: "BackArrow")
//    var viewCtrl:ViewController?
    
    override var isUserInteractionEnabled: Bool {
        get {
            return true
        }
        set {
//            super.isUserInteractionEnabled = newValue
        }
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.imgBG = self.childNode(withName: "BG") as? SKSpriteNode
        self.imgBack = self.childNode(withName: "imgBack") as? SKSpriteNode
        self.lblScore = self.childNode(withName: "lblScore") as? SKLabelNode
        self.lblLevel = self.childNode(withName: "lblLevel") as? SKLabelNode
        
        self.posMeadow = self.childNode(withName: "posMeadow") as? SKShapeNode
        self.posCitySkyline = self.childNode(withName: "posCitySkyline") as? SKShapeNode
        
        
        if(UserDefaultsHelper.levelID == .Meadow){
            self.imgBG.texture = self.textMeadow
        }else{
            self.imgBG.texture = self.textCitySkyline
        }
        self.isUserInteractionEnabled = true
        self.updateScoreFromICloud()
    }
    
    func updateScoreFromICloud(){
        self.lblScore.text = "Score: \(ICloudStorageHelper.highscore)"
        self.lblLevel.text = "Level: \(ICloudStorageHelper.level)"
    }
}
