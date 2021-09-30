//
//  VaccineBase.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 30.09.21.
//

import Foundation
import SpriteKit

struct BaseVaccineNG {
    var name:String = ""
    var healAmount:CGFloat = 0.0
}

protocol BaseVaccine:Hashable{
    var name:String { get set } //= "Base Vaccine"
//    var keyCode:Int = 0
    var healAmount:CGFloat { get set }// = 50.0
    
    /*init(name:String, healAmount:CGFloat) {
        self.name = name
        self.healAmount = healAmount
    }*/
}

//class VaccineBase:Hashable{
//    
//    static func == (lhs: VaccineBase, rhs: VaccineBase) -> Bool {
//        return lhs.name == rhs.name
//    }
//    
//    
//    var name:String = "Base Vaccine"
//    var keyCode:Int = 0
//    var healAmount:CGFloat = 50.0
//    
//    init(name:String, healAmount:CGFloat) {
//        self.name = name
//        self.healAmount = healAmount
//    }
//    
//}
