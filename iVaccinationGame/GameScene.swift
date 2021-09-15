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
        if let gameScene = (self.scene as? GameScene){
            if(gameScene.syringesLeft <= 0){
                return
            }
            var pointIn = event.location(in: gameScene.bg!)
            pointIn.x += (gameScene.imgCH?.size.width)! / 2
            pointIn.y -= (gameScene.imgCH?.size.height)! / 2
            gameScene.syringe?.isHidden = false
            gameScene.syringesLeft -= 1
            gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
            if(gameScene.syringesLeft == 1){
                gameScene.syringe2?.isHidden = true
            }else if(gameScene.syringesLeft == 0){
                gameScene.syringe1?.isHidden = true
            }
            gameScene.syringe?.position = CGPoint(x: 0, y: -300)
            gameScene.syringe?.scale(to: CGSize(width: 64, height: 64))
            self.scene?.run(SKAction.playSoundFileNamed("Media.scnassets/sniperFireReload.mp3", waitForCompletion: true))
            gameScene.syringe?.run(
                SKAction.group([
                    SKAction.move(to: pointIn, duration: 0.5),
                    SKAction.scale(to: 0.5, duration: 0.5)
                ])
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                gameScene.syringe?.isHidden = true
            }
            if(gameScene.syringesLeft <= 0){
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    gameScene.syringesLeft = 2
                    gameScene.lblSyringesLeft?.text = gameScene.syringesLeft.description + " / 2"
                    gameScene.syringe2?.isHidden = false
                    gameScene.syringe1?.isHidden = false
                }
            }
        }
    }
}

extension SKView {
    override open func resetCursorRects() {
        (self.scene as! GameScene).imgCH = self.resize(image: NSImage(named:NSImage.Name("CH_first.png"))!, w: 64, h: 64)
        let image = (self.scene as! GameScene).imgCH
        let spot = NSPoint(x: 0, y: 0)
        let customCursor = NSCursor(image: image!, hotSpot: spot)
        addCursorRect(visibleRect, cursor:customCursor)
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
    var imgBlood:SKSpriteNode?
    
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
    
    
    var startTime:TimeInterval?
    var gameDuration:TimeInterval = 10.0
    
    override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
        
        self.contentNode = self.childNode(withName: "contentNode")! as SKNode
        self.bg = self.contentNode!.childNode(withName: "BG") as? SKSpriteNode
        
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
        
        self.imgBlood = self.contentNode!.childNode(withName: "imgBlood") as? SKSpriteNode
        self.imgBlood?.isHidden = true
        
        self.syringe = self.contentNode!.childNode(withName: "Syringe") as? SKSpriteNode
        self.syringe?.isHidden = true
        self.syringe?.physicsBody = SKPhysicsBody(circleOfRadius: 15.0)
        self.syringe?.physicsBody?.affectedByGravity = false
        
        self.zombieGirl = self.contentNode!.childNode(withName: "ZombieGirl") as? SKSpriteNode
        self.zombieGirl?.physicsBody = SKPhysicsBody(circleOfRadius: 35.0)
        self.zombieGirl?.physicsBody?.affectedByGravity = false
        
        
        
        self.syringe?.physicsBody?.contactTestBitMask = 0b0001
        self.zombieGirl?.physicsBody?.contactTestBitMask = 0b0010
        
        self.startTime = 0
        
        self.zombieStartPos = self.zombieGirl?.position
        gameRunning = true
        self.restartZombieAction()
        
    }
    
    func addScore(score:Int){
        self.score += score
        self.lblScore?.text = self.score.description + " Points"
        self.lblScore?.run(SKAction.scale(by: 1.5, duration: 0.35),completion: {
            self.lblScore?.xScale = 1.0
            self.lblScore?.yScale = 1.0
        })
    }
    
    let explosionEmitterNode = SKEmitterNode(fileNamed:"MagicParticle.sks")
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
//        self.startTime = 0
//        self.startTime = 0
//        self.gameRunning = true
//        self.zombieGirl?.isPaused = false
        self.imgBlood?.isHidden = true
        self.zombieGirl?.removeAllActions()
        self.explosionEmitterNode?.removeFromParent()
        self.zombieGirl?.xScale = 0.5
        self.zombieGirl?.yScale = 0.5
        self.zombieGirl?.position = self.zombieStartPos!
        self.zombieGirl?.texture =  SKTexture(imageNamed: "ZombieGirl2")
        self.zombieGirl?.run(SKAction.sequence([SKAction.group([SKAction.moveBy(x: 100, y: -40, duration: 2.0), SKAction.scale(to: 0.65, duration: 2.0)]), SKAction.group([SKAction.moveBy(x: -205, y: -80, duration: 2.5), SKAction.scale(to: 1.0, duration: 2.5)]), SKAction.group([SKAction.moveBy(x: 560, y: -170, duration: 2.9), SKAction.scale(to: 3.0, duration: 2.9)])]), completion: {
            self.imgBlood?.isHidden = false
            self.zombieGirl?.run(SKAction.playSoundFileNamed("Media.scnassets/pain25_1.mp3", waitForCompletion: false))
            self.zombieGirl?.run(SKAction.wait(forDuration: 0.75), completion: {
                self.restartZombieAction()
            })
        })
        self.zombieGirl?.zPosition = 1000
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
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
        case 5:
            self.showGameOver()
            break
        case 15:
//            self.zombieGirl?.texture =  SKTexture(imageNamed: "ZombieGirl2")
            self.restartAfterGameOver()
            break
        case 18:
            self.lblVacc?.text = "Vaccine: Moderna"
            self.lblVacc?.fontColor = self.lblTime?.fontColor
//            D91679
//            D91679
            break
        case 19:
            self.lblVacc?.text = "Vaccine: Pfizer"
            self.lblVacc?.fontColor = .orange
            break
        case 20:
            self.lblVacc?.text = "Vaccine: Johnson & Johnson"
            self.lblVacc?.fontColor = .green
            break
        case 21:
            self.lblVacc?.text = "Vaccine: Sputnik"
            self.lblVacc?.fontColor = .yellow
            break
        case 0x31:
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if(!self.gameRunning){
            return
        }
        
        if(self.startTime == 0){
            self.startTime = currentTime
            if(effectNode.parent == nil){
                let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 15])
                effectNode.filter = blurFilter
                var blurNode:SKShapeNode = SKShapeNode(rect: self.frame)// CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
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
        
        let timeDelta:TimeInterval = currentTime - self.startTime!
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
        self.lblGameOver?.run(SKAction.sequence([SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.scale(to: 1.0, duration: self.gameOverFlashTimeStep), SKAction.scale(to: self.gameOverFlashScaleTo, duration: self.gameOverFlashTimeStep), SKAction.group([SKAction.scale(to: 0.85, duration: self.gameOverFlashTimeStep)/*, SKAction.fadeOut(withDuration: self.gameOverFlashTimeStep)*/])]), completion: {
            self.lblPressAnyKey?.alpha = 0.0
            self.lblPressAnyKey?.isHidden = false
            self.lblPressAnyKey?.run(SKAction.fadeIn(withDuration: 0.45))
            self.waitForAnyKey = true
//            self.lblGameOver?.isHidden = true
//            self.effectNode.isHidden = true
//            self.restartAfterGameOver()
        })
    }
}
