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
        if let scene = (self.scene as? MenuScene) ??
            (self.scene as? WelcomeScene) ??
            (self.scene as? DifficultyScene) ??
            (self.scene as? DescriptionScene) ??
            (self.scene as? MapScene) ??
            (self.scene as? CreditsScene){
            
            scene.mouseDown(with: event)
            return
        }
        
        if let gameScene = (self.scene as? GameScene){
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
