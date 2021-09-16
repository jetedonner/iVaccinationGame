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

extension SKView {
    
    open override func mouseDown(with event: NSEvent) {
        if let menuScene = (self.scene as? MenuScene){
            menuScene.mouseDown(with: event)
            return
        }
        if let gameScene = (self.scene as? GameScene){
            if(gameScene.syringesLeft <= 0){
                super.mouseMoved(with: event)
                var location = event.location(in: gameScene.bg!)
                location.y -= 30.0
                if let imgCH = gameScene.imgCH{
                    location.x += imgCH.size.width / 2
                    location.y -= imgCH.size.height / 2
                }
                let node = gameScene.atPoint(location)
                if(node == gameScene.syringe_pickup){
                    gameScene.syringe_pickup?.alpha = 0.0
                    gameScene.contentNode?.run(SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "w_pkup.mp3", waitForCompletion: false))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        gameScene.syringesLeft = 2
                        gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
                        gameScene.syringe2?.isHidden = false
                        gameScene.syringe1?.isHidden = false
                    }
                }
//                gameScene.syringe_pickup?.position
                return
            }
            var pointIn = event.location(in: gameScene.bg!)
            if let imgCH = gameScene.imgCH{
                pointIn.x += imgCH.size.width / 2
                pointIn.y -= imgCH.size.height / 2
            }
            gameScene.syringe?.isHidden = false
            gameScene.syringesLeft -= 1
            gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
            if(gameScene.syringesLeft == 1){
                gameScene.syringe2?.isHidden = true
            }else if(gameScene.syringesLeft == 0){
                gameScene.syringe1?.isHidden = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    
                    let newX:CGFloat = CGFloat.random(in: ((self.frame.width / -2) + 20) ... ((self.frame.width / 2) - 20))
                    let newY:CGFloat = (gameScene.syringe_pickup?.position.y)!
                    
                    gameScene.syringe_pickup?.position = CGPoint(x: newX, y: newY)
                    gameScene.syringe_pickup?.alpha = 1.0
                    if(gameScene.upwardEmitterNode?.parent == nil){
                        gameScene.upwardEmitterNode?.setScale(0.15)
                        gameScene.upwardEmitterNode?.position.y += 30.0
                        gameScene.syringe_pickup?.addChild(gameScene.upwardEmitterNode!)
                    }
//                    let boundingBoxNode = SKShapeNode(rectOf: gameScene.syringe_pickup!.calculateAccumulatedFrame().size)
//                    boundingBoxNode.lineWidth = 3.0
//                    boundingBoxNode.strokeColor = .red
//                    boundingBoxNode.fillColor = .clear
//                    boundingBoxNode.path = boundingBoxNode.path?.copy(dashingWithPhase: 0, lengths: [10,10])
//                    gameScene.syringe_pickup!.addChild(boundingBoxNode)
                }
            }
            gameScene.syringe?.position = CGPoint(x: 0, y: -300)
            gameScene.syringe?.scale(to: CGSize(width: 64, height: 64))
            self.scene?.run(SKAction.playSoundFileNamed("Media.scnassets/sniperFireReload.mp3", waitForCompletion: true))
            gameScene.syringe?.speed = 1.75
            gameScene.syringe?.run(
                SKAction.group([
                    SKAction.move(to: pointIn, duration: 0.5),
                    SKAction.scale(to: 0.5, duration: 0.5)
                ])
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameScene.syringe?.isHidden = true
            }
        }
    }
    
//    func randomPickupPos()->CGPoint{
//
//
////        let newX = CGFloat.random(in: ((self.frame.width / -2) + 20) ... ((self.frame.width / 2) - 20))
////        let newY =
//    }
}

extension SKView {
    override open func resetCursorRects() {
        if let gameScene = (self.scene as? GameScene){
            gameScene.imgCH = self.resize(image: NSImage(named:NSImage.Name("CH_first_red.png"))!, w: 64, h: 64)
            let image = gameScene.imgCH
            let spot = NSPoint(x: 0, y: 0)
            let customCursor = NSCursor(image: image!, hotSpot: spot)
            addCursorRect(visibleRect, cursor:customCursor)
        }
//        }
    }

    func resize(image: NSImage, w: Int, h: Int) -> NSImage {
        let destSize = NSMakeSize(CGFloat(w), CGFloat(h))
        let newImage = NSImage(size: destSize)
        newImage.lockFocus()
        image.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = destSize
        return NSImage(data: newImage.tiffRepresentation!)!
    }
}

extension SKSpriteNode {
    func drawBorder(color: NSColor, width: CGFloat) {
        let shapeNode = SKShapeNode(rect: frame)
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = color
        shapeNode.lineWidth = width
        addChild(shapeNode)
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var imgCH:NSImage?
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var zombieGirl:SKSpriteNode?
    var syringe:SKSpriteNode?
    var syringe1:SKSpriteNode?
    var syringe2:SKSpriteNode?
    var syringe_pickup:SKSpriteNode?
    
    var imgBlood:SKSpriteNode?
    var imgRedOut:SKSpriteNode?
    
    var contentNode:SKNode?
    var bg:SKSpriteNode?
    var zombieStartPos:CGPoint?
    
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
    let upwardEmitterNode = SKEmitterNode(fileNamed:"UpwardParticles.sks")
    
    override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
        
        self.gameDuration = UserDefaultsHelper.roundTime
        self.contentNode = self.childNode(withName: "contentNode")! as SKNode
        self.bg = self.contentNode!.childNode(withName: "BG") as? SKSpriteNode
        self.bg?.texture = SKTexture(imageNamed: "LandscapeNight")
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
        self.syringe_pickup = self.contentNode!.childNode(withName: "Syringe_pickup") as? SKSpriteNode
        self.syringe_pickup?.alpha = 0.0
        self.syringe_pickup?.zPosition = 10000001
//        self.syringe_pickup?.drawBorder(color: .red, width: 3.0)
        
        self.imgBlood = self.contentNode!.childNode(withName: "imgBlood") as? SKSpriteNode
        self.imgBlood?.isHidden = true
        self.imgRedOut = self.contentNode!.childNode(withName: "redOut") as? SKSpriteNode
        self.imgRedOut?.alpha = 0.0
        
        self.syringe = self.contentNode!.childNode(withName: "Syringe") as? SKSpriteNode
        self.syringe?.isHidden = true
        self.syringe?.physicsBody = SKPhysicsBody(circleOfRadius: 15.0)
        self.syringe?.physicsBody?.affectedByGravity = false
        
        self.zombieGirl = self.contentNode!.childNode(withName: "ZombieGirl") as? SKSpriteNode
        self.zombieGirl?.physicsBody = SKPhysicsBody(circleOfRadius: 35.0)
        self.zombieGirl?.physicsBody?.affectedByGravity = false
        self.prgBar.setProgress(1.0)
        self.prgBar.position = CGPoint(x: (self.frame.width / 2) - 20 , y: (self.frame.height / 2) - 12 - 70)
        self.prgBar.zPosition = 10000
        self.addChild(self.prgBar)
        
        self.syringe?.physicsBody?.contactTestBitMask = 0b0001
        self.zombieGirl?.physicsBody?.contactTestBitMask = 0b0010
        
        self.startTime = 0
        
        self.zombieStartPos = self.zombieGirl?.position
        gameRunning = true
        self.restartZombieAction()
        
    }
    
    var songPlayer:AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        if let path = Bundle.main.path(forResource: GameVars.BASE_MEDIA_DIR + "Possession-HumansWin", ofType: "mp3") {
            let filePath = NSURL(fileURLWithPath:path)
            songPlayer = try! AVAudioPlayer.init(contentsOf: filePath as URL)
//            songPlayer?.numberOfLoops = 0 //This line is not required if you want continuous looping music
            songPlayer?.prepareToPlay()
            songPlayer?.volume = 0.15
            songPlayer?.play()
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
        self.run(SKAction.playSoundFileNamed("Media.scnassets/bulletImpact.mp3", waitForCompletion: true))
        self.addScore(score: 100)
        if(self.score % 200 == 0){
            
            
            explosionEmitterNode?.setScale(0.35)
            explosionEmitterNode?.isHidden = false
            self.zombieGirl!.addChild(explosionEmitterNode!)
            self.zombieGirl?.run(SKAction.playSoundFileNamed("Media.scnassets/pickupHealth.mp3", waitForCompletion: false)) // telein
            self.zombieGirl?.run(SKAction.wait(forDuration: 0.45), completion: {
                self.zombieGirl?.texture =  SKTexture(imageNamed: "ZombieGirl2Un")
                self.explosionEmitterNode?.removeFromParent()
                self.zombieGirl?.removeAllActions()
                self.zombieGirl?.run(SKAction.sequence([SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2), SKAction.moveBy(x: 60, y: 10, duration: 0.2), SKAction.moveBy(x: 60, y: -10, duration: 0.2)]), completion: {
                    self.restartAfterGameOver(resetTime: false)
                })
            })
        }
    }
    
    func restartZombieAction(){
        self.imgBlood?.isHidden = true
        self.zombieGirl?.removeAllActions()
        self.explosionEmitterNode?.removeFromParent()
        self.zombieGirl?.xScale = 0.5
        self.zombieGirl?.yScale = 0.5
        self.zombieGirl?.position = self.zombieStartPos!
        self.zombieGirl?.texture =  SKTexture(imageNamed: "ZombieGirl2")
        self.zombieGirl?.speed = 1.5
        self.zombieGirl?.run(SKAction.sequence([SKAction.group([SKAction.moveBy(x: 100, y: -40, duration: 2.0), SKAction.scale(to: 0.65, duration: 2.0)]), SKAction.group([SKAction.moveBy(x: -205, y: -80, duration: 2.5), SKAction.scale(to: 1.0, duration: 2.5)]), SKAction.group([SKAction.moveBy(x: 560, y: -170, duration: 2.9), SKAction.scale(to: 3.0, duration: 2.9)])]), completion: {
            self.health -= self.damage
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
            
            self.zombieGirl?.run(SKAction.group([SKAction.sequence([SKAction.wait(forDuration: 0.25), SKAction.moveBy(x: 0, y: -300, duration: 0.55)]), SKAction.playSoundFileNamed(SoundManager.getRandomEatSound(), waitForCompletion: false)]), completion: {
                var painSnd = GameVars.BASE_MEDIA_DIR + "pain25_1.mp3"
                if(self.health >= 75.0){
                    painSnd = GameVars.BASE_MEDIA_DIR + "pain100_1.mp3"
                }else if(self.health >= 50.0){
                    painSnd = GameVars.BASE_MEDIA_DIR + "pain75_1.mp3"
                }else if(self.health >= 25.0){
                    painSnd = GameVars.BASE_MEDIA_DIR + "pain50_1.mp3"
                }else if(self.health >= 0.0){
                    painSnd = GameVars.BASE_MEDIA_DIR + "pain25_1.mp3"
                }
                self.zombieGirl?.run(SKAction.playSoundFileNamed(painSnd, waitForCompletion: false))
                self.zombieGirl?.run(SKAction.wait(forDuration: 0.75), completion: {
                    self.restartZombieAction()
                })
            })
        })
        self.zombieGirl?.zPosition = 1000
    }
    
    override func keyDown(with event: NSEvent) {
        print("KeyPressed: %d", event.keyCode)
        if(self.waitForAnyKey){
            self.waitForAnyKey = false
            self.lblGameOver?.isHidden = true
            self.lblPressAnyKey?.isHidden = true
            self.effectNode.isHidden = true
            self.restartAfterGameOver()
            return
        }
        
        switch event.keyCode {
        case 5: // G
            self.showGameOver()
            break
        case 15: // R
            self.restartAfterGameOver()
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
        case 53: // ESC => Pause and Show menu
            self.pauseStartTime = self.curTime
            self.view?.isPaused = true
            let vcSettings:SettingsViewController = SettingsViewController()
            vcSettings.gameScene = self
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).presentAsSheet(vcSettings)
            }
            break
        case 0x31:
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    var curTime:TimeInterval = 0
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
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    var gameOverFlashTimeStep:TimeInterval = 0.35
    var gameOverFlashScaleTo:TimeInterval = 1.35
    var gameRunning:Bool = false
    
    func restartAfterGameOver(resetTime:Bool = true){
        if(resetTime){
            self.startTime = 0
        }
        self.gameRunning = true
        self.zombieGirl?.removeAllActions()
        self.zombieGirl?.isPaused = false
        self.restartZombieAction()
    }
    
    var waitForAnyKey:Bool = false
    
    func showGameOver(){
        gameRunning = false
        self.lblGameOver?.alpha = 1.0
        self.lblGameOver?.isHidden = false
        self.effectNode.isHidden = false
        self.zombieGirl?.isPaused = true
        self.zombieGirl?.removeAllActions()
        self.explosionEmitterNode?.removeFromParent()
        self.lblGameOver?.run(SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "gameOver_voice_v1.mp3", waitForCompletion: true))
        self.lblGameOver?.run(SKAction.sequence([SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.group([SKAction.scale(to: 0.85, duration: self.gameOverFlashTimeStep)/*, SKAction.fadeOut(withDuration: self.gameOverFlashTimeStep)*/])]), completion: {
            self.lblPressAnyKey?.alpha = 0.0
            self.lblPressAnyKey?.isHidden = false
            self.lblPressAnyKey?.run(SKAction.fadeIn(withDuration: 0.45))
            self.waitForAnyKey = true
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).gameCenterHelper.updateScore(with: self.score)
            }
        })
    }
}
