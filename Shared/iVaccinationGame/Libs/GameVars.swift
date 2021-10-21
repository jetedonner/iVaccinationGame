//
//  GameVars.swift
//  GameVars
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import SpriteKit

class GameVars{
    
    static let DEV_MODE:Bool = true
    
    static let BASE_MEDIA_DIR:String = "Media.scnassets/"
    
    static let DEV_ROUND_TIME:TimeInterval = 30.0
    static let DEV_ZOMBIE_DAMAGE:CGFloat = 25.0
    
    
    static let BLOOD_SHOW_TIME:TimeInterval = 0.35
    static let BLOOD_FADEOUT_TIME:TimeInterval = 0.45
    static let MSGBOX_TIME:TimeInterval = 3.0
    
    static let ONLINE_COMPETITION_WEBSERVER:String = "http://ivaccination.kimhauser.ch/"
    static let ONLINE_COMPETITION_WEBSERVICE:String = "webservice.php"
    
    static let ONLINE_COMPETITION_GET_HIGHSCORE:String = "gethighscore"
    static let ONLINE_COMPETITION_GET_CERTIFICATES:String = "getcertificates"
    static let ONLINE_COMPETITION_GET_VACCINATIONS:String = "getvaccinations"
    static let ONLINE_COMPETITION_GET_ACHIEVEMENTS:String = "getachievements"
    
    static let ONLINE_COMPETITION_POST_ACHIEVEMENT_ACCOMPLISHED:String = "achievementaccomplished"
    static let ONLINE_COMPETITION_POST_HIGHSCORE:String = "uploadHighscore"
    
    static let HTTP_GET:String = "GET"
    static let HTTP_POST:String = "POST"
    
    static let ONLINE_COMPETITION_WEBSERVICE_KEY:String = "9ce95fad-4029-4ee1-97f4-c01a1aed04ca"
    
}
