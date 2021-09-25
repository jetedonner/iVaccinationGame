//
//  BaseSKSceneMacOS.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

extension BaseSKScene{
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
//        let location = event.location(in: self.sceneNode)
//        let node = self.scene!.atPoint(location)
////        var newSelNode:SKNode?
//
//        if(node == self.imgBack){
////            newSelNode = self.imgBack
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrowSel
//        }else if(node == self.posMeadow){
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrow
//        }else if(node == self.posCitySkyline){
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrow
//        }else{
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrow
//        }
    }
    
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self.sceneNode)
        self.touchOrClick(pos: location)
    }
}
