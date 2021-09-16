//
//  SoundManager.swift
//  SoundManager
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit
import AVFoundation

//AVAudioPlayer

class SoundManager{
    
    static let BASE_MEDIA_DIR:String = "Media.scnassets/"
    
    static func getRandomEatSound()->String{
        let eatSounds:[String] = [BASE_MEDIA_DIR + "eat_crunch_1.mp3", BASE_MEDIA_DIR + "eat_crunch_2.mp3"]
        return eatSounds.randomElement()!
    }
    
    static func getBackgroundAudioNode()->SKAudioNode{
        let backgroundSound:SKAudioNode = SKAudioNode(fileNamed: BASE_MEDIA_DIR + "Possession-HumansWin.mp3")
//        backgroundSound.avAudioNode.vol
        return backgroundSound
//        self.addChild(backgroundSound)
    }
    
    static func playSound()->SKAction{
        //  Converted to Swift 5.5 by Swiftify v5.5.22923 - https://swiftify.com/
//        var error: Error?
        let soundURL = Bundle.main.url(forResource: BASE_MEDIA_DIR + "Possession-HumansWin", withExtension: "mp3")
        var player: AVAudioPlayer? = nil
        do {
            if let soundURL = soundURL {
                player = try AVAudioPlayer(contentsOf: soundURL)
            }
        } catch {
        }
        player?.volume = 100
        player?.prepareToPlay()

        let playAction = SKAction.run({
            player?.play()
        })
//        let waitAction = SKAction.wait(forDuration: TimeInterval(player?.duration + 1))
//        let sequence = SKAction.sequence([playAction, waitAction])
        return playAction
    }
}
