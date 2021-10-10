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
    var _currentVaccine:VaccineType = .Perofixa
    var currentVaccine:VaccineType{
        get{ return self._currentVaccine }
        set{ self._currentVaccine = newValue }
    }
    
    init(){
        self.vaccinesInArsenal[.Perofixa] = 2
        self.currentVaccine = self.vaccinesInArsenal.first!.key
    }

    func addVaccine(accineType:VaccineType, ammount:Int){
        if(self.vaccinesInArsenal[accineType] != nil){
            self.vaccinesInArsenal[accineType]! += ammount
        }else{
            self.vaccinesInArsenal[accineType] = ammount
        }
    }
}
