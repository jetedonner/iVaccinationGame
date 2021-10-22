//
//  UIHighscoreViewController.swift
//  iVaccination
//
//  Created by Kim David Hauser on 22.10.21.
//

import Foundation
import UIKit

class HighscoreViewController: UITabBarController {
    
    init(){
//        super.init()
        super.init(nibName: "HighscoreViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
}
