//
//  AppDelegate.swift
//  iVaccination
//
//  Created by Kim David Hauser on 16.09.21.
//

import UIKit

@UIApplicationMain
class AppDelegate:  UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var vc:GameViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
//        super.applicationWillResignActive(application)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        var tmp = -1
        tmp /= -1
        if(self.vc != nil && self.vc.gameSceneObj != nil){
            if(self.vc.gameSceneObj.gameRunning){
                self.vc.gameSceneObj.setGamePaused(isPaused: true)
            }
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough /Volumes/Data/dev/XCode/_games/iVaccinationGame/iVaccinationGame.xcodeprojapplication state information to restore your application to its current state in case it is terminated later.
        var tmp = -1
        tmp /= -1
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        var tmp = -1
        tmp /= -1
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        var tmp = -1
        tmp /= -1
        if(self.vc != nil && self.vc.gameSceneObj != nil){
            if(self.vc.gameSceneObj.gamePaused && self.vc.gameSceneObj.gameRunning){
                self.vc.gameSceneObj.setGamePaused(isPaused: false)
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication){
        var tmp = -1
        tmp /= -1
    }


//    public static func main(){
//        var tmp = -1
//        tmp /= -1
//        super.main()
//    }
}

