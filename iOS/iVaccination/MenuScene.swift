//
//  MenuScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class MenuScene: MenuSceneBase {
    
    override func touchOrClick(pos: CGPoint) {
        if let menuScene = (self.scene as? MenuScene){
            
            let node = self.atPoint(pos)
            
            if(node == self.lblMap){
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).loadMap()
                }
            }
        }
    }
}
