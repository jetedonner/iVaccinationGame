//
//  GameScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 16.09.21.
//

import SpriteKit
import GameplayKit

//extension UIImage{
//    class func image(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
//        image?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage
//    }
//}

class GameScene: GameSceneBase {
    
//    var imgCH:UIImage = UIImage(named: "Crosshair")! //UIImage.image(with: UIImage(named: "Crosshair")!, scaledTo: CGSize(width: 64, height: 64))!//self.resize(image: NSImage(named:NSImage.Name("CH_first_red.png"))!, w: 64, h: 64)
//    var crosshair:SKSpriteNode = SKSpriteNode()
    override func sceneDidLoad() {
        super.sceneDidLoad()
//        self.crosshair.texture = SKTexture(imageNamed: "chFirst")// image: self.imgCH)
//        self.crosshair.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        self.crosshair.zPosition = 1000001
////        self.crosshair.position = CGPoint(x: 0, y: 0)
//        self.contentNode!.addChild(self.crosshair)
//        self.imgCH.r = CGSize(width: 64,height: 64)
    }
    
    var chTimeout:TimeInterval = 0.75
    
    func touchDown(atPoint pos : CGPoint) {
        print("touchDown")
        
        if let gameScene = (self.scene as? GameScene){

            if(!gameScene.gameRunning && gameScene.waitForAnyKey){
                gameScene.restartAfterGameOverNG()
                return
            }
            self.chIOS.zPosition = 999
            self.chIOS.position = pos
            self.chIOS.setScale(0.75)
            self.chIOS.alpha = 1.0
            self.chIOS.run(SKAction.group([SKAction.scale(to: 1.45, duration: self.chTimeout), SKAction.fadeAlpha(to: 0.0, duration: self.chTimeout)]))
            gameScene.clickedAtPoint(point: pos)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("touchUp")
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesCancelled")
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
}
