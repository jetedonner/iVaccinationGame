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
    
    var removeAfterTimeout:Bool = false
    var removeTimeoutRange = 5...15
    
    var respawnRange = 4...15
    
    convenience init(gameScene:GameSceneBase){
        self.init(gameScene: gameScene, removeAfterTimeOut: false)
    }
    
    init(gameScene:GameSceneBase, removeAfterTimeOut:Bool = false){
        self.gameScene = gameScene
        super.init()
    }
    
    func startPickupManager(){
        if let newPickup:BasePickupNode = self.addPickupToScene(){
            newPickup.size = CGSize(width: 64, height: 64)
            newPickup.zPosition = 1000
            newPickup.genNewPos()
            if(self.removeAfterTimeout){
                newPickup.startTimeout()
            }
        }
    }
    
    func addPickupToScene()->BasePickupNode?{
        return nil
    }
    
    func addPickupToScene(newPickup:BasePickupNode)->BasePickupNode{
        self.pickupsOnScene += 1
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
