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
    }
    
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self.sceneNode)
        if let viewCtrl = self.view?.window?.contentViewController{
            _ = self.touchOrClick(pos: location, viewController: (viewCtrl as! ViewController))
        }
    }
}
