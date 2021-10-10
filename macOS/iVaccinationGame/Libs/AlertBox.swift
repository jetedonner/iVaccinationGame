//
//  AlertBox.swift
//  AlertBox
//
//  Created by Kim David Hauser on 19.09.21.
//

import Foundation
#if os(macOS)
import Cocoa
#endif
#if os(iOS)
import UIKit
#endif
class AlertBox{
    
    static var userWantToChangeSettings:Bool = false
    
    #if os(iOS)
    static func alertTheUser(viewController:UIViewController, completion:@escaping ()->Void, question: String, text: String) {
        //If we want to print something on the screen, we use UIAlertController:
        let alert = UIAlertController(title: question, message: text, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertToCancel) in
            
            self.userWantToChangeSettings = false
            print("Im being changed!")
             completion()
        }))

        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: { (action) in

            self.userWantToChangeSettings = true
            completion()
        }))
        
        
        viewController.present(alert, animated: true)
    }
    #endif
    
    #if os(macOS)
    static func dialogOKCancel(question: String, text: String) -> Bool {
        
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        alert.window.setFrameOrigin(CGPoint(x: 200, y: 200))// = newFrame
        let retVal = alert.runModal()
        return retVal == .alertFirstButtonReturn
    }
    
    
    static func dialogOK(message: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = text
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
//        alert.addButton(withTitle: "Cancel")
        alert.window.setFrameOrigin(CGPoint(x: 200, y: 200))// = newFrame
        return alert.runModal() == .alertFirstButtonReturn
    }
    #endif
}
