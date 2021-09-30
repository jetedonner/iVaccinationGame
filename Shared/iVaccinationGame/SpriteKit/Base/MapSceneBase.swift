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
    var lblTask:SKLabelNode!
    
    var lblTooltip:SKLabelNode!
    
    
    
    var currentContainer:SKShapeNode!
    
    var posTouchNodes:SKNode?
    var posMeadow:SKShapeNode?
    var posCitySkyline:SKShapeNode?
    var posCityStreet:SKShapeNode?
    var posWallway:SKShapeNode?
    var posJapanStreet:SKShapeNode?
    var posBackStreet:SKShapeNode?
    var posScarryStreet:SKShapeNode?
    
    var contTooltip:SKShapeNode?
    
    
    var textMeadow:SKTexture = SKTexture(imageNamed: "Map7")
    var textCitySkyline:SKTexture = SKTexture(imageNamed: "Map7a")
    var textCitySkyline2:SKTexture = SKTexture(imageNamed: "Map7b")
    var textCitySkyline3:SKTexture = SKTexture(imageNamed: "Map7c")
    var textCitySkyline4:SKTexture = SKTexture(imageNamed: "Map7d")
    var textCitySkyline5:SKTexture = SKTexture(imageNamed: "Map7e")
    var textCitySkyline6:SKTexture = SKTexture(imageNamed: "Map7f")
    var textCitySkyline7:SKTexture = SKTexture(imageNamed: "Map7g")
    
    var textMissionAccomplished:SKTexture = SKTexture(imageNamed: "MissionAccomplished")
    
    var textBackArrowSel:SKTexture = SKTexture(imageNamed: "BackArrowSel")
    var textBackArrow:SKTexture = SKTexture(imageNamed: "BackArrow")
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.imgBG = self.childNode(withName: "BG") as? SKSpriteNode
        self.imgBack = self.childNode(withName: "imgBack") as? SKSpriteNode
        self.currentContainer = self.childNode(withName: "currentContainer") as? SKShapeNode
        
        
        self.lblScore = self.currentContainer.childNode(withName: "lblScore") as? SKLabelNode
        self.lblLevel = self.currentContainer.childNode(withName: "lblLevel") as? SKLabelNode
        self.lblDifficulty = self.currentContainer.childNode(withName: "lblDifficulty") as? SKLabelNode
        
        self.lblTask = self.childNode(withName: "lblTask") as? SKLabelNode
        
        
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
        
        self.contTooltip = self.childNode(withName: "contTooltip") as? SKShapeNode
        self.contTooltip?.zPosition = 1001
        self.lblTooltip = self.contTooltip!.childNode(withName: "lblTooltip") as? SKLabelNode
        self.contTooltip?.alpha = 0.0
        
        self.loadMapBGTexture()
        self.enableLocations()
        
        self.imgBG.zPosition = 100
        self.updateScoreFromICloud()
    }
    
    var oldSelNode:SKNode?
    
    func showTooltip(msg:String, pos:CGPoint){
        self.lblTooltip.text = msg
        let halfWidth = (self.contTooltip?.frame.width)! / 2
        let newPos:CGPoint = CGPoint(x: pos.x + halfWidth, y: pos.y)
        self.contTooltip?.position = newPos
        self.contTooltip?.alpha = 1.0
    }
    
    func fadeOutTooltip(){
        self.contTooltip?.run(SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.fadeAlpha(to: 0.0, duration: 0.5)]))
    }
    
    func loadMapBGTexture(){
//        ICloudStorageHelper.level
        if(UserDefaultsHelper.levelID == .Meadow){
            self.imgBG.texture = self.textMeadow
        }else if(UserDefaultsHelper.levelID == .CitySkyline){
            self.imgBG.texture = self.textCitySkyline
        }else if(UserDefaultsHelper.levelID == .CityStreet){
            self.imgBG.texture = self.textCitySkyline2
        }else if(UserDefaultsHelper.levelID == .Wallway){
            self.imgBG.texture = self.textCitySkyline3
        }else if(UserDefaultsHelper.levelID == .CityJapan){
            self.imgBG.texture = self.textCitySkyline4
        }else if(UserDefaultsHelper.levelID == .CityNight){
            self.imgBG.texture = self.textCitySkyline5
        }else if(UserDefaultsHelper.levelID == .ScarryStreet){
            self.imgBG.texture = self.textCitySkyline6
        }else if(UserDefaultsHelper.levelID == .MissionAccomplished){
            self.imgBG.texture = self.textMissionAccomplished
            self.currentContainer.isHidden = true
            self.lblTask.isHidden = true
        }else{
            self.imgBG.texture = self.textCitySkyline7
        }
    }
    
    func enableLocations(){
        let currentLevel:Level = UserDefaultsHelper.levelID
        var start2Disable:Bool = false
        for level in Level.allCases {
            print("Enabling Level-Pos: \(level) -> \(start2Disable)")
            self.getPosNode4Level(level: level).isHidden = start2Disable
            if(level == currentLevel){
                start2Disable = true
            }
        }
    }
    
    func updateScoreFromICloud(){
        self.lblScore.text = "Score: \(ICloudStorageHelper.highscore)"
        self.lblLevel.text = "Level: \(ICloudStorageHelper.level)"
        self.lblDifficulty.text = "Difficulty: \(ICloudStorageHelper.difficulty)"
        
    }
    
    func getPosNode4Level(level:Level)->SKShapeNode{
        switch level {
        case .Meadow:
            return self.posMeadow!
        case .CitySkyline:
            return self.posCitySkyline!
        case .CityStreet:
            return self.posCityStreet!
        case .CityJapan:
            return self.posJapanStreet!
        case .ScarryStreet:
            return self.posScarryStreet!
        case .CityNight:
            return self.posBackStreet!
        case .Wallway:
            return self.posWallway!
        case .MissionAccomplished:
            return self.posScarryStreet!
        }
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
            viewController.loadGameScene(difficulty: UserDefaultsHelper.difficulty, level: self.getLevelForPosNode(posNode: self.selNode as! SKShapeNode))
        }
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
