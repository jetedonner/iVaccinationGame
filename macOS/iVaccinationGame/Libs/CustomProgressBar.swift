//
//  CustomProgressBar.swift
//  CustomProgressBar
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit

class CustomProgressBar: SKCropNode {
    override init() {
        super.init()
        self.maskNode = SKSpriteNode(color: SKColor.white, size: CGSize(width: 300, height: 20))
        let sprite = SKSpriteNode(imageNamed: "progressBarImage")
        self.addChild(sprite)
        sprite.anchorPoint = CGPoint(x: 1.0, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProgress(_ progress: CGFloat) {
        self.maskNode!.xScale = progress
    }
}
