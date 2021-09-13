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
        var pointIn = event.location(in: (self.scene as! GameScene).bg!)
        pointIn.x += ((self.scene as! GameScene).imgCH?.size.width)! / 2
        pointIn.y -= ((self.scene as! GameScene).imgCH?.size.height)! / 2
        (self.scene as! GameScene).syringe?.isHidden = false
        (self.scene as! GameScene).syringe?.position = CGPoint(x: 0, y: -300)
        (self.scene as! GameScene).syringe?.scale(to: CGSize(width: 64, height: 64))
        self.scene?.run(SKAction.playSoundFileNamed("Media.scnassets/sniperFireReload.mp3", waitForCompletion: true))
        (self.scene as! GameScene).syringe?.run(SKAction.group([SKAction.move(to: pointIn, duration: 0.5), SKAction.scale(to: 0.5, duration: 0.5)]))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            (self.scene as! GameScene).syringe?.isHidden = true
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
    var bg:SKSpriteNode?
    var zombieStartPos:CGPoint?
    var score:Int = 0
    var lblScore:SKLabelNode?
    var lblVacc:SKLabelNode?
    
    override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
        
        self.bg = self.childNode(withName: "BG") as? SKSpriteNode
        
        self.lblScore = self.childNode(withName: "lblScore") as? SKLabelNode
        self.lblVacc = self.childNode(withName: "lblVacc") as? SKLabelNode
        
        self.syringe = self.childNode(withName: "Syringe") as? SKSpriteNode
        self.syringe?.isHidden = true
        self.syringe?.physicsBody = SKPhysicsBody(circleOfRadius: 15.0)
        self.syringe?.physicsBody?.affectedByGravity = false
        
        self.zombieGirl = self.childNode(withName: "ZombieGirl") as? SKSpriteNode
        self.zombieGirl?.physicsBody = SKPhysicsBody(circleOfRadius: 35.0)
        self.zombieGirl?.physicsBody?.affectedByGravity = false
        
        self.syringe?.physicsBody?.contactTestBitMask = 0b0001
        self.zombieGirl?.physicsBody?.contactTestBitMask = 0b0010
        
        
        self.zombieStartPos = self.zombieGirl?.position
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        if(self.syringe?.isHidden == true){
            return
        }
        self.syringe?.isHidden = true
        self.run(SKAction.playSoundFileNamed("Media.scnassets/bulletImpact.mp3", waitForCompletion: true))
        self.addScore(score: 100)
    }
    
    func restartZombieAction(){
        self.zombieGirl?.xScale = 0.5
        self.zombieGirl?.yScale = 0.5
        self.zombieGirl?.position = self.zombieStartPos!
        self.zombieGirl?.run(SKAction.sequence([SKAction.group([SKAction.moveBy(x: 90, y: -50, duration: 2.0), SKAction.scale(to: 0.65, duration: 2.0)]), SKAction.group([SKAction.moveBy(x: -225, y: -100, duration: 3.2), SKAction.scale(to: 0.8, duration: 3.2)]), SKAction.group([SKAction.moveBy(x: 380, y: -210, duration: 3.0), SKAction.scale(to: 1.0, duration: 3.0)])]), completion: {
            self.restartZombieAction()
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
        switch event.keyCode {
        case 18:
            self.lblVacc?.text = "Vaccine: Moderna"
            break
        case 19:
            self.lblVacc?.text = "Vaccine: Pfizer"
            break
        case 20:
            self.lblVacc?.text = "Vaccine: Johnson & Johnson"
            break
        case 21:
            self.lblVacc?.text = "Vaccine: Sputnik4"
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
}
