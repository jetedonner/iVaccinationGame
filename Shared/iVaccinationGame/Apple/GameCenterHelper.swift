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
    
    var delegate:GameCenterHelperDelegate?
    
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
            GKAccessPoint.shared.showHighlights = true
            GKAccessPoint.shared.isActive = GKLocalPlayer.local.isAuthenticated
              
              // Observe when the access point changes its size
              let observation = GKAccessPoint.shared.observe(
                         \.frameInScreenCoordinates
                  ) { [weak self] _,_ in
                      
                      var tmp = -1
                      tmp /= -1
//                  let screenFrame = GKAccessPoint.shared.frameInScreenCoordinates
//                  let accessPointFrame = myView.convert(screenFrame, from: nil)
                  // adjust your layout
              }
              
              // Observe when the access point displays the dashboard
              let observation2 = GKAccessPoint.shared.observe(
                         \.isPresentingGameCenter
                  ) { [weak self] _,_ in
                      var tmp = -1
                      tmp /= -1
//                  self.paused = GKAccessPoint.shared.isPresentingGameCenter
              }
              
//              GKAccessPoint.shared.observe(<#T##keyPath: KeyPath<GKAccessPoint, Value>##KeyPath<GKAccessPoint, Value>#>, changeHandler: <#T##(GKAccessPoint, NSKeyValueObservedChange<Value>) -> Void#>)
              // Observe when the access point displays the dashboard
              
              
//              let observation = GKAccessPoint.shared.observe(
//                         \.isPresentingGameCenter
//                  ) { [weak self] _,_ in
//                      print("INHEEEEEEEEEAAAA")
////                  self.paused = GKAccessPoint.shared.isPresentingGameCenter
//                      (self?.viewController as! ViewController).gameSceneObj.isPaused = GKAccessPoint.shared.isPresentingGameCenter
//              }
          } else if let vc = gcAuthVC {
              #if os(macOS)
              self.viewController?.presentAsModalWindow(vc)//(vc, animator: NSViewControllerPresentationAnimator).present(vc, animated: true)
              #else
              self.viewController?.present(vc, animated: true, completion: {
                  
              })
              #endif
          }
          else {
//            print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
          }
        }
    }
    
    func showDashboard(){
        let viewController = GKGameCenterViewController(state: .dashboard)
        viewController.gameCenterDelegate = self
//        self.viewController?.presentAsModalWindow(viewController)
        #if os(macOS)
        self.viewController?.presentAsModalWindow(viewController)//(vc, animator: NSViewControllerPresentationAnimator).present(vc, animated: true)
        #else
        self.viewController?.present(viewController, animated: true, completion: {
            
        })
        #endif

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
        #if os(macOS)
        gameCenterViewController.dismiss(true)
        #else
        gameCenterViewController.dismiss(animated: true)
        #endif
    }
}

extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}
