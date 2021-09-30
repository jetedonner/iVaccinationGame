//
//  SkViewExt.swift
//  SkViewExt
//
//  Created by Kim David Hauser on 17.09.21.
//

import Foundation
import SpriteKit

extension SKView {
    
    open override func mouseDown(with event: NSEvent) {
        if let menuScene = (self.scene as? MenuScene){
            menuScene.mouseDown(with: event)
            return
        }else if let menuDifScene = (self.scene as? DifficultyScene){
            menuDifScene.mouseDown(with: event)
            return
        }else if let descScene = (self.scene as? DescriptionScene){
            descScene.mouseDown(with: event)
            return
        }else if let mapScene = (self.scene as? MapScene){
            mapScene.mouseDown(with: event)
            return
        }else if let creditsScene = (self.scene as? CreditsScene){
            creditsScene.mouseDown(with: event)
            return
        }else if let gameScene = (self.scene as? GameScene){
            super.mouseDown(with: event)
            let location = event.location(in: gameScene.bg!)
            gameScene.clickedAtPoint(point: location)
        }
    }
}

extension SKView {
    
    override open func resetCursorRects() {
        if let gameScene = (self.scene as? GameScene){
            gameScene.imgCH = self.resize(image: NSImage(named:NSImage.Name("CH_first_red.png"))!, w: 64, h: 64)
            let image = gameScene.imgCH
            let spot = NSPoint(x: 32, y: 32)
            let customCursor = NSCursor(image: image!, hotSpot: spot)
            addCursorRect(visibleRect, cursor:customCursor)
        }
    }

    func resize(image: NSImage, w: Int, h: Int) -> NSImage {
        let destSize = NSMakeSize(CGFloat(w), CGFloat(h))
        let newImage = NSImage(size: destSize)
        newImage.lockFocus()
        image.draw(in: NSMakeRect(0, 0, destSize.width, destSize.height), from: NSMakeRect(0, 0, image.size.width, image.size.height), operation: NSCompositingOperation.sourceOver, fraction: CGFloat(1))
        newImage.unlockFocus()
        newImage.size = destSize
        return NSImage(data: newImage.tiffRepresentation!)!
    }
}
