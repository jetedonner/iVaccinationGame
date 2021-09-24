//
//  GameCenterHelper.swift
//  Suake3D
//
//  Created by Kim David Hauser on 06.04.21.
//

import Foundation
import GameKit

protocol GameCenterHelperDelegate: AnyObject {
    func startMatch(match: GKMatch)
}

class GameCenterHelper: NSObject {
    
    private let leaderboardID = "grp.ch.kimhauser.swift.ivaccination"
    
    private var leaderboard:GKLeaderboard = GKLeaderboard()
    
    let inviteMessage:String = "Hey there join me for a iVaccination fight!"
    var currentVC: GKMatchmakerViewController?
    
    var delegate:GameCenterHelperDelegate?
    
    var observerObj:NSKeyValueObservation?
    
    #if os(macOS)
    var viewController: NSViewController?
    init(vc:ViewController) {
        super.init()
        self.viewController = vc
    }
    #else
    var viewController: UIViewController?
    init(vc:GameViewController) {
        super.init()
        self.viewController = vc
    }
    #endif
    
    func loadGameCenter(){
        if(UserDefaultsHelper.useGameCenter){
            self.authenticate()
        }
    }
    
    func authenticate(){
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            NotificationCenter.default.post(name: Notification.Name.authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)

            if GKLocalPlayer.local.isAuthenticated {
                GKLocalPlayer.local.register(self)
                GKAccessPoint.shared.parentWindow = self.viewController?.view.window
                GKAccessPoint.shared.location = .bottomLeading
                GKAccessPoint.shared.showHighlights = true
                GKAccessPoint.shared.showHighlights = true
                GKAccessPoint.shared.isActive = GKLocalPlayer.local.isAuthenticated

                let observation2 = GKAccessPoint.shared.observe(
                         \.isPresentingGameCenter
                  ) { [weak self] _,_ in
                      #if os(macOS)
                      if(GKAccessPoint.shared.isPresentingGameCenter){
                          if((self!.viewController as! ViewController).gameSceneObj.gameRunning){
                              (self!.viewController as! ViewController).gameSceneObj.setGamePaused(isPaused: true)
                          }
                      }else{
                          if((self!.viewController as! ViewController).gameSceneObj.gamePaused){
                              (self!.viewController as! ViewController).gameSceneObj.setGamePaused(isPaused: false)
                          }
                          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
                              (self!.viewController as! ViewController).gameSceneObj.view?.resetCursorRects()
                          })
                      }
                      #else
                      if(GKAccessPoint.shared.isPresentingGameCenter){
                          if((self!.viewController as! GameViewController).gameSceneObj.gameRunning){
                              (self!.viewController as! GameViewController).gameSceneObj.setGamePaused(isPaused: true)
                          }
                      }else{
                          if((self!.viewController as! GameViewController).gameSceneObj.gamePaused){
                              (self!.viewController as! GameViewController).gameSceneObj.setGamePaused(isPaused: false)
                          }
                      }
                      #endif
                }
                self.observerObj = observation2
            } else if let vc = gcAuthVC {
                #if os(macOS)
                    self.viewController?.presentAsModalWindow(vc)
                #else
                    self.viewController?.present(vc, animated: true, completion: {
                      
                    })
                #endif
            } else {
//            print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
            }
        }
    }
    
    func showDashboard(){
        let viewController = GKGameCenterViewController(state: .dashboard)
        viewController.gameCenterDelegate = self
        #if os(macOS)
            self.viewController?.presentAsModalWindow(viewController)
        #else
            self.viewController?.present(viewController, animated: true, completion: {
                
            })
        #endif

    }
    
    func updateScore(with value: Int) {
        
        GKLeaderboard.submitScore(123456, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [self.leaderboardID],  completionHandler: {error in
            print("Error uploading score to Game Center leaderboard: \(String(describing: error))")
        })
        
//        let score = GKScore(leaderboardIdentifier: leaderboardID)
//        score.value = Int64(value)
//        let scr = GKLeaderboardScore()
//        scr.leaderboardID = self.leaderboardID
//        scr.player = GKLocalPlayer.local
//        scr.value = value
//        scr.context = 1586145789
//        GKScore.report([scr], withEligibleChallenges: [], withCompletionHandler: { error in
//            let res = error
//            _ = res
//        })
    }
}



extension GameCenterHelper: GKGameCenterControllerDelegate {
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        #if os(macOS)
        gameCenterViewController.dismiss(true)
        if((self.viewController as! ViewController).gameSceneObj.isPaused){
            (self.viewController as! ViewController).gameSceneObj.setGamePaused(isPaused: false)
        }
        #else
        gameCenterViewController.dismiss(animated: true)
        #endif
    }
}

extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}
