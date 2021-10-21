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
    
    override func keyDown(with event: NSEvent) {
//        self.keyboardHandler.keyDown(with: event)
        if(event.keyCode == KeyCode.KEY_M.rawValue){
            if(VersionHelper.getDevMode()){
                self.moveDoctorNodeToNextLevel()
            }
        }else if(event.keyCode == KeyCode.KEY_ESC.rawValue){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadMenuScene()
            }
        }
    }
    
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
        }else if(node == self.posMeadow && UserDefaultsHelper.levelID.rawValue >= Level.Meadow.rawValue){
            self.tooltipScore = (dict[Level.Meadow.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "Meadow (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posCitySkyline && UserDefaultsHelper.levelID.rawValue >= Level.CitySkyline.rawValue){
            self.tooltipScore = (dict[Level.CitySkyline.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "City skyline (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posCityStreet && UserDefaultsHelper.levelID.rawValue >= Level.CityStreet.rawValue){
            self.tooltipScore = (dict[Level.CityStreet.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "City street (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posWallway && UserDefaultsHelper.levelID.rawValue >= Level.Wallway.rawValue){
            self.tooltipScore = (dict[Level.Wallway.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "Wallway (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posCityNight && UserDefaultsHelper.levelID.rawValue >= Level.CityNight.rawValue){
            self.tooltipScore = (dict[Level.CityNight.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "City night (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posJapanStreet && UserDefaultsHelper.levelID.rawValue >= Level.CityJapan.rawValue){
            self.tooltipScore = (dict[Level.CityJapan.getDesc()] ?? 0)
            self.selNode = node
            self.imgBack.texture = self.textBackArrow
            self.showTooltip(msg: "Japan street (\(self.tooltipScore) Points)", pos: location)
        }else if(node == self.posScarryStreet && UserDefaultsHelper.levelID.rawValue >= Level.ScarryStreet.rawValue){
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
    }
}
