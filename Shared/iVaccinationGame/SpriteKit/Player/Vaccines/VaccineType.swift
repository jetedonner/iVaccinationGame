//
//  VaccineType.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 30.09.21.
//

import Foundation

enum VaccineType:String{
    case Perofixa = "Perofixa"
    case JnJ = "Jill & Jasmine"
    
    var pickupMultiplyer:Int{
        get{
            switch self {
            case .Perofixa:
                return 2
            case .JnJ:
                return 1
            }
        }
    }
}
