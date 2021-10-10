//
//  BasePickupNode.swift
//  BasePickupNode
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit
import GameKit

class BasePickupNode: SKSpriteNode {
    
    var pickupScore:Int = 0
    var timeOutRunning:Bool = false
    var pickupManager:PickupManagerBase!
    
    var accumulatedFrameFactor:CGFloat{
        get {
            switch UserDefaultsHelper.difficulty{
            case .easy:
                return 1.25
            case .medium:
                return 1.0
            case .hard:
                return 0.75
            case .nightmare:
                return 0.5
            }
        }
    }
    
    var _upwardEmitterNode = SKEmitterNode(fileNamed:"UpwardParticles.sks")
    var upwardEmitterNode:SKEmitterNode{
        get { return self._upwardEmitterNode! }
    }
    
    init(pickupManager:PickupManagerBase, imageNamed name: String, emitterFileNamed: String, size:CGSize? = nil) {
        let texture = SKTexture(imageNamed: name)
        self.pickupManager = pickupManager
        super.init(texture: texture, color: SKColor.clear, size: (size ?? texture.size()))
        self._upwardEmitterNode = SKEmitterNode(fileNamed: emitterFileNamed)
        self.upwardEmitterNode.setScale(0.15)
        self.upwardEmitterNode.position.y += 30.0
        
        if(UserDefaultsHelper.devMode){
            self.addDbgBorder()
        }
        self.addChild(self.upwardEmitterNode)
        self.zPosition = 10000
    }
    
    init(imageNamed name: String, emitterFileNamed: String, size:CGSize? = nil) {
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: SKColor.clear, size: (size ?? texture.size()))
        self._upwardEmitterNode = SKEmitterNode(fileNamed: emitterFileNamed)
        self.upwardEmitterNode.setScale(0.15)
        self.upwardEmitterNode.position.y += 30.0
        
        if(UserDefaultsHelper.devMode){
            self.addDbgBorder()
        }
        self.addChild(self.upwardEmitterNode)
        self.zPosition = 10000
    }
    
    func pickedUp(afterTimeOut:Bool = false){
        if(self.timeOutRunning){
            self.abortTimeout()
        }
        if(self.pickupManager != nil){
            self.pickupManager.removePickupFromScene(pickup: self)
        }
    }
    
    
    func genNewPos(overridePos:CGPoint? = nil){
        var isBehindGKAccessPoint:Bool = true
//        var isBehindHand:Bool = true
        var isBehindHandovic:Bool = false
        var newPoint:CGPoint = CGPoint(x: 0, y: 0)
        
        if let gameScene = self.scene as? GameScene{
            repeat{
                let newX:CGFloat = CGFloat.random(in: ((gameScene.frame.width / -2) + 20) ... ((gameScene.frame.width / 2) - 20))
                let newY:CGFloat = CGFloat(Double.random(in: gameScene.currentLevel.syringeRespawnYRange))
                if(overridePos != nil){
                    newPoint = overridePos!
                }else{
                    newPoint = CGPoint(x: newX, y: newY)
                }
                //frame: (-151.7169952392578, -449.0, 280.0, 280.0)
                let newRect:CGRect = CGRect(origin: newPoint, size: CGSize(width: self.frame.width, height: self.frame.height))// CGRect(x: newX, y: newY, width: self.frame.width, height: self.frame.height)
                print("newRect IS LIKE: \(newRect)")
//                isBehindHandovic = self.isNodeBehindHand(rect: newRect)
                print("newRect IS LIKE isBehindHandovic: \(isBehindHandovic)")
//                var isBehind:Bool = false
//                let accsPntCoord:CGRect = GKAccessPoint.shared.frameInScreenCoordinates
                let fictRect:CGRect = CGRect(x: -495, y: -360, width: 128, height: 128)
//                let newRect = accsPntCoord.offsetBy(dx: (self.scene?.frame.width)! / -2, dy: (self.scene?.frame.height)! / -2)
                isBehindGKAccessPoint = fictRect.intersects(newRect)
//                isBehindHand = gameScene.imgThrowingHand!.frame.intersects(newRect)
                
                if(isBehindHandovic || isBehindGKAccessPoint){
                    print("newRect BEHIND: \(newRect)")
                }
                
//                let accsPntCoord:CGRect = GKAccessPoint.shared.frameInScreenCoordinates
//////                print("GKAccessPointCoord: \(accsPntCoord)")
//                let accessFrame = gameScene.scene?.view?.convert(accsPntCoord, from: nil)
////                let ngPoint = gameScene.scene?.view?.convert(newPoint, from: gameScene.scene!)
//                if(accessFrame != nil){
//                    isBehindGKAccessPoint = self.checkNodeBehindHand(node1Rect: accessFrame!, point: newPoint) //accessFrame!.contains(ngPoint!)
////                    isBehindHand = self.checkNodeBehindHand(node1: gameScene.imgThrowingHand!, point: newPoint)// gameScene.imgThrowingHand!.frame.contains(newPoint)
//                }else{
//                    isBehindGKAccessPoint = false
//                     //isBehindHand = false
//                }
//                isBehindHand = self.checkNodeBehindHand(node1: gameScene.imgThrowingHand!, point: newPoint)
            }while(isBehindHandovic || isBehindGKAccessPoint)
//            self.pickupManager.gameScene.showMessage(msg: "NewPos: X: \(newPoint.x), Y: \(newPoint.y)")
            self.position = newPoint
            self.alpha = 1.0
        }
    }
    
    func startTimeout(){
        self.timeOutRunning = true
//        if let gameScene = self.scene as? GameScene{
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(gameScene.currentLevel.certLifetimeRange.randomElement()!), execute: {
//                self.pickedUp()
//            })
//        }
    }
    
    func abortTimeout(){
        self.timeOutRunning = false
    }
    
    func isNodeBehindHand(rect:CGRect)->Bool{
        var bRet:Bool = false
        if let gameScene = self.scene as? GameScene{
            let handFrame:CGRect = gameScene.imgThrowingHand.calculateAccumulatedFrame()
            if(handFrame.intersects(rect)){
                bRet = true
            }
        }
        return bRet
    }
    

    func checkNodeBehindHand(node1:SKSpriteNode, node2:SKSpriteNode)->Bool{
        
        let isbehind:Bool = node1.frame.contains(node2.frame)// !.frame.contains(self.imgTESET!.frame)
        print("TESTZE is behind: \(isbehind)")
        return isbehind
    }
    
    func checkNodeBehindHand(node1:SKSpriteNode, point:CGPoint)->Bool{
        
        let isbehind:Bool = node1.frame.contains(point)// !.frame.contains(self.imgTESET!.frame)
        print("TESTZE is behind: \(isbehind)")
        return isbehind
    }
    
    func checkNodeBehindHand(node1Rect:CGRect, point:CGPoint)->Bool{
        
        let isbehind:Bool = node1Rect.contains(point)// !.frame.contains(self.imgTESET!.frame)
        print("TESTZE is behind: \(isbehind)")
        return isbehind
    }
    
    override func calculateAccumulatedFrame() -> CGRect {
        let frm = self.frame
        let newSize:CGSize = CGSize(width: frm.size.width * self.accumulatedFrameFactor, height: frm.size.height * self.accumulatedFrameFactor)
        return CGRect(x: frm.origin.x , y: frm.origin.y, width: newSize.width, height: newSize.height)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
