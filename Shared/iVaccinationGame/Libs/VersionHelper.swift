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
    }
    
    static func getAppBuild()->String{
        return (Bundle.main.infoDictionary?["CFBundleVersion"] as? String)!
    }
    
    static func getDevMode()->Bool{
        if(Bundle.main.infoDictionary?["DevMode"] == nil){
            return false
        }else{
            return (Bundle.main.infoDictionary?["DevMode"] as? Bool)!
        }
    }
    
    static func getOnlineScoreboardLink()->String{
        if(Bundle.main.infoDictionary?["OnlineScoreboardLink"] == nil){
            return GameVars.ONLINE_SCOREBOARD_LINK
        }else{
            return (Bundle.main.infoDictionary?["OnlineScoreboardLink"] as? String)!
        }
    }
    
    static func getOnlineWebserver()->String{
        if(Bundle.main.infoDictionary?["OnlineWebserver"] == nil){
            return GameVars.ONLINE_COMPETITION_WEBSERVER
        }else{
            return (Bundle.main.infoDictionary?["OnlineWebserver"] as? String)!
        }
    }
    
    static func getOnlineWebservice()->String{
        if(Bundle.main.infoDictionary?["OnlineWebservice"] == nil){
            return GameVars.ONLINE_COMPETITION_WEBSERVICE
        }else{
            return (Bundle.main.infoDictionary?["OnlineWebservice"] as? String)!
        }
    }
}
