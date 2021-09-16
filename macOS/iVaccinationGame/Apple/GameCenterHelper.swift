//
//  GameCenterHelper.swift
//  Suake3D
//
//  Created by Kim David Hauser on 06.04.21.
//

import Foundation
import GameKit

protocol GameCenterHelperDelegate: AnyObject {
    
//    func didChangeAuthStatus(isAuthenticated: Bool)
    func startMatch(match: GKMatch)
//    func presentGameCenterAuth(viewController: NSViewController?)
//    func presentMatchmaking(viewController: NSViewController?)
//    func presentGame(match: GKMatch)
    
    // func startGame
    // - func initLevel
    // - func initMatch
    
    // func turnDirChanged
    
    // func endGame
}

class GameCenterHelper: NSObject {
    
    private let leaderboardID = "grp.ch.kimhauser.swift.ivaccination"
    
    let inviteMessage:String = "Hey there join me for a iVaccination fight!"
    var currentVC: GKMatchmakerViewController?
    
    var viewController: NSViewController?
    var delegate:GameCenterHelperDelegate?
    
//    let matchMakerHelper:MatchMakerHelper
    
//    var isMultiplayerGameRunning:Bool{
//        get{ return self.matchMakerHelper.isMultiplayerGameRunning }
//        set{ self.matchMakerHelper.isMultiplayerGameRunning = newValue }
//    }
    
    init(vc:ViewController/*game:GameController*/) {
        super.init()
        self.viewController = vc
//        self.matchMakerHelper = MatchMakerHelper(game: game)
        
//        super.init(game: game)
    }
    
    func loadGameCenter(){
//        self.viewController = (self.game.scnView as! GameViewMacOS).viewController
//        self.delegate = game
//
//
//        if(SuakeVars.useGameCenter){
            self.authenticate()
//        }
    }
    
    func authenticate(){
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
          NotificationCenter.default.post(name: Notification.Name.authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)

          if GKLocalPlayer.local.isAuthenticated {
            
//            print("Authenticated to Game Center!")
            GKLocalPlayer.local.register(self)
            GKAccessPoint.shared.parentWindow = self.viewController?.view.window
            GKAccessPoint.shared.location = .bottomLeading
            GKAccessPoint.shared.showHighlights = true
            GKAccessPoint.shared.isActive = GKLocalPlayer.local.isAuthenticated
          } else if let vc = gcAuthVC {
            self.viewController?.presentAsModalWindow(vc)//(vc, animator: NSViewControllerPresentationAnimator).present(vc, animated: true)
          }
          else {
//            print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
          }
        }
    }
    
    func showDashboard(){
        let viewController = GKGameCenterViewController(state: .dashboard)
        viewController.gameCenterDelegate = self
        self.viewController?.presentAsModalWindow(viewController)
    }
    
    func updateScore(with value: Int) {
//        let board = GKLeaderboard()
//        board.baseLeaderboardID = leaderboardID
        GKLeaderboard.submitScore(value, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [leaderboardID] , completionHandler: { result in
            var res = result
            var res2 = result
        })
//        let lb:GKLeaderboard = GKLeaderboard(players: [GKLocalPlayer.local])
////        lb.baseLeaderboardID = self.leaderboardID
//        lb.submitScore(value, context: 1586145789, player: GKLocalPlayer.local, completionHandler: {
//            error in
//            var res = error
//            var res2 = error
//        })
//        GKLeaderboard.submitScore(lb)
//        let lbEntry:GKLeaderboardEntry = GKLeaderboardEntry(
        let score = GKScore(leaderboardIdentifier: leaderboardID)
        // set value for score
        score.value = Int64(value)
        // push score to Game Center
        GKScore.report([score]) { (error) in
            // check for errors
            if error != nil {
                print("Score updating -- \(error!)")
            }
        }
    }
    
//    func showLeaderboard() {
//        let leaderBoard
//        let gcViewController = GKGameCenterViewController(leaderboardID: self.leaderboardID, playerScope: <#T##GKLeaderboard.PlayerScope#>, timeScope: <#T##GKLeaderboard.TimeScope#>: , playerScope: GKLocalPlayer.local)
//        gcViewController.gameCenterDelegate = self
//        gcViewController.viewState = .leaderboards
//        gcViewController.leaderboardIdentifier = self.leaderboardID
//        gcViewController.title = "Suake3D - Game Center"
//
//        self.viewController?.presentAsModalWindow(gcViewController)
//    }
}
extension GameCenterHelper: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(true)
    }
}

extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}
