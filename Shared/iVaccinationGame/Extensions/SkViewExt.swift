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
        self.showDbgInfos()
    }
    
    func showDbgInfos(show:Bool? = nil){
        if let show = show{
            self.showsFPS = show
            self.showsNodeCount = show
        }else{
//            if(UserDefaultsHelper.devMode){
            self.showsFPS = UserDefaultsHelper.devMode
            self.showsNodeCount = UserDefaultsHelper.devMode
//            }
        }
    }
}
