//
//  ArrayExt.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 30.09.21.
//

import Foundation

extension Array{
    
    func getRandom()->Element{
        var g = SystemRandomNumberGenerator()
        return self.randomElement(using: &g)!
    }
    
}
