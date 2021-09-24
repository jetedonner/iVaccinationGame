//
//  AppDelegate.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 13.09.21.
//


import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
//    @IBOutlet var window:NSWindow!
    
    var vc:ViewController!
    
    override init() {
        super.init()
        ValueTransformer.setValueTransformer( CGFloatValueTransformer(), forName: .myCGFloatValueTransformer)
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        if(self.vc != nil && self.vc.gameSceneObj != nil){
//            self.vc.gameSceneObj.isPaused = true
            if(self.vc.gameSceneObj.gameRunning){
                self.vc.gameSceneObj.setGamePaused(isPaused: true)
            }
        }
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        if(self.vc != nil && self.vc.gameSceneObj != nil){
            if(self.vc.gameSceneObj.gamePaused && self.vc.gameSceneObj.gameRunning){
//                self.vc.gameSceneObj.isPaused = false
                self.vc.gameSceneObj.setGamePaused(isPaused: false)
            }
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
