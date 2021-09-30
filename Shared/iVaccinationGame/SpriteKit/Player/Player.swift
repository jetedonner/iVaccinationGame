//
//  Player.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 30.09.21.
//

import Foundation
import SpriteKit

class Player{
    
    var vaccineArsenal:VaccineArsenal = VaccineArsenal()
    var hasSyringes:Bool{
        get{ return self.vaccineArsenal.vaccinesInArsenal[.Perofixa]! > 0 }
    }
    
    var syringesCount:Int{
        get{ return self.vaccineArsenal.vaccinesInArsenal[.Perofixa]!}
    }
    
    var bites:Int = 0
    var health:CGFloat = 100.0
    var score:Int = 0
    
    var certsPickedUp:Int = 0
    var medKitsPickedUp:Int = 0
    
    init(){
        
    }
    
    func resetPlayer(){
        self.bites = 0
        self.health = 100.0
        self.certsPickedUp = 0
        self.medKitsPickedUp = 0
    }
    
    func addScore(score:Int){
        self.score += score
//        self.lblScore?.text = self.score.description + " Points"
//        self.lblScore?.run(SKAction.scale(by: 1.5, duration: 0.35),completion: {
//            self.lblScore?.xScale = 1.0
//            self.lblScore?.yScale = 1.0
//        })
    }
    
    func shootSyringe(vaccineType:VaccineType = .Perofixa){
        self.vaccineArsenal.vaccinesInArsenal[vaccineType]! -= 1
    }
    
    func pickedUpCert(){
        self.certsPickedUp += 1
    }
    
    func pickedUpMedKit(healValue:CGFloat){
        self.medKitsPickedUp += 1
        self.health += healValue
    }
    
    func zombieBite(damage:CGFloat)->Bool{
        self.health -= damage
        self.bites += 1
        return self.health <= 0.0
    }
}
