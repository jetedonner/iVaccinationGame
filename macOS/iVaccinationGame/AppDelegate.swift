//
//  AppDelegate.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 13.09.21.
//


import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    override init() {
        super.init()
        ValueTransformer.setValueTransformer( CGFloatValueTransformer(), forName: .myCGFloatValueTransformer)
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
