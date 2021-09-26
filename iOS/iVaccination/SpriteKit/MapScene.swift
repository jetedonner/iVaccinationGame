//
//  MapScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class MapScene: MapSceneBase {

    override func touchOrClick(pos: CGPoint) {
        if let mapScene = (self.scene as? MapScene){

            let node = self.atPoint(pos)

            if(node == self.posMeadow){
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).loadGameScene()
                }
            }else if(node == self.imgBack){
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).loadMenuScene()
                }
            }
        }
    }
}
