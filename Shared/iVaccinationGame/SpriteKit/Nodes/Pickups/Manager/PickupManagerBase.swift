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
    
    var generatedPickups:Int = 0
    var pickupsOnScene:Int = 0
    var pickupsAtOnce:Int = 1
    
    var removeAfterTimeOut:Bool = false
    var removeTimeoutRange = 5...15
    
    var respawnRange = 4...12
    var _paused:Bool = false
    var paused:Bool{
        get{ return self._paused }
        set{ self._paused = newValue }
    }
    
    convenience init(gameScene:GameSceneBase){
        self.init(gameScene: gameScene, removeAfterTimeOut: false)
    }
    
    init(gameScene:GameSceneBase, removeAfterTimeOut:Bool = false){
        self.gameScene = gameScene
        self.removeAfterTimeOut = removeAfterTimeOut
        super.init()
    }
    
    func startPickupManager(){
        for i in 0..<self.pickupsAtOnce{
            self.gameScene.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval((i > 0 ? self.respawnRange.randomElement()! : 0))),
                SKAction.run {
                    self.addPickupToScene()//s.addPickupToScene(newPickup: self.getPickup()!)
                }
            ]))
        }
    }
    
    
    func getPickup()->BasePickupNode?{
        preconditionFailure("This method must be overridden") 
    }
    
    func addPickupToScene(newPickup:BasePickupNode){
        self.pickupsOnScene += 1
        self.generatedPickups += 1
        self.pickups.append(newPickup)
        self.gameScene.addChild(newPickup)
        newPickup.genNewPos()
        newPickup.zPosition = 10001
        if(self.removeAfterTimeOut){
            newPickup.startTimeout()
        }
    }
    
    func addPickupToScene(){
        if(self.pickupsOnScene < self.pickupsAtOnce && !self.paused){
            self.addPickupToScene(newPickup: self.getPickup()!)
        }
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
