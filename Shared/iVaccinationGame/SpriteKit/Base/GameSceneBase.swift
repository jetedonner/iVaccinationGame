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

enum GameState:Int{
    case gameLoading
    case gameRunning
    case paused
    case menuShowing
    case gameOver
    case gameCenterShowing
    case highscoreShowing
}

class GameSceneBase: SKScene, SKPhysicsContactDelegate {
    
//    var imgCH:NSImage?
//    var entities = [GKEntity]()
//    var graphs = [String : GKGraph]()
    
    var gameState:GameState = .gameLoading
    var gamePaused:Bool = false
    func setGameState(isPaused:Bool = true){
        self.gamePaused = isPaused
        if(self.gamePaused){
            self.view?.isPaused = true
            self.pauseStartTime = self.curTime
        }else{
            self.view?.isPaused = false
        }
    }
    
    var lastUpdateTime : TimeInterval = 0
    var label : SKLabelNode?
    var spinnyNode : SKShapeNode?
    
//    var zombieGirl:SKSpriteNode = SKSpriteNode()
    var syringe:SKSpriteNode?
    var syringe1:SKSpriteNode?
    var syringe2:SKSpriteNode?
    
    var medkitPickup:MedKitPickup?
    var syringePickup:SyringePickup?
    
    var imgBlood:SKSpriteNode?
    var imgRedOut:SKSpriteNode?
    var imgThrowingHand:SKSpriteNode?
    
    var contentNode:SKNode?
    var bg:SKSpriteNode?
    
    var score:Int = 0
    var syringesLeft:Int = 2
    
    var effectNode:SKEffectNode = SKEffectNode()
    var lblGameOver:SKLabelNode?
    var lblPressAnyKey:SKLabelNode?
    var lblScore:SKLabelNode?
    var lblTime:SKLabelNode?
    var lblVacc:SKLabelNode?
    var lblSyringesLeft:SKLabelNode?
    var prgBar:CustomProgressBar = CustomProgressBar()
    
    
    var startTime:TimeInterval = 0
    var pauseStartTime:TimeInterval = 0
    var gameDuration:TimeInterval = GameVars.DEV_ROUND_TIME
    
    var health:CGFloat = 100.0
    var damage:CGFloat = GameVars.DEV_ZOMBIE_DAMAGE
    
    let explosionEmitterNode = SKEmitterNode(fileNamed:"MagicParticle.sks")
    
    var gameOverFlashTimeStep:TimeInterval = 0.35
    var gameOverFlashScaleTo:TimeInterval = 1.35
    var gameRunning:Bool = false
    var waitForAnyKey:Bool = false
    var curTime:TimeInterval = 0
    var songPlayer:AVAudioPlayer?
    
    var levels:[BaseLevel] = []
    var currentLevel:BaseLevel = FirstLevel()
    var scoreLblOrigPos:CGPoint = CGPoint()
    var lblEarnedPoints:SKLabelNode!
    
    var chIOS:SKSpriteNode!
    
//    var keyboardHandler:KeyboardHandler!
    
    var zmbGrl:ZombieGirl!
    
    override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
//        self.keyboardHandler = KeyboardHandler(gameScene: self)
        self.levels = [
            FirstLevel(),
            SecondLevel(),
            ThirdLevel()
        ]
        
        self.currentLevel = self.levels[0]
        
        
        self.zmbGrl = ZombieGirl(zombieImageName: self.currentLevel.zombieImageName)
        self.gameDuration = UserDefaultsHelper.roundTime
        self.contentNode = self.childNode(withName: "contentNode")! as SKNode
        self.bg = self.contentNode!.childNode(withName: "BG") as? SKSpriteNode
        
        self.imgThrowingHand = self.contentNode!.childNode(withName: "ThrowingHand") as? SKSpriteNode
        self.chIOS = self.contentNode!.childNode(withName: "chIOS") as? SKSpriteNode
        self.chIOS.alpha = 0.0
        
        self.lblEarnedPoints = self.contentNode!.childNode(withName: "lblEarnedPoints") as? SKLabelNode
        self.lblEarnedPoints.alpha = 0.0
        
        self.lblGameOver = self.contentNode!.childNode(withName: "lblGameOver") as? SKLabelNode
        self.lblGameOver?.isHidden = true
        
        self.lblPressAnyKey = self.contentNode!.childNode(withName: "lblPressAnyKey") as? SKLabelNode
        self.lblPressAnyKey?.isHidden = true
        
        self.lblScore = self.contentNode!.childNode(withName: "lblScore") as? SKLabelNode
        self.lblTime = self.contentNode!.childNode(withName: "lblTime") as? SKLabelNode
        self.lblVacc = self.contentNode!.childNode(withName: "lblVacc") as? SKLabelNode
        self.lblSyringesLeft = self.contentNode!.childNode(withName: "lblSyringesLeft") as? SKLabelNode
        
        
        self.syringe1 = self.contentNode!.childNode(withName: "Syringe_1") as? SKSpriteNode
        self.syringe2 = self.contentNode!.childNode(withName: "Syringe_2") as? SKSpriteNode

        self.medkitPickup = MedKitPickup(imageNamed: "MedicinePickup", emitterFileNamed: "Upward2Particles.sks")
        self.medkitPickup?.position = CGPoint(x: 200, y: 200)
        self.medkitPickup?.zPosition = 1000
        self.medkitPickup?.alpha = 0.0
//        if(GameVars.DEV_MODE){
        if(UserDefaultsHelper.devMode){
            self.medkitPickup?.addDbgBorder()
        }
        self.scene?.addChild(self.medkitPickup!)
        
        self.syringePickup = SyringePickup(imageNamed: "Syringe", emitterFileNamed: "UpwardParticles.sks")
        self.syringePickup?.size = CGSize(width: 64, height: 64)
        self.syringePickup?.position = CGPoint(x: 300, y: -100)
        self.syringePickup?.zPosition = 1000
        self.syringePickup?.alpha = 0.0
//        if(GameVars.DEV_MODE){
        if(UserDefaultsHelper.devMode){
            self.syringePickup?.addDbgBorder()
        }
        self.scene?.addChild(self.syringePickup!)
        
        
        self.imgBlood = self.contentNode!.childNode(withName: "imgBlood") as? SKSpriteNode
        self.imgBlood?.isHidden = true
        self.imgRedOut = self.contentNode!.childNode(withName: "redOut") as? SKSpriteNode
        self.imgRedOut?.alpha = 0.0
        
        self.syringe = self.contentNode!.childNode(withName: "Syringe") as? SKSpriteNode
        self.syringe?.isHidden = true
        self.syringe?.physicsBody = SKPhysicsBody(circleOfRadius: 15.0)
        self.syringe?.physicsBody?.affectedByGravity = false
        
        self.scene?.addChild(self.zmbGrl)
        self.zmbGrl.physicsBody = SKPhysicsBody(rectangleOf: self.zmbGrl.size)
        self.zmbGrl.physicsBody?.affectedByGravity = false
        self.zmbGrl.physicsBody?.isDynamic = false
        
        if(UserDefaultsHelper.devMode){
            self.zmbGrl.addDbgBorder()
        }
        
        self.prgBar.setProgress(1.0)
        self.prgBar.position = CGPoint(x: (self.frame.width / 2) - 20 , y: (self.frame.height / 2) - 12 - 70)
        self.prgBar.zPosition = 1000
        self.addChild(self.prgBar)
        
        self.syringe?.physicsBody?.contactTestBitMask = 0b0001
        self.zmbGrl.physicsBody?.contactTestBitMask = 0b0010
        
        self.scoreLblOrigPos = self.lblScore!.position
        
        self.restartLevel()
        
        self.handInitRot = self.imgThrowingHand?.zRotation
        self.handInitPos = self.imgThrowingHand?.position
        self.setupHandAnimation()
        gameRunning = true
        self.restartZombieAction()
        
    }
    
    
    let earnedPointLblTime:TimeInterval = 1.5
    func showEarnedPoints(){
        self.lblEarnedPoints.removeAllActions()
        self.lblEarnedPoints.zPosition = 1000
        self.lblEarnedPoints.setScale(1.0)
        self.lblEarnedPoints.position = CGPoint(x: self.zmbGrl.position.x, y: self.zmbGrl.position.y + (self.zmbGrl.frame.height / 2) + 20)
        self.lblEarnedPoints.alpha = 1.0
        self.lblEarnedPoints.run(SKAction.group([SKAction.move(by: CGVector(dx: 0, dy: 150), duration: self.earnedPointLblTime), SKAction.fadeOut(withDuration: self.earnedPointLblTime), SKAction.scale(to: 0.25, duration: self.earnedPointLblTime)]))
    }
    
    func restartLevel(){
        
        if(UserDefaultsHelper.level == "City Skyline" || UserDefaultsHelper.level == "City Skyline (Night)"){
            self.currentLevel = self.levels[0]
        }else if(UserDefaultsHelper.level == "Wallway" || UserDefaultsHelper.level == "Wallway (Night)"){
            self.currentLevel = self.levels[1]
        }else{
            self.currentLevel = self.levels[2]
        }
        self.currentLevel.setupLevel(gameScene: self)
        self.restartAfterGameOverNG(resetTime: true)
    }
    
    var handInitRot:CGFloat?
    var handInitPos:CGPoint?
    
    override func didMove(to view: SKView) {
        if(UserDefaultsHelper.playSounds && UserDefaultsHelper.playBGMusic){
            if let path = Bundle.main.path(forResource: GameVars.BASE_MEDIA_DIR + "Possession-HumansWin", ofType: "mp3") {
                let filePath = NSURL(fileURLWithPath:path)
                songPlayer = try! AVAudioPlayer.init(contentsOf: filePath as URL)
                songPlayer?.numberOfLoops = -1 //This line is not required if you want continuous looping music
                songPlayer?.prepareToPlay()
                songPlayer?.volume = 0.15
                songPlayer?.play()
            }
        }
    }
    
    func runHandThrowingAnimation(){
        self.imgThrowingHand?.removeAllActions()
        let throwAct:SKAction = SKAction.group([SKAction.rotate(byAngle: 1.6, duration: 0.25), SKAction.moveBy(x: -20, y: -200, duration: 0.25)])
        self.imgThrowingHand?.run(throwAct, completion: {
            self.imgThrowingHand?.zRotation = self.handInitRot!
            self.imgThrowingHand?.position = self.handInitPos!
            self.setupHandAnimation()
        })
    }
    
    func setupHandAnimation(){
        let oneLoop:SKAction = SKAction.sequence([SKAction.group([SKAction.rotate(byAngle: -0.1, duration: 0.5), SKAction.move(by: CGVector(dx: 0, dy: -10), duration: 0.5)]), SKAction.group([SKAction.rotate(byAngle: 0.1, duration: 0.5), SKAction.move(by: CGVector(dx: 0, dy: 10), duration: 0.5)])])
        oneLoop.timingMode = .easeInEaseOut
        self.imgThrowingHand?.run(SKAction.repeatForever(SKAction.sequence([SKAction.repeat(oneLoop, count: 2), SKAction.wait(forDuration: 0.35), SKAction.repeat(oneLoop, count: 2), SKAction.wait(forDuration: 0.15)])))
    }
    
    func addScore(score:Int){
        self.score += score
        self.lblScore?.text = self.score.description + " Points"
        self.lblScore?.run(SKAction.scale(by: 1.5, duration: 0.35),completion: {
            self.lblScore?.xScale = 1.0
            self.lblScore?.yScale = 1.0
        })
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if(self.syringe?.isHidden == true){
            return
        }
        self.syringe?.isHidden = true
        if(UserDefaultsHelper.playSounds){
            self.run(SoundManager.bulletImpactSound)
        }
        self.currentLevel.hits += 1
        self.addScore(score: 100)
        self.showEarnedPoints()
        if(self.score % 200 == 0){
            
            explosionEmitterNode?.setScale(0.35)
            explosionEmitterNode?.isHidden = false
            
            if(explosionEmitterNode?.parent == nil){
                self.zmbGrl.addChild(explosionEmitterNode!)
            }
            if(UserDefaultsHelper.playSounds){
                self.zmbGrl.run(SoundManager.unzombiefiedSound) // telein
            }
            self.zmbGrl.run(SKAction.wait(forDuration: 0.45), completion: {
                self.zmbGrl.texture = SKTexture(imageNamed: self.currentLevel.zombieCuredImageName)
                self.explosionEmitterNode?.removeFromParent()
                self.zmbGrl.removeAllActions()
                
                self.zmbGrl.run(self.currentLevel.zombieCurrentPath.exitPath, completion: {
                    self.restartAfterHit(resetTime: false)
                })
            })
        }
    }
    
    func restartZombieAction(){
        self.imgBlood?.isHidden = true
        self.zmbGrl.removeAllActions()
        self.explosionEmitterNode?.removeFromParent()
        self.currentLevel.zombieCurrentPath = self.currentLevel.zombiePaths.randomElement()!
        self.zmbGrl.xScale = self.currentLevel.zombieCurrentPath.initScale // 0.5
        self.zmbGrl.yScale = self.currentLevel.zombieCurrentPath.initScale //0.5
        self.zmbGrl.position = self.currentLevel.zombieCurrentPath.initPos// self.zombieStartPos!
        self.zmbGrl.texture =  SKTexture(imageNamed: "ZombieGirl2")
        self.zmbGrl.speed = UserDefaultsHelper.speedMultiplierForDifficulty
        self.zmbGrl.run(self.currentLevel.zombieCurrentPath.path, completion: {
            self.health -= self.currentLevel.zombieDamage
            self.imgBlood?.isHidden = false
            self.imgBlood?.alpha = 1.0
            if(self.health <= 0.0){
                self.imgRedOut?.run(SKAction.fadeIn(withDuration: 1.0), completion: {
                    self.imgRedOut?.alpha = 0.0
                    self.imgBlood?.isHidden = true
                    self.health = 100.0
                    self.prgBar.setProgress(1.0)
                    self.showGameOver()
                })
            }else{
                
            }
            self.prgBar.setProgress(self.health / 100.0)
            
            if(self.health <= 75.0){
                self.medkitPickup?.alpha = 1.0
                let newX:CGFloat = CGFloat.random(in: ((self.frame.width / -2) + 20) ... ((self.frame.width / 2) - 20))
                let newY:CGFloat = CGFloat(Double.random(in: self.currentLevel.medkitRespawnYRange))
                self.medkitPickup?.position = CGPoint(x: newX, y: newY)
            }
            
            self.zmbGrl.run(SKAction.group([SKAction.sequence([SKAction.wait(forDuration: 0.25), SKAction.moveBy(x: 0, y: -300, duration: 0.55)]), (UserDefaultsHelper.playSounds ? SoundManager.eatSound : SKAction.wait(forDuration: 0.0))]), completion: {
                var painSnd:SKAction = SoundManager.painSounds[3]
                if(self.health >= 75.0){
                    painSnd = SoundManager.painSounds[PainSoundLevel.PAIN_100.rawValue]
                }else if(self.health >= 50.0){
                    painSnd = SoundManager.painSounds[PainSoundLevel.PAIN_75.rawValue]
                }else if(self.health >= 25.0){
                    painSnd = SoundManager.painSounds[PainSoundLevel.PAIN_50.rawValue]
                }else if(self.health < 25.0){
                    painSnd = SoundManager.painSounds[PainSoundLevel.PAIN_25.rawValue]
                }
                
                if(UserDefaultsHelper.playSounds){
                    self.zmbGrl.run(painSnd)
                }
                self.zmbGrl.run(SKAction.wait(forDuration: 0.75), completion: {
                    self.restartZombieAction()
                })
            })
        })
        self.zmbGrl.zPosition = 101
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
            if(effectNode.parent == nil){
                let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 15])
                effectNode.filter = blurFilter
                let blurNode:SKShapeNode = SKShapeNode(rect: self.frame)// CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
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
        
        let timeDelta:TimeInterval = currentTime - self.startTime
        if(timeDelta >= self.gameDuration){
            self.showGameOver()
        }
        let timeLeft = self.gameDuration - timeDelta
        self.lblTime?.text = "\(timeLeft.format(using: [.minute, .second])!)"
        
        self.lastUpdateTime = currentTime
    }
    
    func restartAfterGameOverNG(resetTime:Bool = true, loadNewLevel:Bool = false){
        self.waitForAnyKey = false
        self.lblGameOver?.isHidden = true
        self.lblPressAnyKey?.isHidden = true
        self.effectNode.isHidden = true
        self.lblScore?.position = self.scoreLblOrigPos
        self.lblScore?.setScale(1.0)
        if(loadNewLevel){
            self.currentLevel = self.levels.randomElement()!
            self.restartLevel()
        }
        self.gameRunning = true
        self.restartAfterHit(resetTime: resetTime)
    }
    
    func restartAfterHit(resetTime:Bool = true){
        if(resetTime){
            self.startTime = 0
//            self.lastUpdateTime = 0
//            self.gameDuration = 0
        }
        
        self.zmbGrl.removeAllActions()
        self.zmbGrl.isPaused = false
        self.restartZombieAction()
    }
    
    func showGameOver(){
        self.gameRunning = false
        self.scoreLblOrigPos = self.lblScore!.position
        self.lblScore?.run(SKAction.group([SKAction.move(to: CGPoint(x: 0, y: 180), duration: 0.45), SKAction.scale(to: 2.5, duration: 0.45)]))
        self.lblGameOver?.alpha = 1.0
        self.lblGameOver?.isHidden = false
        self.effectNode.isHidden = false

        self.zmbGrl.isPaused = true
        self.zmbGrl.removeAllActions()
        self.explosionEmitterNode?.removeFromParent()
        if(UserDefaultsHelper.playSounds){
            self.lblGameOver?.run(SoundManager.gameoverSound)
        }
        self.lblGameOver?.run(SKAction.sequence([SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.group([SKAction.scale(to: 0.85, duration: self.gameOverFlashTimeStep)/*, SKAction.fadeOut(withDuration: self.gameOverFlashTimeStep)*/])]), completion: {
            self.lblPressAnyKey?.alpha = 0.0
            self.lblPressAnyKey?.isHidden = false
            self.lblPressAnyKey?.run(SKAction.fadeIn(withDuration: 0.45), completion: {
                self.waitForAnyKey = true
            })
            if(UserDefaultsHelper.useGameCenter && UserDefaultsHelper.uploadHighscore){
#if os(iOS)
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).gameCenterHelper.updateScore(with: self.score)
                }
#else
                if let viewCtrl = self.view?.window?.contentViewController{
                    (viewCtrl as! ViewController).gameCenterHelper.updateScore(with: self.score)
                }
#endif
                if(self.currentLevel.shots > 0 && self.currentLevel.shots == self.currentLevel.hits){
                    GCAchievements.shared.add2perfectThrows()
                }
            }
        })
    }
    
    func clickedAtPoint(point:CGPoint){
        if(!self.gameRunning && self.waitForAnyKey){
            self.restartAfterGameOverNG()
            return
        }
        if(self.syringesLeft <= 0){
            let node = self.atPoint(point)
            if(node == self.syringePickup || node.parent == self.syringePickup){
                self.syringePickup?.alpha = 0.0
                if(UserDefaultsHelper.playSounds){
                    self.contentNode?.run(SoundManager.syringePickupSound)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.syringesLeft = 2
                    self.lblSyringesLeft?.text = self.syringesLeft.description + " / 2"
                    self.syringe2?.isHidden = false
                    self.syringe1?.isHidden = false
                }
            }
            if(self.health >= 100.0){
                return
            }
        }
        
        let node = self.atPoint(point)
        if(node == self.medkitPickup || node.parent == self.medkitPickup){
            self.health += 25.0
            self.prgBar.setProgress(self.health / 100.0)
            self.medkitPickup?.run(SKAction.group([SKAction.fadeAlpha(to: (self.health >= 100.0 ? 0.0 : 1.0), duration: 0.1), SoundManager.healthPickupSound]), completion: {
                if(self.health >= 100.0){
                    self.medkitPickup?.alpha = 0.0
                }
            })
            return
        }
        
        if(self.syringesLeft <= 0){
            return
        }
        
        self.currentLevel.shots += 1
        self.runHandThrowingAnimation()
        self.syringe?.isHidden = false
        self.syringesLeft -= 1
        self.lblSyringesLeft?.text = self.syringesLeft.description + " / 2"
        if(self.syringesLeft == 1){
            self.syringe2?.isHidden = true
        }else if(self.syringesLeft == 0){
            self.syringe1?.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                
                let newX:CGFloat = CGFloat.random(in: ((self.frame.width / -2) + 20) ... ((self.frame.width / 2) - 20))
                let newY:CGFloat = CGFloat(Double.random(in: self.currentLevel.syringeRespawnYRange))
                
                self.syringePickup?.position = CGPoint(x: newX, y: newY)
                self.syringePickup?.alpha = 1.0
            }
        }
        self.syringe?.position = CGPoint(x: 0, y: -300)
        self.syringe?.scale(to: CGSize(width: 64, height: 64))
        if(UserDefaultsHelper.playSounds){
            self.scene?.run(SoundManager.shotSound)
        }
        self.syringe?.speed = UserDefaultsHelper.speedMultiplierForDifficulty
        self.syringe?.run(
            SKAction.group([
                SKAction.move(to: point, duration: 0.5),
                SKAction.scale(to: 0.5, duration: 0.5)
            ])
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.syringe?.isHidden = true
        }
    }
}
