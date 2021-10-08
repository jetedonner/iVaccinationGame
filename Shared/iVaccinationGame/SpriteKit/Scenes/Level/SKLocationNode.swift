//
//  SKLocationNode.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 07.10.21.
//

import Foundation
import SpriteKit

class SKLocationNode{
    
    let checkNode:SKSpriteNode
    let imgNode:SKSpriteNode
    var circle:SKShapeNode!
    
    let colorBgRed:SKColor = SKColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.45)
    let colorBgGreen:SKColor = SKColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.45)
    let colorBgBlue:SKColor = SKColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.45)
    
    let textUndone:SKTexture
    let textDone:SKTexture
    
    var _levelDone:Bool!
    var levelDone:Bool{
        get{ return self._levelDone }
        set{
            self._levelDone = newValue
            self.imgColor = newValue
            self.checkNode.isHidden = !newValue
        }
    }
    
    var _imgColor:Bool!
    var imgColor:Bool{
        get{ return self._imgColor }
        set{
            self._imgColor = newValue
            if(newValue){
                self.texture = self.textDone
            }else{
                self.texture = self.textUndone
            }
        }
    }
    
    var _showCircle:Bool!
    var showCircle:Bool{
        get{ return self._showCircle }
        set{
            self._showCircle = newValue
            self.circle.isHidden = !newValue
        }
    }
    
    var _animateCircle:Bool!
    var animateCircle:Bool{
        get{ return self._animateCircle }
        set{
            self._animateCircle = newValue
            self.circle.isPaused = !newValue
            if(!newValue){
                self.circle.removeAllActions()
            }
        }
    }
    
    var _currentLocation:Bool = false
    var currentLocation:Bool{
        set{
            self._currentLocation = newValue
            self.animateCircle = newValue
            if(newValue){
                self.changeColor(newStrokeColor: .black, newFillColor: self.colorBgBlue)
                self.showCircle = true
                self.imgColor = true
            }else{
                self.showCircle = false
            }
        }
        get{
            return self._currentLocation
        }
    }
    
    var texture:SKTexture{
        set{ self.imgNode.texture = newValue }
        get{ return self.imgNode.texture! }
    }
    
    init(imgNode:SKSpriteNode, textUndone:SKTexture, textDone:SKTexture, showCircle:Bool = false){
        self.checkNode = SKSpriteNode(texture: SKTexture(imageNamed: "Check"))
        self.checkNode.size = CGSize(width: 24, height: 24)
        self.checkNode.position.x += 24
        self.checkNode.position.y += 24
        self.checkNode.zPosition = 100
        self.imgNode = imgNode
        self.textUndone = textUndone
        self.textDone = textDone
        self.addCircle()
        self.showCircle = showCircle
        self.imgNode.addChild(self.checkNode)
        self.checkNode.isHidden = true
    }
    
    func changeColor(newStrokeColor:SKColor, newFillColor:SKColor){
        self.circle.strokeColor = newStrokeColor
        self.circle.fillColor = newFillColor
    }
    
    func addCircle(){
        self.circle = SKShapeNode(ellipseOf: CGSize(width: 130, height: 80))
        circle.position = CGPoint(x: 0, y: 0)
        circle.strokeColor = SKColor.black
        circle.glowWidth = 1.0
        let bgColor:SKColor = SKColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.45)
        circle.fillColor = bgColor
        self.imgNode.addChild(circle)
        self.addPulsingAction2Circle()
    }
    
    func addPulsingAction2Circle(){
        circle.run(
            SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.group([
                        SKAction.scale(to: 1.2, duration: 1.0),
                        SKAction.fadeAlpha(to: 0.05, duration: 1.0)
                    ]),
                    SKAction.group([
                        SKAction.scale(to: 1.0, duration: 0.0),
                        SKAction.fadeAlpha(to: 1.0, duration: 0.0)
                    ])
                ])
            )
        )
    }
}
