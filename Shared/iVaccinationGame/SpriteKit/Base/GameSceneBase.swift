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
import GameKit

class GameSceneBase: BaseSKScene, SKPhysicsContactDelegate {
    
    var gameStateMachine:GameStateMachine!
    
    var gamePaused:Bool = false
    func setGamePaused(isPaused:Bool = true){
        self.gamePaused = isPaused
        if(self.gamePaused){
            self.view?.isPaused = true
            self.pauseStartTime = self.curTime
            if(UserDefaultsHelper.playSounds && UserDefaultsHelper.playBGMusic){
                SoundManager.shared.stopBGSound(pause: true)
            }
        }else{
            self.view?.isPaused = false
            if(UserDefaultsHelper.playSounds && UserDefaultsHelper.playBGMusic){
                SoundManager.shared.songPlayer?.play()
            }
        }
    }
    
    var selLevel:Level = .Meadow
    
    var lastUpdateTime:TimeInterval = 0.0
    var label : SKLabelNode?
    var spinnyNode : SKShapeNode?
    var syringe1:SKSpriteNode?
    var syringe2:SKSpriteNode?
    
    var medkitPickup:MedKitPickup?

    var certificatePickupManager:CertificatePickupManager!
    var syringePickupManager:SyringePickupManager!
    
    var handInitRot:CGFloat?
    var handInitPos:CGPoint?
    
    var imgBlood:SKSpriteNode?
    var imgRedOut:SKSpriteNode?
    var imgThrowingHand:SKSpriteNode!
    var imgArrowDown:SKSpriteNode?
    
    var imgTESET:SKSpriteNode!
    
    
    var contentNode:SKNode?
    var bg:SKSpriteNode?
    
    var effectNode:SKEffectNode = SKEffectNode()
    var lblGameOver:SKLabelNode?
    var lblPressAnyKey:SKLabelNode?
    var lblScore:SKLabelNode?
    var lblCerts:SKLabelNode?
    var lblTime:SKLabelNode?
    var lblVacc:SKLabelNode?
    var lblSyringesLeft:SKLabelNode?
    var lblMessage:SKLabelNode?
    
    var prgBar:CustomProgressBar = CustomProgressBar()
    var mousePos:CGPoint = CGPoint()
    
    var startTime:TimeInterval = 0
    var pauseStartTime:TimeInterval = 0
    var gameDuration:TimeInterval = GameVars.DEV_ROUND_TIME

    var damage:CGFloat = GameVars.DEV_ZOMBIE_DAMAGE
    
    let explosionEmitterNode = SKEmitterNode(fileNamed:"MagicParticle.sks")
    
    var gameOverFlashTimeStep:TimeInterval = 0.35
    var gameOverFlashScaleTo:TimeInterval = 1.35
    var gameRunning:Bool = false
    var waitForAnyKey:Bool = false
    var curTime:TimeInterval = 0
    
    var levels:[BaseLevel] = []
    var currentLevel:BaseLevel = CitySkylineLevel()
    var scoreLblOrigPos:CGPoint = CGPoint()
    var certsLblOrigPos:CGPoint = CGPoint()
    let earnedPointLblTime:TimeInterval = 1.5
    
    var chIOS:SKSpriteNode!
    var emptyHands:SKTexture = SKTexture(imageNamed: "ThrowingFingersEmpty")
    var fullHands:SKTexture = SKTexture(imageNamed: "ThrowingFingers")
    
    var player:Player = Player()
    var thrownSyringeDarts:[SyringeDart] = []
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.physicsWorld.contactDelegate = self
        
        self.selLevel = UserDefaultsHelper.levelID
        self.levels = [
            CitySkylineLevel(),
            WallwayLevel(),
            MeadowLevel(),
            CityStreetLevel(),
            CityJapanLevel(),
            CityNightLevel(),
            ScarryStreetLevel()
        ]
        
        self.gameStateMachine = GameStateMachine(gameScene: self)
        
        self.gameDuration = UserDefaultsHelper.roundTime
        self.contentNode = self.childNode(withName: "contentNode")! as SKNode
        self.bg = self.contentNode!.childNode(withName: "BG") as? SKSpriteNode
        
        self.imgArrowDown = self.contentNode!.childNode(withName: "imgArrowDown") as? SKSpriteNode
        self.imgArrowDown?.zPosition = 100100
        self.imgArrowDown?.addDbgBorder()
        
        #if os(macOS)
        self.imgArrowDown?.isHidden = true
        #endif
        
        self.imgThrowingHand = self.contentNode!.childNode(withName: "ThrowingHand") as? SKSpriteNode
        self.chIOS = self.contentNode!.childNode(withName: "chIOS") as? SKSpriteNode
        self.chIOS.alpha = 0.0
        
        print("frame: \(self.imgThrowingHand.frame)")
        print("accessibilityFrame: \(self.imgThrowingHand.accessibilityFrame)")
        print("calculateAccumulatedFrame(): \(self.imgThrowingHand.calculateAccumulatedFrame())")
        
        self.lblGameOver = self.contentNode!.childNode(withName: "lblGameOver") as? SKLabelNode
        self.lblGameOver?.isHidden = true
        
        self.lblPressAnyKey = self.contentNode!.childNode(withName: "lblPressAnyKey") as? SKLabelNode
        self.lblPressAnyKey?.isHidden = true
        
        self.lblScore = self.contentNode!.childNode(withName: "lblScore") as? SKLabelNode
        self.lblCerts = self.contentNode!.childNode(withName: "lblCerts") as? SKLabelNode
        
        self.lblTime = self.contentNode!.childNode(withName: "lblTime") as? SKLabelNode
        self.lblVacc = self.contentNode!.childNode(withName: "lblVacc") as? SKLabelNode
        self.lblSyringesLeft = self.contentNode!.childNode(withName: "lblSyringesLeft") as? SKLabelNode
        
        self.lblMessage = self.contentNode!.childNode(withName: "lblMessage") as? SKLabelNode
        self.lblMessage?.alpha = 0.0
        
        self.syringe1 = self.contentNode!.childNode(withName: "Syringe_1") as? SKSpriteNode
        self.syringe2 = self.contentNode!.childNode(withName: "Syringe_2") as? SKSpriteNode

        self.medkitPickup = MedKitPickup()
        self.medkitPickup?.position = CGPoint(x: 200, y: 200)
        self.medkitPickup?.zPosition = 1000
        self.medkitPickup?.alpha = 0.0
        self.scene?.addChild(self.medkitPickup!)
        
        self.imgTESET = self.contentNode!.childNode(withName: "imgTESET") as? SKSpriteNode
        
        self.imgBlood = self.contentNode!.childNode(withName: "imgBlood") as? SKSpriteNode
        self.imgBlood?.isHidden = true
        self.imgRedOut = self.contentNode!.childNode(withName: "redOut") as? SKSpriteNode
        self.imgRedOut?.alpha = 0.0
        
        self.certificatePickupManager = CertificatePickupManager(gameScene: self)
        self.syringePickupManager = SyringePickupManager(gameScene: self)
        
        self.prgBar.setProgress(1.0)
        self.prgBar.position = CGPoint(x: (self.frame.width / 2) - 20 , y: (self.frame.height / 2) - 12 - 70)
        self.prgBar.zPosition = 1000
        self.addChild(self.prgBar)
        
        self.scoreLblOrigPos = self.lblScore!.position
        self.certsLblOrigPos = self.lblCerts!.position
        
        self.runLevelConfig(levelID: self.selLevel, difficulty: UserDefaultsHelper.difficulty)
        
        self.certificatePickupManager.startPickupManager()
        self.syringePickupManager.startPickupManager()
        
        self.lblVacc?.text = "Vaccine: " + self.player.vaccineArsenal.currentVaccine.rawValue
        
        self.handInitRot = self.imgThrowingHand?.zRotation
        self.handInitPos = self.imgThrowingHand?.position
        self.setupHandAnimation()
//        self.checkNodeBehindHand(node1: self.imgThrowingHand!, node2: self.imgTESET!)
//        self.checkNodeBehindGKAccessPoint(node: self.imgTESET)
    }
    
//    func checkNodeBehindHand(node1:SKSpriteNode, node2:SKSpriteNode)->Bool{
//        let isbehind:Bool = node1.frame.contains(node2.frame)// !.frame.contains(self.imgTESET!.frame)
//        print("TESTZE is behind: \(isbehind)")
//        return isbehind
//    }
//
//    func checkNodeBehindGKAccessPoint(node:SKSpriteNode)->Bool{
//        var isBehind:Bool = false
//        let accsPntCoord:CGRect = GKAccessPoint.shared.frameInScreenCoordinates
//        let fictRect:CGRect = CGRect(x: -495, y: -360, width: 128, height: 128)
//        let newRect = accsPntCoord.offsetBy(dx: (self.scene?.frame.width)! / -2, dy: (self.scene?.frame.height)! / -2)
//        isBehind = fictRect.intersects(node.frame)
//        print("TESTZE123 is behind: \(isBehind)")
//        return isBehind
//    }
    
    func getViewController()->IViewController{
        #if os(iOS)
            return (self.view?.window?.rootViewController as! IViewController)
        #else
            return (self.view?.window?.contentViewController as! IViewController)
        #endif
    }
    
    func setSyringesHUD(){
        self.lblSyringesLeft?.text = self.player.vaccineArsenal.vaccinesInArsenal[.Perofixa]!.description + " / 2"
    }
    
    func runLevelConfig(levelID:Level, difficulty:Difficulty){
        self.loadLevelConfig(levelID: levelID, difficulty: difficulty)
        self.restartGameNG()
    }
    
    func loadLevel(levelID:Level){
        for level in self.levels{
            if(level.level == levelID){
                self.currentLevel = level
                self.currentLevel.setupLevel(gameScene: self)
                return
            }
        }
        self.currentLevel = self.levels[0]
        self.currentLevel.setupLevel(gameScene: self)
    }
    
    func loadLevelConfig(levelID:Level, difficulty:Difficulty){
        let level = self.levels.filter({ $0.level == levelID })[0]
        self.currentLevel = level
        self.currentLevel.setupLevelConfig(gameScene: self, difficulty: difficulty)
    }
    
    override func didMove(to view: SKView) {
        if(UserDefaultsHelper.playSounds && UserDefaultsHelper.playBGMusic){
            SoundManager.shared.playBGSound()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let syringeDart = contact.bodyB.node as? SyringeDart{
            if let zombieGirl = contact.bodyA.node as? ZombieGirl{
                if(zombieGirl.isHealed){
                    return
                }
                syringeDart.removeFromGameScene()
                
                SoundManager.shared.playSound(sound: .bulletImpact)
                
                self.currentLevel.hits += 1
                self.addScore(score: self.currentLevel.scoreBase)
                self.showEarnedPoints(score: 100, onNode: zombieGirl)
                
                zombieGirl.hitBySyringe()
                if(zombieGirl.isHealed){
                    zombieGirl.removeAllActions()
    
                    explosionEmitterNode?.setScale(0.35)
                    explosionEmitterNode?.isHidden = false
                    
                    if(explosionEmitterNode?.parent == nil){
                        zombieGirl.addChild(explosionEmitterNode!)
                    }
    
                    SoundManager.shared.playSound(sound: .unzombiefiedSound)
                    
                    self.player.curedZombie()
                    
                    zombieGirl.run(SKAction.wait(forDuration: 0.45), completion: {
                        zombieGirl.texture = SKTexture(imageNamed: self.currentLevel.zombieCuredImageName)
                        self.explosionEmitterNode?.removeFromParent()
                        zombieGirl.removeAllActions()
                        zombieGirl.run(zombieGirl.currentPath.exitPath, completion: {
                            self.currentLevel.removeZombieGirl(zombieGirl: zombieGirl)
                            self.restartZombieActions()
                        })
                    })
                }
            }
            return
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.curTime = currentTime
        if(self.view!.isPaused){
            if(self.pauseStartTime == 0){
                self.pauseStartTime = currentTime
            }
        }else if(!self.view!.isPaused && self.pauseStartTime != 0){
            self.startTime += (currentTime - self.pauseStartTime)
            self.pauseStartTime = 0
        }
        
        if(!self.gameRunning){
            return
        }
        
        if(self.startTime == 0){
            self.startTime = currentTime
        }
        
        let timeDelta:TimeInterval = currentTime - self.startTime
        if(timeDelta >= self.gameDuration){
            self.showGameOver()
        }
        let timeLeft = self.gameDuration - timeDelta
        self.lblTime?.text = "\(timeLeft.format(using: [.minute, .second])!)"
        
        self.lastUpdateTime = currentTime
    }
    
    func updateEffectNode(){
        if(effectNode.parent != nil){
            effectNode.removeFromParent()
            effectNode = SKEffectNode()
        }
        
        if(effectNode.parent == nil){
            let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 15])
            effectNode.filter = blurFilter
            let blurNode:SKShapeNode = SKShapeNode(rect: self.frame)
            
            blurNode.fillColor = .white
            blurNode.zPosition = 10001
            
            let fillTexture = self.view?.texture(from: contentNode!, crop: blurNode.frame)
            blurNode.fillTexture = fillTexture
            
            effectNode.addChild(blurNode)
            effectNode.zPosition = 10001
            self.addChild(effectNode)
            effectNode.isHidden = true
        }
    }
    
    func endGame(){
        self.gameRunning = false
        SoundManager.shared.stopBGSound()
    }
    
    func showGameOver(){
        self.endGame()
        self.scoreLblOrigPos = self.lblScore!.position
        self.certsLblOrigPos = self.lblCerts!.position
        self.lblScore?.run(SKAction.group([SKAction.move(to: CGPoint(x: 0, y: 180), duration: 0.45), SKAction.scale(to: 2.5, duration: 0.45)]))
        self.lblCerts?.run(SKAction.group([SKAction.move(to: CGPoint(x: 0, y: 100), duration: 0.45), SKAction.scale(to: 1.75, duration: 0.45)]))
        
        ICloudStorageHelper.score[self.currentLevel.level.getDesc()] = self.player.score
        ICloudStorageHelper.certificate[self.currentLevel.level.getDesc()] = self.player.certsPickedUp
        ICloudStorageHelper.vaccination[self.currentLevel.level.getDesc()] = self.player.zombiesCured
        ICloudStorageHelper.highscore += self.player.score
        ICloudStorageHelper.certificates += self.player.certsPickedUp
        ICloudStorageHelper.vaccinations += self.player.zombiesCured
        
        UserDefaultsHelper.score[self.currentLevel.level.getDesc()] = self.player.score
        UserDefaultsHelper.certificate[self.currentLevel.level.getDesc()] = self.player.certsPickedUp
        UserDefaultsHelper.vaccination[self.currentLevel.level.getDesc()] = self.player.zombiesCured
        UserDefaultsHelper.highscore += self.player.score
        UserDefaultsHelper.certificates += self.player.certsPickedUp
        UserDefaultsHelper.vaccinations += self.player.zombiesCured
        
        self.currentLevel.endLevel()
        self.explosionEmitterNode?.removeFromParent()

        if(self.player.health <= 0.0){
            SoundManager.shared.playSound(sound: .gameover)
            self.lblGameOver?.text = "Game over!"
        }else{
            SoundManager.shared.playSound(sound: .youWin)
            self.lblGameOver?.text = "You win!"
        }
        
        self.updateEffectNode()
        self.effectNode.isHidden = false
        
        self.lblGameOver?.alpha = 1.0
        self.lblGameOver?.isHidden = false

        self.lblGameOver?.run(SKAction.sequence([SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.group([SKAction.scale(to: 0.85, duration: self.gameOverFlashTimeStep)])]), completion: {
            self.lblPressAnyKey?.alpha = 0.0
            self.lblPressAnyKey?.isHidden = false
            self.lblPressAnyKey?.run(SKAction.fadeIn(withDuration: 0.45), completion: {
                self.waitForAnyKey = true
            })
            
            let nextLevel:Level = self.currentLevel.level.getNextLevel()
//            if(nextLevel.rawValue >= UserDefaultsHelper.levelProgress.rawValue){
//                UserDefaultsHelper.levelProgress = nextLevel
//            }
            UserDefaultsHelper.levelID = nextLevel
//            UserDefaultsHelper.highscore += self.player.score
//            UserDefaultsHelper.certificates += self.player.certsPickedUp
//            UserDefaultsHelper.vaccinations += self.player.zombiesCured
            
            ICloudStorageHelper.level = nextLevel.getDesc()
//            ICloudStorageHelper.highscore += self.player.score
            ICloudStorageHelper.difficulty = UserDefaultsHelper.difficulty.rawValue
            
            if(UserDefaultsHelper.useGameCenter && UserDefaultsHelper.uploadHighscore){
                let gameCenterHelper = self.getViewController().gameCenterHelper
                gameCenterHelper!.updateScore(with: UserDefaultsHelper.highscore)
                gameCenterHelper!.updateCertificates(with: UserDefaultsHelper.certificates)
                gameCenterHelper!.updateVaccinations(with: UserDefaultsHelper.vaccinations)
                
                if(nextLevel == .MissionAccomplished){
                    GCAchievements.shared.add2completeAllLevels()
                }
                if(self.currentLevel.shots > 0 && self.currentLevel.shots == self.currentLevel.hits){
                    GCAchievements.shared.add2perfectThrows()
                }
                if(self.player.bites == 0){
                    GCAchievements.shared.add2stayHealthy()
                }
            }
        })
    }
    
    func clickedAtPoint(point:CGPoint){
        if(!self.gameRunning && self.waitForAnyKey){
            ICloudStorageHelper.level = UserDefaultsHelper.levelID.getDesc()
            self.getViewController().loadMapScene()
            return
        }

        let node = self.atPoint(point)
        
        for syringeNode in self.syringePickupManager.pickups{
            if(self.checkIsNode(node2Check: node, isNode: syringeNode)){
                syringeNode.pickedUp(afterTimeOut: false)
                return
            }
        }
        
        if(self.checkIsNode(node2Check: node, isNode: self.imgArrowDown!)){
            self.gameStateMachine.enter(SettingsState.self)
            return
        }
        
        for certNode in self.certificatePickupManager.pickups{
            if(self.checkIsNode(node2Check: node, isNode: certNode)){
                certNode.pickedUp(afterTimeOut: false)
                return
            }
        }
        
        if(self.checkIsNode(node2Check: node, isNode: self.medkitPickup!)){
            self.medkitPickup?.pickedUp()
            return
        }
        
        if(!self.player.hasSyringes){
            return
        }
        
        let newDart:SyringeDart = SyringeDart(gameScene: self)
        self.thrownSyringeDarts.append(newDart)
        newDart.shootSyringe(point: point)
    }
    
    func checkIsNode(node2Check:SKNode, isNode:SKNode)->Bool{
        return (node2Check == isNode || node2Check.parent == isNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
