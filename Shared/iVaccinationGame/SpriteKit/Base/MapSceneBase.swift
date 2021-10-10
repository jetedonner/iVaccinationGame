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
    var lblCertificates:SKLabelNode!
    var lblVaccinations:SKLabelNode!
    
    
    var imgMeadow:SKLocationNode!
    var imgCitySkyline:SKLocationNode!
    var imgCityStreet:SKLocationNode!
    var imgWallway:SKLocationNode!
    var imgJapanStreet:SKLocationNode!
    var imgBackstreet:SKLocationNode!
    var imgScarryStreet:SKLocationNode!
    
    
    var lblLevel:SKLabelNode!
    var lblDifficulty:SKLabelNode!
    var lblTask:SKLabelNode!
    
    var contTooltip:SKShapeNode?
    var lblTooltip:SKLabelNode!
    
    var currentContainer:SKShapeNode!
    
    var posTouchNodes:SKNode?
    var posMeadow:SKShapeNode?
    var posCitySkyline:SKShapeNode?
    var posCityStreet:SKShapeNode?
    var posWallway:SKShapeNode?
    var posJapanStreet:SKShapeNode?
    var posCityNight:SKShapeNode?
    var posScarryStreet:SKShapeNode?
    
    var textNG:SKTexture = SKTexture(imageNamed: "MapNG")
    
    var textureMeadowBW:SKTexture = SKTexture(imageNamed: "Meadow_BW")
    var textureMeadowColor:SKTexture = SKTexture(imageNamed: "Meadow_Color")
    var textureCitySkylineBW:SKTexture = SKTexture(imageNamed: "CitySkyline_BW")
    var textureCitySkylineColor:SKTexture = SKTexture(imageNamed: "CitySkyline_Color")
    var textureBackstreetBW:SKTexture = SKTexture(imageNamed: "Backstreet_BW")
    var textureBackstreetColor:SKTexture = SKTexture(imageNamed: "Backstreet_Color")
    var textureCityStreetBW:SKTexture = SKTexture(imageNamed: "CityStreet_BW")
    var textureCityStreetColor:SKTexture = SKTexture(imageNamed: "CityStreet_Color")
    var textureWallwayBW:SKTexture = SKTexture(imageNamed: "Wallway_BW")
    var textureWallwayColor:SKTexture = SKTexture(imageNamed: "Wallway_Color")
    var textureJapanStreetBW:SKTexture = SKTexture(imageNamed: "JapanStreet_BW")
    var textureJapanStreetColor:SKTexture = SKTexture(imageNamed: "JapanStreet_Color")
    var textureScarryStreetBW:SKTexture = SKTexture(imageNamed: "ScarryStreet_BW")
    var textureScarryStreetColor:SKTexture = SKTexture(imageNamed: "ScarryStreet_Color")
    
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
        self.lblCertificates = self.currentContainer.childNode(withName: "lblCertificates") as? SKLabelNode
        self.lblVaccinations = self.currentContainer.childNode(withName: "lblVaccinations") as? SKLabelNode
        
        
        self.lblLevel = self.currentContainer.childNode(withName: "lblLevel") as? SKLabelNode
        self.lblDifficulty = self.currentContainer.childNode(withName: "lblDifficulty") as? SKLabelNode
        
        self.lblTask = self.childNode(withName: "lblTask") as? SKLabelNode
        
        self.posTouchNodes = self.childNode(withName: "posTouchNodes")
        
        self.posMeadow = self.childNode(withName: "posMeadow") as? SKShapeNode
        self.posMeadow?.zPosition = 1000
        self.posMeadow?.lineWidth = 0.0
        self.posMeadow?.isHidden = true
        self.posCitySkyline = self.childNode(withName: "posCitySkyline") as? SKShapeNode
        self.posCitySkyline?.zPosition = 1000
        self.posCitySkyline?.lineWidth = 0.0
        self.posCitySkyline?.isHidden = true
        self.posCityStreet = self.childNode(withName: "posCityStreet") as? SKShapeNode
        self.posCityStreet?.zPosition = 1000
        self.posCityStreet?.lineWidth = 0.0
        self.posCityStreet?.isHidden = true
        self.posWallway = self.childNode(withName: "posWallway") as? SKShapeNode
        self.posWallway?.zPosition = 1000
        self.posWallway?.lineWidth = 0.0
        self.posWallway?.isHidden = true
        self.posJapanStreet = self.childNode(withName: "posJapanStreet") as? SKShapeNode
        self.posJapanStreet?.zPosition = 1000
        self.posJapanStreet?.lineWidth = 0.0
        self.posJapanStreet?.isHidden = true
        self.posCityNight = self.childNode(withName: "posBackstreet") as? SKShapeNode
        self.posCityNight?.zPosition = 1000
        self.posCityNight?.lineWidth = 0.0
        self.posCityNight?.isHidden = true
        self.posScarryStreet = self.childNode(withName: "posScarryStreet") as? SKShapeNode
        self.posScarryStreet?.zPosition = 1000
        self.posScarryStreet?.lineWidth = 0.0
        self.posScarryStreet?.isHidden = true
        
        self.contTooltip = self.childNode(withName: "contTooltip") as? SKShapeNode
        self.contTooltip?.zPosition = 1001
        self.lblTooltip = self.contTooltip!.childNode(withName: "lblTooltip") as? SKLabelNode
        self.contTooltip?.alpha = 0.0
        
        
        self.imgMeadow = SKLocationNode(imgNode: self.childNode(withName: "imgMeadow") as! SKSpriteNode, textUndone: self.textureMeadowBW, textDone: self.textureMeadowColor)
        self.imgCitySkyline = SKLocationNode(imgNode: self.childNode(withName: "imgCitySkyline") as! SKSpriteNode, textUndone: self.textureCitySkylineBW, textDone: self.textureCitySkylineColor)
        self.imgCityStreet = SKLocationNode(imgNode: self.childNode(withName: "imgCityStreet") as! SKSpriteNode, textUndone: self.textureCityStreetBW, textDone: self.textureCityStreetColor)
        self.imgWallway = SKLocationNode(imgNode: self.childNode(withName: "imgWallway") as! SKSpriteNode, textUndone: self.textureWallwayBW, textDone: self.textureWallwayColor)
        self.imgJapanStreet = SKLocationNode(imgNode: self.childNode(withName: "imgJapanStreet") as! SKSpriteNode, textUndone: self.textureJapanStreetBW, textDone: self.textureJapanStreetColor)
        self.imgBackstreet = SKLocationNode(imgNode: self.childNode(withName: "imgBackstreet") as! SKSpriteNode, textUndone: self.textureBackstreetBW, textDone: self.textureBackstreetColor)
        self.imgScarryStreet = SKLocationNode(imgNode: self.childNode(withName: "imgScarryStreet") as! SKSpriteNode, textUndone: self.textureScarryStreetBW, textDone: self.textureScarryStreetColor)
        
        self.loadMapBGTexture()
        
//        self.enableLocations()
        
        self.imgBG.zPosition = 1
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
        self.imgBG.texture = self.textNG
        
        if(UserDefaultsHelper.levelID.rawValue > Level.NewGame.rawValue){
            self.posMeadow?.isHidden = false
        }else{
            self.imgMeadow.currentLocation = true
            self.posMeadow?.isHidden = false
//            self.posMeadow?.isHidden = true
            return
        }
        if(UserDefaultsHelper.levelID.rawValue > Level.Meadow.rawValue){
            self.imgMeadow.levelDone = true
            self.posMeadow?.isUserInteractionEnabled = false
            self.posCitySkyline?.isHidden = false
        }else{
            self.imgMeadow.currentLocation = true
            self.posCitySkyline?.isHidden = true
            return
        }
        if(UserDefaultsHelper.levelID.rawValue > Level.CitySkyline.rawValue){
            self.imgCitySkyline.levelDone = true
            self.posCityStreet?.isHidden = false
        }else{
            self.imgCitySkyline.currentLocation = true
            self.posCityStreet?.isHidden = true
            return
        }
        if(UserDefaultsHelper.levelID.rawValue > Level.CityStreet.rawValue){
            self.imgCityStreet.levelDone = true
            self.posWallway?.isHidden = false
        }else{
            self.imgCityStreet.currentLocation = true
            self.posWallway?.isHidden = true
            return
        }
        if(UserDefaultsHelper.levelID.rawValue > Level.Wallway.rawValue){
            self.imgWallway.levelDone = true
            self.posJapanStreet?.isHidden = false
        }else{
            self.imgWallway.currentLocation = true
            self.posJapanStreet?.isHidden = true
            return
        }
        if(UserDefaultsHelper.levelID.rawValue > Level.CityJapan.rawValue){
            self.imgJapanStreet.levelDone = true
            self.posCityNight?.isHidden = false
        }else{
            self.imgJapanStreet.currentLocation = true
            self.posCityNight?.isHidden = true
            return
        }
        if(UserDefaultsHelper.levelID.rawValue > Level.CityNight.rawValue){
            self.imgBackstreet.levelDone = true
            self.posScarryStreet?.isHidden = false
        }else{
            self.imgBackstreet.currentLocation = true
            self.posScarryStreet?.isHidden = true
            return
        }
        if(UserDefaultsHelper.levelID.rawValue > Level.ScarryStreet.rawValue){
            self.posScarryStreet?.isHidden = false
            self.imgScarryStreet.levelDone = true
            self.imgBG.texture = self.textMissionAccomplished
            self.imgMeadow.imgNode.isHidden = true
            self.imgCitySkyline.imgNode.isHidden = true
            self.imgCityStreet.imgNode.isHidden = true
            self.imgWallway.imgNode.isHidden = true
            self.imgJapanStreet.imgNode.isHidden = true
            self.imgBackstreet.imgNode.isHidden = true
            self.imgScarryStreet.imgNode.isHidden = true
            self.lblTask.isHidden = true
            SoundManager.shared.playSound(sound: .applause)
            return
        }else{
            self.imgScarryStreet.currentLocation = true
            return
        }
    }
    
    func enableLocations(){
        let currentLevel:Level = UserDefaultsHelper.levelID
        var start2Disable:Bool = false
        for level in Level.allCases {
            if let posNode = self.getPosNode4Level(level: level){
                posNode.isHidden = start2Disable
            }
            if(level == currentLevel){
                start2Disable = true
            }
        }
    }
    
    func updateScoreFromICloud(){
        self.lblScore.text = "Score: \(ICloudStorageHelper.highscore)"
        self.lblCertificates.text = "Certificates: \(ICloudStorageHelper.certificates)"
        self.lblVaccinations.text = "Vaccinations: \(ICloudStorageHelper.vaccinations)"
        
        
        self.lblLevel.text = "Level: \(ICloudStorageHelper.level)"
        self.lblDifficulty.text = "Difficulty: \(ICloudStorageHelper.difficulty)"
        
        if(ICloudStorageHelper.difficulty == Difficulty.nightmare.rawValue){
            self.lblDifficulty.fontColor = SKColor.red
        }else{
            self.lblDifficulty.fontColor = SKColor.black
        }
        
    }
    
    func getPosNode4Level(level:Level)->SKShapeNode?{
        switch level {
        case .NewGame:
            return self.posMeadow!
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
            return self.posCityNight!
        case .Wallway:
            return self.posWallway!
        case .MissionAccomplished:
            return nil
        }
    }
    
    override func touchOrClick(pos: CGPoint, viewController:IViewController) {
//        if(self.selNode == self.posMeadow){
//            self.imgMeadow.imgNode.texture = self.textureMeadowColor
//            return
//        }
        
        if(self.selNode == self.imgBack){
            viewController.loadMenuScene()
        }else if([
            self.posMeadow,
            self.posCitySkyline,
            self.posCityStreet,
            self.posWallway,
            self.posJapanStreet,
            self.posCityNight,
            self.posScarryStreet
        ].contains(self.selNode)/* && UserDefaultsHelper.levelID != .MissionAccomplished*/){
            let daLevel:Level = self.getLevelForPosNode(posNode: self.selNode as! SKShapeNode)
            if(daLevel.rawValue >= Level.NewGame.rawValue){//} UserDefaultsHelper.levelID.rawValue){
                viewController.loadGameScene(difficulty: UserDefaultsHelper.difficulty, level: daLevel)
            }
        }else if(UserDefaultsHelper.levelID.rawValue > Level.ScarryStreet.rawValue){
            ICloudStorageHelper.resetAllICloudValues()
            UserDefaultsHelper.resetUserDefValues(resetFirstStart: false)
            viewController.loadDifficultyScene()
            return
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
        case self.posCityNight:
            return .CityNight
        case self.posScarryStreet:
            return .ScarryStreet
        default:
            return .Meadow
        }
    }
}
