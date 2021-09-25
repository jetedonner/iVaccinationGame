//
//  BasePickupNode.swift
//  BasePickupNode
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

class BasePickupNode: SKSpriteNode {
    
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
    
//    func genNewPos(){
//        var isBehindGKAccessPoint:Bool = true
//        var isBehindHand:Bool = true
//        var newPoint:CGPoint = CGPoint(x: 0, y: 0)
//        repeat{
//            let newX:CGFloat = CGFloat.random(in: ((self.gameScene.frame.width / -2) + 20) ... ((self.gameScene.frame.width / 2) - 20))
//            let newY:CGFloat = CGFloat(Double.random(in: self.gameScene.currentLevel.syringeRespawnYRange))
//            newPoint = CGPoint(x: newX, y: newY)
//
//            let accsPntCoord:CGRect = GKAccessPoint.shared.frameInScreenCoordinates
//            print("GKAccessPointCoord: \(accsPntCoord)")
//            isBehindGKAccessPoint = accsPntCoord.contains(newPoint)
//            isBehindHand = self.gameScene.imgThrowingHand!.frame.contains(newPoint)
//        }while(isBehindHand || isBehindGKAccessPoint)
//        self.gameScene.syringePickup?.position = newPoint
//        self.gameScene.syringePickup?.alpha = 1.0
//    }
//
    override func calculateAccumulatedFrame() -> CGRect {
        let frm = self.frame
        let newSize:CGSize = CGSize(width: frm.size.width * self.accumulatedFrameFactor, height: frm.size.height * self.accumulatedFrameFactor)
        return CGRect(x: frm.origin.x , y: frm.origin.y, width: newSize.width, height: newSize.height)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
