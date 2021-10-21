//
//  SkMessageBoxNode.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 17.10.21.
//

import Foundation
import SpriteKit

class SkMessageBoxNode: SKNode {
    
    let lblTitle:SKLabelNode = SKLabelNode()
    let lblMsg:SKLabelNode = SKLabelNode()
    let imgMsg:SKSpriteNode = SKSpriteNode()
    
    let shpBorder:SKShapeNode
    
    init(size:CGSize) {
        self.shpBorder = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height), cornerRadius: 10)
        super.init()
        self.lblTitle.fontSize = 20.0
        self.lblTitle.fontName = "Helvetica Neue Bold"
        self.lblTitle.fontColor = .white
        self.shpBorder.addChild(self.lblTitle)
        
        self.lblMsg.fontSize = 14.0
        self.lblMsg.fontName = "Helvetica Neue Normal"
        self.lblMsg.fontColor = .white
        self.lblMsg.numberOfLines = 3
        self.lblMsg.horizontalAlignmentMode = .center
        self.shpBorder.addChild(self.lblMsg)
        
        self.shpBorder.strokeColor = .purple
        self.shpBorder.lineWidth = 3.0
        
        let bgColor:SKColor = SKColor(red: 0, green: 137 / 255, blue: 103 / 255, alpha: 0.65)
        self.shpBorder.fillColor = bgColor //.withAlphaComponent(0.35)
        self.addChild(self.shpBorder)

        let pos2:CGPoint = CGPoint(x: (self.shpBorder.frame.width / 2) - (self.lblTitle.frame.width / 2) , y: (self.shpBorder.frame.height) - 40)
        self.lblTitle.position = pos2
        
        let pos3:CGPoint = CGPoint(x: (self.shpBorder.frame.width / 2) - (self.lblMsg.frame.width / 2) , y: (self.shpBorder.frame.height) - 60 - (self.lblMsg.frame.height / 2))
        self.lblMsg.position = pos3
        
        self.imgMsg.texture = SKTexture(imageNamed: "CertificatePickup")
        self.imgMsg.size = CGSize(width: 64, height: 64)
        self.imgMsg.position = CGPoint(x: 32 + 20, y: (size.height / 2))
        self.addChild(self.imgMsg)
        
        self.zPosition = 10000000
        self.alpha = 0.0
    }
    
    func showMessage(title:String, msg:String, imgNamed:String = "CertificatePickup", timeout:TimeInterval = GameVars.MSGBOX_TIME, completion:(() -> Void)? = nil){
        self.lblTitle.text = title
        
        
        let attrString = NSMutableAttributedString(string: msg)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: msg.count)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttributes([NSAttributedString.Key.foregroundColor : SKColor.white, NSAttributedString.Key.font : NSFont.systemFont(ofSize: 14)], range: range)
        self.lblMsg.attributedText = attrString
        
        self.imgMsg.texture = SKTexture(imageNamed: imgNamed)
        
        let pos3:CGPoint = CGPoint(x: (self.shpBorder.frame.width / 2), y: (self.shpBorder.frame.height) - 65 - (self.lblMsg.frame.height / 2))
        self.lblMsg.position = pos3
        
        let pos:CGPoint = CGPoint(x: 0 - (self.shpBorder.frame.width / 2) , y: ((self.parent?.frame.height)! / 2) - 150)
        
        self.position = pos
        
        if(completion != nil){
            self.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.25), SKAction.wait(forDuration: timeout), SKAction.fadeOut(withDuration: 0.5)]), completion: completion!)
        }else{
            self.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.25), SKAction.wait(forDuration: timeout), SKAction.fadeOut(withDuration: 0.5)]))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
