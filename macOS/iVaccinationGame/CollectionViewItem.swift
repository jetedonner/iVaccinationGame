//
//  CollectionViewItem.swift
//  SlidesMagic
//
//  Created by Gabriel Miro on 28/11/15.
//  Copyright © 2015 razeware. All rights reserved.
//
import Foundation
#if os(macOS)
import Cocoa
#else
import UIKit
#endif

class CollectionViewItem: NSCollectionViewItem {
  
    @IBOutlet var lblDesc:NSTextField!
    @IBOutlet var lblDate:NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.darkGray.cgColor
        view.layer?.borderWidth = 2.0
        view.layer?.borderColor = NSColor.lightGray.cgColor
        view.layer?.cornerRadius = 10.0
        self.identifier = NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem")
    }

    func setHighlight(selected: Bool) {
//        view.layer?.borderWidth = selected ? 5.0 : 0.0
        if(selected){
            let highlightColor:NSColor = NSColor.cyan
            view.layer?.backgroundColor = highlightColor.withAlphaComponent(0.25).cgColor
        }else{
            view.layer?.backgroundColor = NSColor.darkGray.cgColor
        }
    }
}
