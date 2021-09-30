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
    
    var imgBG:SKSpriteNode!
    var imgBack:SKSpriteNode!
    var lblScore:SKLabelNode!
    var lblLevel:SKLabelNode!
    var lblDifficulty:SKLabelNode!
    
    
    var posTouchNodes:SKNode?
    var posMeadow:SKShapeNode?
    var posCitySkyline:SKShapeNode?
    var posCityStreet:SKShapeNode?
    var posWallway:SKShapeNode?
    var posJapanStreet:SKShapeNode?
    var posBackStreet:SKShapeNode?
    var posScarryStreet:SKShapeNode?
    
    var textMeadow:SKTexture = SKTexture(imageNamed: "Map6")
    var textCitySkyline:SKTexture = SKTexture(imageNamed: "Map6")
    
    var textBackArrowSel:SKTexture = SKTexture(imageNamed: "BackArrowSel")
    var textBackArrow:SKTexture = SKTexture(imageNamed: "BackArrow")
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.imgBG = self.childNode(withName: "BG") as? SKSpriteNode
        self.imgBack = self.childNode(withName: "imgBack") as? SKSpriteNode
        self.lblScore = self.childNode(withName: "lblScore") as? SKLabelNode
        self.lblLevel = self.childNode(withName: "lblLevel") as? SKLabelNode
        self.lblDifficulty = self.childNode(withName: "lblDifficulty") as? SKLabelNode
        
        
        self.posTouchNodes = self.childNode(withName: "posTouchNodes")
//        self.posTouchNodes?.alpha = 0.0
        
        self.posMeadow = self.childNode(withName: "posMeadow") as? SKShapeNode
        self.posMeadow?.zPosition = 1000
        self.posMeadow?.lineWidth = 0.0
        self.posCitySkyline = self.childNode(withName: "posCitySkyline") as? SKShapeNode
        self.posCitySkyline?.zPosition = 1000
        self.posCitySkyline?.lineWidth = 0.0
        self.posCityStreet = self.childNode(withName: "posCityStreet") as? SKShapeNode
        self.posCityStreet?.zPosition = 1000
        self.posCityStreet?.lineWidth = 0.0
        self.posWallway = self.childNode(withName: "posWallway") as? SKShapeNode
        self.posWallway?.zPosition = 1000
        self.posWallway?.lineWidth = 0.0
        self.posJapanStreet = self.childNode(withName: "posJapanStreet") as? SKShapeNode
        self.posJapanStreet?.zPosition = 1000
        self.posJapanStreet?.lineWidth = 0.0
        self.posBackStreet = self.childNode(withName: "posBackStreet") as? SKShapeNode
        self.posBackStreet?.zPosition = 1000
        self.posBackStreet?.lineWidth = 0.0
        self.posScarryStreet = self.childNode(withName: "posScarryStreet") as? SKShapeNode
        self.posScarryStreet?.zPosition = 1000
        self.posScarryStreet?.lineWidth = 0.0
        
        if(UserDefaultsHelper.levelID == .Meadow){
            self.imgBG.texture = self.textMeadow
        }else{
            self.imgBG.texture = self.textCitySkyline
        }
        self.imgBG.zPosition = 100
        self.updateScoreFromICloud()
    }
    
    func updateScoreFromICloud(){
        self.lblScore.text = "Score: \(ICloudStorageHelper.highscore)"
        self.lblLevel.text = "Level: \(ICloudStorageHelper.level)"
        self.lblDifficulty.text = "Difficulty: \(ICloudStorageHelper.difficulty)"
        
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
        if(self.selNode == self.imgBack){
            viewController.loadMenuScene()
        }else if([
            self.posMeadow,
            self.posCitySkyline,
            self.posCityStreet,
            self.posWallway,
            self.posJapanStreet,
            self.posBackStreet,
            self.posScarryStreet
        ].contains(self.selNode)){
            viewController.loadDifficultyScene(level: self.getLevelForPosNode(posNode: self.selNode as! SKShapeNode))
        }
        /*else if(self.selNode == self.posMeadow){
            viewController.loadDifficultyScene(level: .Meadow)
        }else if(self.selNode == self.posCitySkyline){
            viewController.loadDifficultyScene(level: .CitySkyline)
        }*/
    }
    
    func getLevelForPosNode(posNode:SKShapeNode)->Level{
        switch posNode {
        case self.posMeadow:
            return .Meadow
        case self.posCitySkyline:
            return .CitySkyline
        case self.posCityStreet:
            return .CityStreet
        case self.posWallway:
            return .Wallway
        case self.posJapanStreet:
            return .CityJapan
        case self.posBackStreet:
            return .CityNight
        case self.posScarryStreet:
            return .ScarryStreet
        default:
            return .Meadow
        }
    }
}
