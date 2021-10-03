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
    }
    
    func pickedUp(){
        
    }
    
    func genNewPos(){
        var isBehindGKAccessPoint:Bool = true
        var isBehindHand:Bool = true
        var newPoint:CGPoint = CGPoint(x: 0, y: 0)
        
        if let gameScene = self.scene as? GameScene{
            repeat{
                let newX:CGFloat = CGFloat.random(in: ((gameScene.frame.width / -2) + 20) ... ((gameScene.frame.width / 2) - 20))
                let newY:CGFloat = CGFloat(Double.random(in: gameScene.currentLevel.syringeRespawnYRange))
                newPoint = CGPoint(x: newX, y: newY)
                
                let accsPntCoord:CGRect = GKAccessPoint.shared.frameInScreenCoordinates
                print("GKAccessPointCoord: \(accsPntCoord)")
                let accessFrame = gameScene.scene?.view?.convert(accsPntCoord, from: nil)
                let ngPoint = gameScene.scene?.view?.convert(newPoint, from: gameScene.scene!)
                if(accessFrame != nil){
                    isBehindGKAccessPoint = accessFrame!.contains(ngPoint!)
                    isBehindHand = gameScene.imgThrowingHand!.frame.contains(newPoint)
                }else{
                    isBehindGKAccessPoint = false
                    isBehindHand = false
                }
                
            }while(isBehindHand || isBehindGKAccessPoint)
            self.position = newPoint
            self.alpha = 1.0
        }
    }
    
    func startTimeout(){
//        if let gameScene = self.scene as? GameScene{
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(gameScene.currentLevel.certLifetimeRange.randomElement()!), execute: {
//                self.pickedUp()
//            })
//        }
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
