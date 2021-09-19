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
    
    let inviteMessage:String = "Hey there join me for a iVaccination fight!"
    var currentVC: GKMatchmakerViewController?
    
    var viewController: NSViewController?
    var delegate:GameCenterHelperDelegate?
    
    init(vc:ViewController) {
        super.init()
        self.viewController = vc
    }
    
    func loadGameCenter(){
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
        let score = GKScore(leaderboardIdentifier: leaderboardID)
        score.value = Int64(value)
        let scr = GKLeaderboardScore()
        scr.leaderboardID = self.leaderboardID
        scr.player = GKLocalPlayer.local
        scr.value = value
        scr.context = 1586145789
        GKScore.report([scr], withEligibleChallenges: [], withCompletionHandler: { error in
            let res = error
            _ = res
        })
    }
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
