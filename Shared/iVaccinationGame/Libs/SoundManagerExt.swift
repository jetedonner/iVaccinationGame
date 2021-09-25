//
//  SoundManagerExt.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import SpriteKit
import AVFoundation

//class SKActionSound:SKAction {
//        
//    
//}
//    
//public extension SKAction {
//    
//    class func playSoundFileNamed(fileName: String, atVolume: CGFloat, waitForCompletion: Bool) -> SKAction {
//        
//        let filename:NSString = NSString(string: fileName)
////        let pathExtention = filename.pathExtension
////        let pathPrefix = filename.deletingPathExtension
////
////        let completeURL:URL = URL(fileURLWithPath: fileName)
//        
//        let nameOnly = filename.deletingPathExtension //completeURL.deletingPathExtension().s fileName.stringByDeletingPathExtension
//        let fileExt = filename.pathExtension // fileName.pathExtension
//        
//        let soundPath:URL = Bundle.main.url(forResource: nameOnly, withExtension: fileExt)!
//        
////        var error:NSError?
//        do{
//            let player: AVAudioPlayer = try AVAudioPlayer(contentsOf: soundPath)//, error: &error)
//            
//            player.volume = Float(SoundManager.masterVolume)
//            player.play()
//            
//                let playAction: SKAction = SKAction.run { () -> Void in
//                player.play()
//            }
//            
//            if(waitForCompletion){
//                let waitAction = SKAction.wait(forDuration: player.duration)
//                let groupAction: SKAction = SKAction.group([playAction, waitAction])
//                return groupAction
//            }
//            
//            return playAction
//        }catch{
//            return SKAction.wait(forDuration: 0.0)
//        }
//    }
//    
//}
