//
//  MenuScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class DifficultyScene: DifficultySceneBase {
    
    override func touchOrClick(pos: CGPoint) {
        if let menuScene = (self.scene as? MenuScene){
            
            let node = self.atPoint(pos)
            
            if(node == lblEasy){
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).loadGameScene(difficulty: .easy, level: self.selLevel)
                }
//                if let viewCtrl = self.view?.window?.contentViewController{
//                    (viewCtrl as! ViewController).loadGameScene(difficulty: .easy, level: self.selLevel)
//                }
            }else if(node == lblMedium){
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).loadGameScene(difficulty: .medium, level: self.selLevel)
                }
//                if let viewCtrl = self.view?.window?.contentViewController{
//                    (viewCtrl as! ViewController).loadGameScene(difficulty: .medium, level: self.selLevel)
//                }
            }else if(node == lblHard){
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).loadGameScene(difficulty: .hard, level: self.selLevel)
                }
//                if let viewCtrl = self.view?.window?.contentViewController{
//                    (viewCtrl as! ViewController).loadGameScene(difficulty: .hard, level: self.selLevel)
//                }
            }else if(node == lblNightmare){
                if let viewCtrl = self.view?.window?.rootViewController{
                    (viewCtrl as! GameViewController).loadGameScene(difficulty: .nightmare, level: self.selLevel)
                }
//                if let viewCtrl = self.view?.window?.contentViewController{
//                    (viewCtrl as! ViewController).loadGameScene(difficulty: .nightmare, level: self.selLevel)
//                }
            }
        }
    }
}
