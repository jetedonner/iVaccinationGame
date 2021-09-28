//
//  VersionHelper.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 28.09.21.
//

import Foundation

class VersionHelper{
    
    static func getAppVersion()->String{
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
//        let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
//        self.lblVersion?.text = "Version: \(appVersion!) - Build: \(appBuild!)"
    }
    
    static func getAppBuild()->String{
        return (Bundle.main.infoDictionary?["CFBundleVersion"] as? String)!
    }
}
