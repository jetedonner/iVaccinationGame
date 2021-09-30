//
//  SkViewExt.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 30.09.21.
//

import Foundation
import SpriteKit

extension SKView {
    
    func presentSceneNG(_ scene: SKScene?){
        self.presentScene(scene)
        self.ignoresSiblingOrder = true
        
        if(UserDefaultsHelper.devMode){
            self.showsFPS = true
            self.showsNodeCount = true
            self.showsPhysics = true
        }
    }
}
