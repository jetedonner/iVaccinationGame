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
    var syringePickup:SyringePickup?
//    var certificatePickup:CertificatePickup?
    var certificatePickupManager:CertificatePickupManager!
    
    var handInitRot:CGFloat?
    var handInitPos:CGPoint?
    
    var imgBlood:SKSpriteNode?
    var imgRedOut:SKSpriteNode?
    var imgThrowingHand:SKSpriteNode?
    var imgArrowDown:SKSpriteNode?
    
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
    let earnedPointLblTime:TimeInterval = 1.5
    
    var chIOS:SKSpriteNode!
    var emptyHands:SKTexture = SKTexture(imageNamed: "ThrowingFingersEmpty")
    var fullHands:SKTexture = SKTexture(imageNamed: "ThrowingFingers")
    
//    var zombieGirl:ZombieGirl!
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
//        self.currentLevel = self.levels[4]
        
        self.gameStateMachine = GameStateMachine(gameScene: self)
        
//        self.zombieGirl = ZombieGirl(zombieImageName: self.currentLevel.zombieImageName)
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
        
        self.syringePickup = SyringePickup()
        self.syringePickup?.size = CGSize(width: 64, height: 64)
        self.syringePickup?.position = CGPoint(x: 300, y: -100)
        self.syringePickup?.zPosition = 1000
        self.syringePickup?.alpha = 0.0
        self.scene?.addChild(self.syringePickup!)
        
        
//        self.certificatePickup = CertificatePickup()
//        self.certificatePickup?.size = CGSize(width: 64, height: 64)
//        self.certificatePickup?.position = CGPoint(x: 300, y: 300)
//        self.certificatePickup?.zPosition = 1000
//        self.scene?.addChild(self.certificatePickup!)
//        self.certificatePickup?.genNewPos()
//        self.certificatePickup?.startTimeout()
        
        self.imgBlood = self.contentNode!.childNode(withName: "imgBlood") as? SKSpriteNode
        self.imgBlood?.isHidden = true
        self.imgRedOut = self.contentNode!.childNode(withName: "redOut") as? SKSpriteNode
        self.imgRedOut?.alpha = 0.0
        
        self.certificatePickupManager = CertificatePickupManager(gameScene: self)
        self.certificatePickupManager.startPickupManager()
        
        self.prgBar.setProgress(1.0)
        self.prgBar.position = CGPoint(x: (self.frame.width / 2) - 20 , y: (self.frame.height / 2) - 12 - 70)
        self.prgBar.zPosition = 1000
        self.addChild(self.prgBar)
        
//        self.zombieGirl.physicsBody?.contactTestBitMask = 0b0010
        self.scoreLblOrigPos = self.lblScore!.position
        
        self.runLevelConfig(levelID: self.selLevel, difficulty: UserDefaultsHelper.difficulty)
        
        self.handInitRot = self.imgThrowingHand?.zRotation
        self.handInitPos = self.imgThrowingHand?.position
        self.setupHandAnimation()
    }
    
    func setSyringesHUD(){
        self.lblSyringesLeft?.text = self.player.vaccineArsenal.vaccinesInArsenal[.Perofixa]!.description + " / 2"
    }
    
    func runLevel(levelID:Level){
        self.loadLevel(levelID: levelID)
        self.restartAfterGameOverNG(resetTime: true)
        self.showMessage(msg: "Level: \(self.currentLevel.levelName)")
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
    
    func restartLevel(){
        if(UserDefaultsHelper.level == "City Skyline" || UserDefaultsHelper.level == "City Skyline (Night)"){
            self.currentLevel = self.levels[0]
        }else if(UserDefaultsHelper.level == "Wallway" || UserDefaultsHelper.level == "Wallway (Night)"){
            self.currentLevel = self.levels[1]
        }else if(UserDefaultsHelper.level == "Meadow" || UserDefaultsHelper.level == "Meadow (Night)"){
            self.currentLevel = self.levels[2]
        }else if(UserDefaultsHelper.level == "City Street" || UserDefaultsHelper.level == "City Street (Night)"){
            self.currentLevel = self.levels[3]
        }else if(UserDefaultsHelper.level == "City Japan" || UserDefaultsHelper.level == "City Japan (Night)"){
            self.currentLevel = self.levels[4]
        }else if(UserDefaultsHelper.level == "City Night" || UserDefaultsHelper.level == "City Night (Night)"){
            self.currentLevel = self.levels[5]
        }else if(UserDefaultsHelper.level == "Scarry Street" || UserDefaultsHelper.level == "Scarry Street (Night)"){
            self.currentLevel = self.levels[6]
        }else{
            self.currentLevel = self.levels[2]
        }
        self.currentLevel.setupLevel(gameScene: self)
        self.restartAfterGameOverNG(resetTime: true)
        self.showMessage(msg: "Level: \(self.currentLevel.levelName)")
    }
    
    override func didMove(to view: SKView) {
        if(UserDefaultsHelper.playSounds && UserDefaultsHelper.playBGMusic){
            SoundManager.shared.playBGSound()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let syringeDart = contact.bodyB.node as? SyringeDart{
            syringeDart.removeFromGameScene()
            
            SoundManager.shared.playSound(sound: .bulletImpact)
            
            self.currentLevel.hits += 1
            self.addScore(score: self.currentLevel.scoreBase)
            if let zombieGirl = contact.bodyA.node as? ZombieGirl{
                self.showEarnedPoints(score: 100, onNode: zombieGirl)
                
                if(self.currentLevel.hits % 2 == 0){
                    zombieGirl.removeAllActions()
    
                    explosionEmitterNode?.setScale(0.35)
                    explosionEmitterNode?.isHidden = false
                    if(explosionEmitterNode?.parent == nil){
                        zombieGirl.addChild(explosionEmitterNode!)
                    }
    
                    SoundManager.shared.playSound(sound: .unzombiefiedSound)
    
                    zombieGirl.run(SKAction.wait(forDuration: 0.45), completion: {
                        zombieGirl.texture = SKTexture(imageNamed: self.currentLevel.zombieCuredImageName)
                        self.explosionEmitterNode?.removeFromParent()
                        zombieGirl.removeAllActions()
                        zombieGirl.run(zombieGirl.currentPath.exitPath, completion: {
                            self.currentLevel.removeZombieGirl(zombieGirl: zombieGirl)
//                            self.restartAfterHit(resetTime: false)
                            self.restartZombieActions()
                        })
                    })
                }
            }
            return
        }
    }
    
    func restartZombieAction(){
//        self.imgBlood?.isHidden = true
//        self.zombieGirl.removeAllActions()
//        self.explosionEmitterNode?.removeFromParent()
//        self.currentLevel.zombieCurrentPath = self.currentLevel.zombiePaths[.easy]!.getRandom()
//        if(self.currentLevel.zombieCurrentPath.hideOnStart){
//            self.zombieGirl.xScale = 0.0
//        }else{
//            self.zombieGirl.xScale = self.currentLevel.zombieCurrentPath.initScale
//        }
//        self.zombieGirl.yScale = self.currentLevel.zombieCurrentPath.initScale
//        self.zombieGirl.position = self.currentLevel.zombieCurrentPath.initPos
//        self.zombieGirl.texture =  SKTexture(imageNamed: "ZombieGirl2")
//        self.zombieGirl.speed = UserDefaultsHelper.speedMultiplierForDifficulty
//        self.zombieGirl.run(self.currentLevel.zombieCurrentPath.path, completion: {
//            self.imgBlood?.isHidden = false
//            self.imgBlood?.alpha = 1.0
//            if(self.player.zombieBite(damage: self.currentLevel.zombieDamage)){
//                self.imgRedOut?.run(SKAction.fadeIn(withDuration: 1.0), completion: {
//                    self.imgRedOut?.alpha = 0.0
//                    self.imgBlood?.isHidden = true
//                    self.showGameOver()
//                    self.player.resetPlayer()
//                    self.prgBar.setProgress(1.0)
//                })
//            }
//
//            self.prgBar.setProgress(self.player.health / 100.0)
//
//            if(self.player.health <= 75.0){
//                self.medkitPickup?.genNewPos()
//            }
//
//            SoundManager.shared.playSound(sounds: [.eat1, .eat2])
//            self.zombieGirl.run(SKAction.group([SKAction.sequence([SKAction.wait(forDuration: 0.25), SKAction.moveBy(x: 0, y: -300, duration: 0.55)])]), completion: {
//                if(self.player.health >= 75.0){
//                    SoundManager.shared.playSound(sound: .pain100)
//                }else if(self.player.health >= 50.0){
//                    SoundManager.shared.playSound(sound: .pain75)
//                }else if(self.player.health >= 25.0){
//                    SoundManager.shared.playSound(sound: .pain50)
//                }else {
//                    SoundManager.shared.playSound(sound: .pain25)
//                }
//
//                self.zombieGirl.run(SKAction.wait(forDuration: 0.75), completion: {
//                    self.restartZombieAction()
//                })
//            })
//        })
//        self.zombieGirl.zPosition = 101
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
//            self.updateEffectNode()
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
    
    func restartAfterGameOverNG(resetTime:Bool = true, loadNewLevel:Bool = false){
        self.waitForAnyKey = false
        self.lblGameOver?.isHidden = true
        self.lblPressAnyKey?.isHidden = true
        self.effectNode.isHidden = true
        self.lblScore?.position = self.scoreLblOrigPos
        self.lblScore?.setScale(1.0)
        self.player.resetPlayer()
        if(loadNewLevel){
            self.loadLevel(levelID: self.levels.getRandom().level)
        }
        self.gameRunning = true
        self.showMessage(msg: "Level: \(self.currentLevel.levelName)")
        self.restartAfterHit(resetTime: resetTime)
    }
    
    func restartAfterHit(resetTime:Bool = true){
        if(resetTime){
            self.startTime = 0
        }
//        self.zombieGirl.removeAllActions()
//        self.zombieGirl.isPaused = false
        self.restartZombieAction()
    }
    
    func showGameOver(){
        self.gameRunning = false
        SoundManager.shared.stopBGSound()
        self.scoreLblOrigPos = self.lblScore!.position
        self.lblScore?.run(SKAction.group([SKAction.move(to: CGPoint(x: 0, y: 180), duration: 0.45), SKAction.scale(to: 2.5, duration: 0.45)]))
        ICloudStorageHelper.score[self.currentLevel.level.getDesc()] = self.player.score
        ICloudStorageHelper.certificate[self.currentLevel.level.getDesc()] = self.player.certsPickedUp
        ICloudStorageHelper.certificates += self.player.certsPickedUp
        self.lblGameOver?.alpha = 1.0
        self.lblGameOver?.isHidden = false
        

//        self.zombieGirl.isPaused = true
//        self.zombieGirl.removeAllActions()
        
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

        self.lblGameOver?.run(SKAction.sequence([SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.group([SKAction.scale(to: 0.85, duration: self.gameOverFlashTimeStep)/*, SKAction.fadeOut(withDuration: self.gameOverFlashTimeStep)*/])]), completion: {
            self.lblPressAnyKey?.alpha = 0.0
            self.lblPressAnyKey?.isHidden = false
            self.lblPressAnyKey?.run(SKAction.fadeIn(withDuration: 0.45), completion: {
                self.waitForAnyKey = true
            })
            let nextLevel:Level = self.currentLevel.level.getNextLevel()
            UserDefaultsHelper.levelID = nextLevel
            if(UserDefaultsHelper.useGameCenter && UserDefaultsHelper.uploadHighscore){
            #if os(iOS)
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).gameCenterHelper.updateScore(with: self.player.highscore)
                    (viewCtrl as! GameViewController).gameCenterHelper.updateCertificates(with: self.player.certsPickedUp)
                    ICloudStorageHelper.highscore += self.player.highscore
                    UserDefaultsHelper.highscore += self.player.highscore
                    ICloudStorageHelper.level = nextLevel.getDesc()
                    ICloudStorageHelper.difficulty = UserDefaultsHelper.difficulty.rawValue
                }
            #else
                if let viewCtrl = self.view?.window?.contentViewController{
                    (viewCtrl as! ViewController).gameCenterHelper.updateScore(with: self.player.score)
                    (viewCtrl as! ViewController).gameCenterHelper.updateCertificates(with: self.player.certsPickedUp)
                    ICloudStorageHelper.highscore += self.player.score
                    UserDefaultsHelper.highscore += self.player.score
                    ICloudStorageHelper.level = nextLevel.getDesc()
                    ICloudStorageHelper.difficulty = UserDefaultsHelper.difficulty.rawValue
                }
            #endif
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
            #if os(iOS)
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).loadMapScene()
                }
            #else
                if let viewCtrl = self.view?.window?.contentViewController{
                    (viewCtrl as! ViewController).loadMapScene()
                }
            #endif
            return
        }

        let node = self.atPoint(point)
        if(self.checkIsNode(node2Check: node, isNode: self.syringePickup!)){
            self.syringePickup?.pickedUp()
            return
        }
        
        if(self.checkIsNode(node2Check: node, isNode: self.imgArrowDown!)){
            self.gameStateMachine.enter(SettingsState.self)
            return
        }
        
        for certNode in self.certificatePickupManager.pickups{
            if(self.checkIsNode(node2Check: node, isNode: certNode)){
                certNode.pickedUp()
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
