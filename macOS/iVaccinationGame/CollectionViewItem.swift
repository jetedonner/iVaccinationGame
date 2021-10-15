//
//  CollectionViewItem.swift
//  SlidesMagic
//
//  Created by Gabriel Miro on 28/11/15.
//  Copyright © 2015 razeware. All rights reserved.
//
import Foundation
import Cocoa

class CollectionViewItem: NSCollectionViewItem {
  
    @IBOutlet var lblDesc:NSTextField!
    @IBOutlet var lblDate:NSTextField!
  // 1
//  var imageFile: ImageFile? {
//    didSet {
//      guard isViewLoaded else { return }
//      if let imageFile = imageFile {
//        imageView?.image = imageFile.thumbnail
//        textField?.stringValue = imageFile.fileName
//      } else {
//        imageView?.image = nil
//        textField?.stringValue = ""
//      }
//    }
//  }
  
  // 2
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.darkGray.cgColor
        // 1
        view.layer?.borderWidth = 2.0
        // 2
        view.layer?.borderColor = NSColor.lightGray.cgColor
        view.layer?.cornerRadius = 10.0
      
      
    }

    func setHighlight(selected: Bool) {
//        view.layer?.borderWidth = selected ? 5.0 : 0.0
        let highlightColor:NSColor = NSColor.cyan
        view.layer?.backgroundColor = highlightColor.withAlphaComponent(0.25).cgColor
    }

//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//
//        // #1d161d
//        NSColor(red: 0x1d/255, green: 0x16/255, blue: 0x1d/255, alpha: 1).setFill()
//        dirtyRect.fill()
//    }
  
}
