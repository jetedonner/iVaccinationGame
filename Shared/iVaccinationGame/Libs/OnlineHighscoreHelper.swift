//
//  OnlineHighscoreHelper.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 14.10.21.
//

import Foundation
#if os(macOS)
import Cocoa
#else
import UIKit
#endif

enum HighscoreType:String{
    case highscore = "Highscore"
    case vaccinations = "Vaccinations"
    case certificates = "Certificates"
}

class OnlineHighscoreHelper{
    
    let baseURL:String = GameVars.ONLINE_COMPETITION_WEBSERVER
    let webserviceName:String = GameVars.ONLINE_COMPETITION_WEBSERVICE
    let msgBox:SkMessageBoxNode
    
    init(msgBox:SkMessageBoxNode){
        self.msgBox = msgBox
    }
    
    func loadHighscore(completion:@escaping(_:Array<Dictionary<String, Any>>)->Void, difficulty:String = "All"){
        var url = URLComponents(string: self.baseURL + self.webserviceName)!
        url.queryItems = [
            URLQueryItem(name:"action", value: GameVars.ONLINE_COMPETITION_GET_HIGHSCORE),
            URLQueryItem(name:"difficulty", value: difficulty)
        ]
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = GameVars.HTTP_GET
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            do {
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = myJSON {
                    let newHighscore = parseJSON["highscore"]
                    
                    completion(newHighscore as! Array<Dictionary<String, Any>>)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func loadCertificates(completion:@escaping(_:Array<Dictionary<String, Any>>)->Void, difficulty:String = "All"){
        var url = URLComponents(string: self.baseURL + self.webserviceName)!
        url.queryItems = [
            URLQueryItem(name:"action", value: GameVars.ONLINE_COMPETITION_GET_CERTIFICATES),
            URLQueryItem(name:"difficulty", value: difficulty)
        ]
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = GameVars.HTTP_GET
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            do {
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = myJSON {
                    let newHighscore = parseJSON["certificates"]
                    
                    completion(newHighscore as! Array<Dictionary<String, Any>>)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func loadVaccinations(completion:@escaping(_:Array<Dictionary<String, Any>>)->Void, difficulty:String = "All"){
        var url = URLComponents(string: self.baseURL + self.webserviceName)!
        url.queryItems = [
            URLQueryItem(name:"action", value: GameVars.ONLINE_COMPETITION_GET_VACCINATIONS),
            URLQueryItem(name:"difficulty", value: difficulty)
        ]
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = GameVars.HTTP_GET
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            do {
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = myJSON {
                    let newHighscore = parseJSON["vaccinations"]
                    
                    completion(newHighscore as! Array<Dictionary<String, Any>>)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func loadAchievements(completion:@escaping(_:Array<Dictionary<String, Any>>)->Void, difficulty:String = "All"){
        var url = URLComponents(string: self.baseURL + self.webserviceName)!
        url.queryItems = [
            URLQueryItem(name:"action", value: GameVars.ONLINE_COMPETITION_GET_ACHIEVEMENTS),
            URLQueryItem(name:"difficulty", value: difficulty)
        ]
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = GameVars.HTTP_GET
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
        
            do {
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = myJSON {
                    let newHighscore = parseJSON["achievements"]
                    
                    completion(newHighscore as! Array<Dictionary<String, Any>>)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func createPostParameters(params:[String:String])->String{
        var sRet = ""
        for param in params{
            sRet += (sRet == "" ? "" : "&") + param.key + "=" + param.value
        }
        return sRet
    }
    
    func achievementAccomplished(gameScene:GameSceneBase?, achievementId:AchievementId, player:String, difficulty:Difficulty = .easy){
        let url = URLComponents(string: self.baseURL + self.webserviceName)!
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = GameVars.HTTP_POST
        let player = player
        let score = 100
        let difficulty = difficulty.rawValue
        let achievement = achievementId.rawValue

        let postParameters = self.createPostParameters (
            params: [
                "action": GameVars.ONLINE_COMPETITION_POST_ACHIEVEMENT_ACCOMPLISHED,
                "player": player,
                "device": String.macSerialNumber(),
                "achievement": achievement.description,
                "score": score.description,
                "difficulty": difficulty,
                "secretWord": GameVars.ONLINE_COMPETITION_WEBSERVICE_KEY
            ]
        )
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            do {
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = myJSON {
                    var msg : String!
                    msg = parseJSON["message"] as! String?
                    print(msg!)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func uploadHighscore(score:Int, playerName:String, difficulty:String, type:HighscoreType = .highscore){
        let request:NSMutableURLRequest = NSMutableURLRequest(url: URL(string: UserDefaultsHelper.onlineCompetitionURL)!)
        request.httpMethod = GameVars.HTTP_POST
        let player = playerName
        let score = score
        let highscoreType = type.rawValue
        let difficulty = difficulty
        let postParameters = self.createPostParameters(
            params: [
                "action": GameVars.ONLINE_COMPETITION_POST_HIGHSCORE,
                "player": player,
                "device": String.macSerialNumber(),
                "highscoreType": highscoreType,
                "score": score.description,
                "difficulty": difficulty,
                "secretWord": GameVars.ONLINE_COMPETITION_WEBSERVICE_KEY
            ]
        )
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
            do {
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = myJSON {
                    
                    var msg : String!
                    msg = parseJSON["message"] as! String?
                    print(msg!)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
