//
//  HeaderView.swift
//  SlidesMagic
//
//  Created by Gabriel Miro on 28/11/15.
//  Copyright © 2015 razeware. All rights reserved.
//

import Cocoa

class HeaderView: NSView {

  @IBOutlet weak var sectionTitle: NSTextField!
  @IBOutlet weak var imageCount: NSTextField!
  
//    override init(frame frameRect: NSRect) {
//        super.init(frame: frameRect)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
//        NSColor(calibratedWhite: 0.8 , alpha: 0.8).set()
//        dirtyRect.fill(using: NSCompositingOperation.sourceOver)
//    NSRectFillUsingOperation(dirtyRect, NSCompositingOperation.CompositeSourceOver)
  }
}
