//
//  MapScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class MapScene: MapSceneBase {
        
    var tooltipScore:Int = 0
    let dict = ICloudStorageHelper.score
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        if(self.selNode != self.contTooltip && self.selNode != self.lblTooltip){
            self.oldSelNode = self.selNode
        }
        let node = self.scene!.atPoint(location)
        if(node != self.contTooltip && node != self.lblTooltip){
            if(self.oldSelNode != node){
                self.fadeOutTooltip()
                self.oldSelNode = node
            }
        }
        
        if(node == self.imgBack){
            self.selNode = node
            self.imgBack.texture = self.textBackArrowSel
        }else if(node == self.posMeadow){
            self.tooltipScore = (dict[Level.Meadow.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "Meadow (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posCitySkyline){
            self.tooltipScore = (dict[Level.CitySkyline.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "City skyline (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posCityStreet){
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrow
//            self.showTooltip(msg: "City street", pos: location)
            self.tooltipScore = (dict[Level.CityStreet.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "City street (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posWallway){
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrow
//            self.showTooltip(msg: "Wallway", pos: location)
            self.tooltipScore = (dict[Level.Wallway.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "Wallway (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posBackStreet){
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrow
//            self.showTooltip(msg: "Back street", pos: location)
            self.tooltipScore = (dict[Level.CityNight.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "Back street (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posJapanStreet){
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrow
//            self.showTooltip(msg: "Japan street", pos: location)
            self.tooltipScore = (dict[Level.CityJapan.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "Japan street (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posScarryStreet){
//            self.selNode = node
//            self.imgBack.texture = self.textBackArrow
//            self.showTooltip(msg: "Scarry street", pos: location)
            self.tooltipScore = (dict[Level.ScarryStreet.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "Scarry street (\(self.tooltipScore) Points)", pos: location)
        }else{
            if(node != self.contTooltip && node != self.lblTooltip){
                self.selNode = node
                self.imgBack.texture = self.textBackArrow
            }
        }
//        print("self.selNode: \(self.selNode)")
    }
}
