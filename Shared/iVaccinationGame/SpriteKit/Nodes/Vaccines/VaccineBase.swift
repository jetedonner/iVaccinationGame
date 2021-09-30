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
    var name:String { get set }
    var healAmount:CGFloat { get set }// = 50.0
}
