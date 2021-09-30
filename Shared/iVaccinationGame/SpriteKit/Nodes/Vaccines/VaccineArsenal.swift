//
//  VaccineArsenal.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 30.09.21.
//

import Foundation
import SpriteKit

class VaccineArsenal{
    
    var vaccinesInArsenal:[VaccineType:Int] = [:]

    init(){
        self.vaccinesInArsenal[.Perofixa] = 2
    }

    func addVaccine(accineType:VaccineType, ammount:Int){
        if(self.vaccinesInArsenal[accineType] != nil){
            self.vaccinesInArsenal[accineType]! += ammount
        }else{
            self.vaccinesInArsenal[accineType] = ammount
        }
    }
}
