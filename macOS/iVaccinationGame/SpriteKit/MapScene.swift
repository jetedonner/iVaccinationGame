//
//  MapScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class MapScene: MapSceneBase {
        
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
