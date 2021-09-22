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

enum PainSoundLevel:Int{
    case PAIN_100 = 3
    case PAIN_75 = 2
    case PAIN_50 = 1
    case PAIN_25 = 0
}

class SoundManager{
    
    static var masterVolume:CGFloat = 0.75
    
    static let gameoverSound:SKAction = SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "gameOver_voice_v1.mp3", waitForCompletion: true)
    static let bulletImpactSound:SKAction = SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "bulletImpact.mp3", waitForCompletion: true)
    static let unzombiefiedSound:SKAction = SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "telein.mp3", waitForCompletion: false)
    static let syringePickupSound:SKAction = SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "w_pkup.mp3", waitForCompletion: false)
    static let healthPickupSound:SKAction = SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "pickupHealth.mp3", waitForCompletion: true)
    static let shotSound:SKAction = SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "throwing-whip.mp3", waitForCompletion: true)
    
    static let menuHighliteSound:SKAction = SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "Menu1.mp3", waitForCompletion: false)
    
    static var eatSound:SKAction{
        get{ SKAction.playSoundFileNamed(self.getRandomEatSound(), waitForCompletion: false) }
    }
    
    static let painSounds:[SKAction] = [
        SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "pain25_1.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "pain50_1.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "pain75_1.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed(GameVars.BASE_MEDIA_DIR + "pain100_1.mp3", waitForCompletion: false)
    ]

    static func getRandomEatSound()->String{
        let eatSounds:[String] = [GameVars.BASE_MEDIA_DIR + "eat_crunch_1.mp3", GameVars.BASE_MEDIA_DIR + "eat_crunch_2.mp3"]
        return eatSounds.randomElement()!
    }
    
    static func getBackgroundAudioNode()->SKAudioNode{
        let backgroundSound:SKAudioNode = SKAudioNode(fileNamed: GameVars.BASE_MEDIA_DIR + "Possession-HumansWin.mp3")
        return backgroundSound
    }
    
    static func playAudio(audioName:String){
        let path = Bundle.main.path(forResource: GameVars.BASE_MEDIA_DIR + audioName + ".mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            let bombSoundEffect:AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect.volume = 1.0
            bombSoundEffect.prepareToPlay()
            bombSoundEffect.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    static func playSound()->SKAction{
        let soundURL = Bundle.main.url(forResource: GameVars.BASE_MEDIA_DIR + "Possession-HumansWin", withExtension: "mp3")
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
        return playAction
    }
}
