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
        if(self.selNode == self.imgBack){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadMenuScene()
            }
        }else if(self.selNode == self.posMeadow){
            print("Meadow SELECTED")
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadDifficultyScene(level: .Meadow)
            }
        }else if(self.selNode == self.posCitySkyline){
            print("CitySkyline SELECTED")
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadDifficultyScene(level: .CitySkyline)
            }
        }
    }
        
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
        
        if(node == self.imgBack){
            self.selNode = node
            self.imgBack.texture = self.textBackArrowSel
        }else if(node == self.posMeadow){
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
        }else if(node == self.posCitySkyline){
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
        }else{
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
        }
    }
}
