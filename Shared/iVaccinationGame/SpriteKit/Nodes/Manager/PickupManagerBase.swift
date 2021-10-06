//
//  CertificatePickupManager.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 03.10.21.
//

import Foundation
import SpriteKit
import GameplayKit

class PickupManagerBase:GKEntity{
    
    let gameScene:GameSceneBase
    var pickups:[BasePickupNode] = []
    
//    var pickupType:BasePickupNode.Type = BasePickupNode.self
    
    var pickupsOnScene:Int = 0
    var pickupsAtOnce:Int = 1
    
    var removeAfterTimeout:Bool = false
    var removeTimeoutRange = 5...15
    
    var respawnRange = 4...12
    
    convenience init(gameScene:GameSceneBase){
        self.init(gameScene: gameScene, removeAfterTimeOut: false)
    }
    
    init(gameScene:GameSceneBase, removeAfterTimeOut:Bool = false){
        self.gameScene = gameScene
        super.init()
    }
    
    func startPickupManagerNG(){
        for i in 0..<self.pickupsAtOnce{
            self.gameScene.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval((i > 0 ? self.respawnRange.randomElement()! : 0))),
                SKAction.run {
                    self.addPickupToSceneNG(newPickup: self.getPickup()!)
                }
            ]))
        }
    }
    
//    func startPickupManager(){
//        if let newPickup:BasePickupNode = self.addPickupToSceneNG(pickupManager: self){
//            newPickup.size = CGSize(width: 64, height: 64)
//            newPickup.zPosition = 1000
//            newPickup.genNewPos()
//            self.pickups.append(newPickup)
//            if(self.removeAfterTimeout){
//                newPickup.startTimeout()
//            }
//        }
//    }
    
    func getPickup()->BasePickupNode?{
        return nil
    }
    
    func addPickupToSceneNG(pickupManager:PickupManagerBase)->BasePickupNode?{
        return nil
    }
    
    func addPickupToScene()->BasePickupNode?{
        return nil
    }
    
    func addPickupToSceneNG(newPickup:BasePickupNode){
        self.pickupsOnScene += 1
        self.pickups.append(newPickup)
        self.gameScene.addChild(newPickup)
        newPickup.genNewPos()
        newPickup.zPosition = 10001
    }
    
    func addPickupToScene(newPickup:BasePickupNode)->BasePickupNode{
        self.pickupsOnScene += 1
        newPickup.genNewPos()
        newPickup.zPosition = 10001
        self.pickups.append(newPickup)
        self.gameScene.addChild(newPickup)
        return newPickup
    }
    
    func removePickupFromScene(pickup:BasePickupNode){
        pickup.removeFromParent()
        self.pickupsOnScene -= 1
        self.pickups = self.pickups.filter({$0 != pickup})
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
