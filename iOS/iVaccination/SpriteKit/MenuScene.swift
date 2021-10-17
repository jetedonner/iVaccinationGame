//
//  MenuScene.swift
//  iVaccination
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit
import UIKit

class MenuScene: MenuSceneBase {
    
    override func touchOrClick(pos: CGPoint, viewController: IViewController) {
        super.touchOrClick(pos: pos, viewController: viewController)
        
        if(node == self.lblSettings){
            if let url = URL(string:UIApplication.openSettingsURLString){
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }else if(node == self.lblExit){
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        }
    }
}
