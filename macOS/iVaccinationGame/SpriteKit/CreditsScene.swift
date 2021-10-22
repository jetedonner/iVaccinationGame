//
//  DescriptionScene.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit


// sex in the city
// hellllllooooo friends ... how is your being tonight?
// Another show is almost over .. and you didn't even get a single chance to rest your case
// What was the topic again??? Ah yeah .... !!!
// So i think that was enough for the moment ... will see u tomorrow guys .... bye bye ... 

//protocol EscKeyBack2Menu : BaseSKScene{
//    var view:BaseSKScene{get}
//    func keyDown(with event: NSEvent)
//}
////
//extension EscKeyBack2Menu  {
//
////    var view: BaseSKScene {
////        get{ return super.view }
////    }
//
//    func keyDown(with event: NSEvent) {
////        self.keyboardHandler.keyDown(with: event)
//        if(event.keyCode == KeyCode.KEY_ESC.rawValue){
//            if let viewCtrl = self.view?.window?.contentViewController{
//                (viewCtrl as! ViewController).loadMenuScene()
//            }
//        }
//    }
//}
////
//extension CreditsScene: EscKeyBack2Menu {
//
//
//
//}

//extension UIImageView: Animations {}



class CreditsScene: CreditsSceneBase {
    
    var colorAccent:SKColor = SKColor.init(named: "mainAccent")!
    
    override func keyDown(with event: NSEvent) {
//        self.keyboardHandler.keyDown(with: event)
        if(event.keyCode == KeyCode.KEY_ESC.rawValue){
            if let viewCtrl = self.view?.window?.contentViewController{
                (viewCtrl as! ViewController).loadMenuScene()
            }
        }
    }
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let location = event.location(in: self.sceneNode)
        let node = self.scene!.atPoint(location)
        var newSelNode:SKNode?

        if(node == self.lblContinue){
            newSelNode = self.lblContinue
            self.lblContinue?.fontColor = self.colorAccent
        }else{
            newSelNode = self.bg
            self.lblContinue?.fontColor = .white
//            return
        }

        if(newSelNode != self.selNode && newSelNode == self.lblContinue){
            self.selNode = newSelNode
            SoundManager.shared.playSound(sound: .menuHighlite)
        }else{
            self.selNode = newSelNode
        }
    }
}
