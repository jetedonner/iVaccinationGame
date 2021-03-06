//
//  SoundManagerNG.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 25.09.21.
//

import Foundation
import AVKit

enum Sounds:String{
    
    case gameover = "gameOver_voice_v1.mp3"
    case bulletImpact = "bulletImpact.mp3"
    case unzombiefiedSound = "telein.mp3"
    case syringePickup = "w_pkup.mp3"
    case healthPickup = "pickupHealth.mp3"
    case shot = "throwing-whip.mp3"
    case menuHighlite = "Menu1.mp3"
    case impact1 = "bulletimpact-metal1.mp3"
    case impact2 = "bulletimpact-metal2.mp3"
    case impact3 = "bulletimpact-metal3.mp3"
    case pain25 = "pain25_1.mp3"
    case pain50 = "pain50_1.mp3"
    case pain75 = "pain75_1.mp3"
    case pain100 = "pain100_1.mp3"
    case eat1 = "eat_crunch_1.mp3"
    case eat2 = "eat_crunch_2.mp3"
    case certPickup = "paperturn_boosted.mp3"
    case youWin = "youWin.mp3"
    case applause = "auditorium-moderate-applause-and-cheering.mp3"
}

class SoundManager:NSObject, AVAudioPlayerDelegate{
    
    static var shared:SoundManager = SoundManager()
    
    var masterVolume:CGFloat = 0.75
    var player:AVAudioPlayer!
    var songPlayer:AVAudioPlayer?
    var players:[AVAudioPlayer] = []
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.players = self.players.filter({$0 != player})
    }
    
    func playSound(sounds: [Sounds], atVolume: CGFloat = CGFloat(UserDefaultsHelper.volume)){
        self.playSound(sound: sounds.randomElement()!, atVolume: atVolume)
    }
    
    func playSound(sound: Sounds, atVolume: CGFloat = CGFloat(UserDefaultsHelper.volume)){
        
        if(!UserDefaultsHelper.playSounds){
            return
        }
        
        let filename:NSString = NSString(string: GameVars.BASE_MEDIA_DIR + sound.rawValue)
        let nameOnly = filename.deletingPathExtension
        let fileExt = filename.pathExtension
        let soundPath:URL = Bundle.main.url(forResource: nameOnly, withExtension: fileExt)!
        
        do{
            let newPlayer:AVAudioPlayer = try AVAudioPlayer(contentsOf: soundPath, fileTypeHint: AVFileType.mp3.rawValue)
            newPlayer.volume = Float(atVolume)
            newPlayer.prepareToPlay()
            newPlayer.play()
            newPlayer.delegate = self
            self.players.append(newPlayer)
        }catch{
            print("Error while playing music: \(error.localizedDescription)")
        }
    }
    
    func playBGSound(){
        if let path = Bundle.main.path(forResource: GameVars.BASE_MEDIA_DIR + "Possession-HumansWin", ofType: "mp3") {
            let filePath = NSURL(fileURLWithPath:path)
            self.songPlayer = try! AVAudioPlayer.init(contentsOf: filePath as URL)
            self.songPlayer?.numberOfLoops = -1
            self.songPlayer?.prepareToPlay()
            self.songPlayer?.volume = UserDefaultsHelper.volume
            if(UserDefaultsHelper.playSounds && UserDefaultsHelper.playBGMusic){
                self.songPlayer?.play()
            }
        }
    }
    
    func stopBGSound(pause:Bool = false){
        if(UserDefaultsHelper.playSounds && UserDefaultsHelper.playBGMusic){
            if(!pause){
                self.songPlayer?.stop()
            }else{
                self.songPlayer?.pause()
            }
        }
    }
}
