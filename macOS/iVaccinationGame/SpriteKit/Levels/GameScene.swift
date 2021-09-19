//
//  GameScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 13.09.21.
//
import Cocoa
import SpriteKit
import GameplayKit
import AVKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var imgCH:NSImage?
//    var entities = [GKEntity]()
//    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var zombieGirl:SKSpriteNode = SKSpriteNode()
    var syringe:SKSpriteNode?
    var syringe1:SKSpriteNode?
    var syringe2:SKSpriteNode?
    
    var medkitPickup:MedKitPickup?
    var syringePickup:SyringePickup?
    
    var imgBlood:SKSpriteNode?
    var imgRedOut:SKSpriteNode?
    
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
    
    
    override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
        
        self.levels = [FirstLevel(), SecondLevel()]
        self.currentLevel = self.levels[0   ]
        
        self.gameDuration = UserDefaultsHelper.roundTime
        self.contentNode = self.childNode(withName: "contentNode")! as SKNode
        self.bg = self.contentNode!.childNode(withName: "BG") as? SKSpriteNode
        
//        self.bg?.texture = SKTexture(imageNamed: UserDefaultsHelper.level)
//        self.bg?.texture = SKTexture(imageNamed: self.currentLevel!.backgroundImageName)
        
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
        self.medkitPickup?.zPosition = 10000000
        self.medkitPickup?.alpha = 0.0
        if(GameVars.DEV_MODE){
            self.medkitPickup?.addDbgBorder()
        }
        self.scene?.addChild(self.medkitPickup!)
        
        self.syringePickup = SyringePickup(imageNamed: "Syringe", emitterFileNamed: "UpwardParticles.sks")
        self.syringePickup?.size = CGSize(width: 64, height: 64)
        self.syringePickup?.position = CGPoint(x: 300, y: -100)
        self.syringePickup?.zPosition = 10000000
        self.syringePickup?.alpha = 0.0
        if(GameVars.DEV_MODE){
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
        
        self.zombieGirl = self.contentNode!.childNode(withName: "ZombieGirl") as! SKSpriteNode
        self.zombieGirl.physicsBody = SKPhysicsBody(circleOfRadius: 25.0)
        self.zombieGirl.physicsBody?.affectedByGravity = false
        self.zombieGirl.physicsBody?.isDynamic = false
        self.prgBar.setProgress(1.0)
        self.prgBar.position = CGPoint(x: (self.frame.width / 2) - 20 , y: (self.frame.height / 2) - 12 - 70)
        self.prgBar.zPosition = 10000
        self.addChild(self.prgBar)
        
        self.syringe?.physicsBody?.contactTestBitMask = 0b0001
        self.zombieGirl.physicsBody?.contactTestBitMask = 0b0010
        
        self.startTime = 0
        
//        self.zombieStartPos = self.zombieGirl.position
        
        self.currentLevel.setupLevel(gameScene: self)
        gameRunning = true
        self.restartZombieAction()
        
    }
    
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
        self.addScore(score: 100)
        if(self.score % 200 == 0){
            
            
            explosionEmitterNode?.setScale(0.35)
            explosionEmitterNode?.isHidden = false
            if(explosionEmitterNode?.parent == nil){
                self.zombieGirl.addChild(explosionEmitterNode!)
            }
            if(UserDefaultsHelper.playSounds){
                self.zombieGirl.run(SoundManager.unzombiefiedSound) // telein
            }
            self.zombieGirl.run(SKAction.wait(forDuration: 0.45), completion: {
                self.zombieGirl.texture = SKTexture(imageNamed: self.currentLevel.zombieCuredImageName) // "ZombieGirl2Un")
                self.explosionEmitterNode?.removeFromParent()
                self.zombieGirl.removeAllActions()
                
                self.zombieGirl.run(self.currentLevel.zombieExitPaths.randomElement()!, completion: {
                    self.restartAfterHit(resetTime: false)
                })
//                self.zombieGirl?.run(SKAction.sequence([SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2)]), completion: {
//                    self.restartAfterGameOver(resetTime: false)
//                })
            })
        }
    }
    
    func restartZombieAction(){
        self.imgBlood?.isHidden = true
        self.zombieGirl.removeAllActions()
        self.explosionEmitterNode?.removeFromParent()
        self.zombieGirl.xScale = self.currentLevel.zombieInitScale.randomElement()! // 0.5
        self.zombieGirl.yScale = self.currentLevel.zombieInitScale.randomElement()! //0.5
        self.zombieGirl.position = self.currentLevel.zombieInitPos.randomElement()!// self.zombieStartPos!
        self.zombieGirl.texture =  SKTexture(imageNamed: "ZombieGirl2")
        self.zombieGirl.speed = UserDefaultsHelper.speedMultiplierForDifficulty
        self.zombieGirl.run(self.currentLevel.zombiePaths.randomElement()! /*SKAction.sequence([SKAction.group([SKAction.moveBy(x: 100, y: -40, duration: 2.0), SKAction.scale(to: 0.65, duration: 2.0)]), SKAction.group([SKAction.moveBy(x: -205, y: -80, duration: 2.5), SKAction.scale(to: 1.0, duration: 2.5)]), SKAction.group([SKAction.moveBy(x: 560, y: -170, duration: 2.9), SKAction.scale(to: 3.0, duration: 2.9)])])*/, completion: {
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
            }
            
            self.zombieGirl.run(SKAction.group([SKAction.sequence([SKAction.wait(forDuration: 0.25), SKAction.moveBy(x: 0, y: -300, duration: 0.55)]), (UserDefaultsHelper.playSounds ? SoundManager.eatSound : SKAction.wait(forDuration: 0.0))]), completion: {
                var painSnd:SKAction = SoundManager.painSounds[3] // GameVars.BASE_MEDIA_DIR + "pain25_1.mp3"
                if(self.health >= 75.0){
                    painSnd = SoundManager.painSounds[3] // GameVars.BASE_MEDIA_DIR + "pain100_1.mp3"
                }else if(self.health >= 50.0){
                    painSnd = SoundManager.painSounds[2] // GameVars.BASE_MEDIA_DIR + "pain75_1.mp3"
                }else if(self.health >= 25.0){
                    painSnd = SoundManager.painSounds[1] // GameVars.BASE_MEDIA_DIR + "pain50_1.mp3"
                }else if(self.health >= 0.0){
                    painSnd = SoundManager.painSounds[0] // GameVars.BASE_MEDIA_DIR + "pain25_1.mp3"
                }
                if(UserDefaultsHelper.playSounds){
                    self.zombieGirl.run(painSnd)
                }
                self.zombieGirl.run(SKAction.wait(forDuration: 0.75), completion: {
                    self.restartZombieAction()
                })
            })
        })
        self.zombieGirl.zPosition = 1000
    }
    
    override func keyDown(with event: NSEvent) {
        print("KeyPressed: %d", event.keyCode)
        if(self.waitForAnyKey){
//            self.waitForAnyKey = false
//            self.lblGameOver?.isHidden = true
//            self.lblPressAnyKey?.isHidden = true
//            self.effectNode.isHidden = true
            self.restartAfterGameOverNG()
            return
        }
        
        switch event.keyCode {
        case 5: // G
            self.showGameOver()
            break
        case 15: // R
            self.restartAfterHit()
            break
        case 18: // 1
            self.lblVacc?.text = "Vaccine: Moderna"
            self.lblVacc?.fontColor = self.lblTime?.fontColor
            break
        case 19: // 2
            self.lblVacc?.text = "Vaccine: Pfizer"
            self.lblVacc?.fontColor = .orange
            break
        case 20: // 3
            self.lblVacc?.text = "Vaccine: Johnson & Johnson"
            self.lblVacc?.fontColor = .green
            break
        case 21: // 4
            self.lblVacc?.text = "Vaccine: Sputnik"
            self.lblVacc?.fontColor = .yellow
            break
        case 49: // ??
//            self.lblVacc?.text = "Vaccine: Sputnik"
//            self.lblVacc?.fontColor = .yellow
            break
        case 53: // ESC => Pause and Show menu
            self.pauseStartTime = self.curTime
            self.view?.isPaused = true
            let vcSettings:SettingsViewController = SettingsViewController()
            vcSettings.gameScene = self
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).presentAsSheet(vcSettings)
            }
            break
//        case 0x31:
//            if let label = self.label {
//                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
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
            if(effectNode.parent == nil){
                let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 15])
                effectNode.filter = blurFilter
                let blurNode:SKShapeNode = SKShapeNode(rect: self.frame)// CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
                blurNode.fillColor = .white
                blurNode.zPosition = 10001
                let fillTexture = self.view?.texture(from: contentNode!, crop: blurNode.frame)
                blurNode.fillTexture = fillTexture
                effectNode.addChild(blurNode)
                effectNode.zPosition = 10000
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
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
//        if (self.lastUpdateTime == 0) {
//            self.lastUpdateTime = currentTime
//        }
        
//        // Calculate time since last update
//        let dt = currentTime - self.lastUpdateTime
//
//        // Update entities
//        for entity in self.entities {
//            entity.update(deltaTime: dt)
//        }
        
        self.lastUpdateTime = currentTime
    }
    
    func restartAfterGameOverNG(resetTime:Bool = true){
        self.waitForAnyKey = false
        self.lblGameOver?.isHidden = true
        self.lblPressAnyKey?.isHidden = true
        self.effectNode.isHidden = true
        self.lblScore?.position = self.scoreLblOrigPos
        self.lblScore?.setScale(1.0)
        self.gameRunning = true
        self.restartAfterHit(resetTime: resetTime)
    }
    
    func restartAfterHit(resetTime:Bool = true){
        if(resetTime){
            self.startTime = 0
        }
        
        self.zombieGirl.removeAllActions()
        self.zombieGirl.isPaused = false
//        self.lblScore?.run(SKAction.group([SKAction.move(to: CGPoint(x: 0, y: 80), duration: 1.0), SKAction.scale(to: 2.5, duration: 1.0)]))
        self.restartZombieAction()
    }
    
    var scoreLblOrigPos:CGPoint = CGPoint()
    
    func showGameOver(){
        gameRunning = false
        self.scoreLblOrigPos = self.lblScore!.position
        self.lblScore?.run(SKAction.group([SKAction.move(to: CGPoint(x: 0, y: 180), duration: 0.45), SKAction.scale(to: 2.5, duration: 0.45)]))
        self.lblGameOver?.alpha = 1.0
        self.lblGameOver?.isHidden = false
        self.effectNode.isHidden = false
        self.zombieGirl.isPaused = true
        self.zombieGirl.removeAllActions()
        self.explosionEmitterNode?.removeFromParent()
        if(UserDefaultsHelper.playSounds){
            self.lblGameOver?.run(SoundManager.gameoverSound)
        }
        self.lblGameOver?.run(SKAction.sequence([SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.group([SKAction.scale(to: 0.85, duration: self.gameOverFlashTimeStep)/*, SKAction.fadeOut(withDuration: self.gameOverFlashTimeStep)*/])]), completion: {
            self.lblPressAnyKey?.alpha = 0.0
            self.lblPressAnyKey?.isHidden = false
            self.lblPressAnyKey?.run(SKAction.fadeIn(withDuration: 0.45))
            self.waitForAnyKey = true
            if(UserDefaultsHelper.useGameCenter && UserDefaultsHelper.uploadHighscore){
                if let viewCtrl = self.view?.window?.contentViewController{
                    (viewCtrl as! ViewController).gameCenterHelper.updateScore(with: self.score)
                }
            }
        })
    }
}
