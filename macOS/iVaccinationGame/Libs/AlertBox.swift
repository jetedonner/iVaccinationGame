//
//  AlertBox.swift
//  AlertBox
//
//  Created by Kim David Hauser on 19.09.21.
//

import Foundation
import Cocoa

class AlertBox{
    
    static func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        alert.window.setFrameOrigin(CGPoint(x: 200, y: 200))// = newFrame
        return alert.runModal() == .alertFirstButtonReturn
    }
}
