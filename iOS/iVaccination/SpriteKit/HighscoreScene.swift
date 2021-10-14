//
//  MenuScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit

class HighscoreScene: HighscoreSceneBase {
 
    // Class inherited for overwritting and accessing base class
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
    }
    
    func enableScrollingList(view:SKView){
        self.scrollingList.enableScrolling(on: view)
//        self.scrollingList.scrollToTop()
    }
}
