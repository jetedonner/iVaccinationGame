//
//  OnlineHighscoreHelper.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 14.10.21.
//

import Foundation
import Cocoa

class OnlineHighscoreHelper{

    let baseURL:String = "http://ivaccination.kimhauser.ch/"
    let webserviceName:String = "webservice.php"
   
    
    func loadHighscore(completion:@escaping(_:Array<Dictionary<String, Any>>)->Void){
        var url = URLComponents(string: self.baseURL + self.webserviceName)!

        url.queryItems = [
            URLQueryItem(name:"action", value:"gethighscore")
        ]
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = "GET"
        
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
    
    func loadCertificates(completion:@escaping(_:Array<Dictionary<String, Any>>)->Void){
        var url = URLComponents(string: self.baseURL + self.webserviceName)!

        url.queryItems = [
            URLQueryItem(name:"action", value:"getcertificates")
        ]
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = "GET"
        
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
    
    func loadVaccinations(completion:@escaping(_:Array<Dictionary<String, Any>>)->Void){
        var url = URLComponents(string: self.baseURL + self.webserviceName)!

        url.queryItems = [
            URLQueryItem(name:"action", value:"getvaccinations")
        ]
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = "GET"
        
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
    
    func loadAchievements(completion:@escaping(_:Array<Dictionary<String, Any>>)->Void){
        var url = URLComponents(string: self.baseURL + self.webserviceName)!

        url.queryItems = [
            URLQueryItem(name:"action", value:"getachievements")
        ]
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = "GET"
        
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
    
//    achievementaccomplished
    func achievementAccomplished(achievementId:AchievementId){
        let url = URLComponents(string: self.baseURL + self.webserviceName)!
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
        request.httpMethod = "POST"
        //getting values from text fields
        let player = "FromMacOS"//textFieldName.text
        let score = 123//textFieldMember.text
        let difficulty = "Easy"//textFieldMember.text
        let achievement = AchievementId.achivementPerfectThrowsID.rawValue //textFieldMember.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "action=achievementaccomplished&player=" + player + "&achievement=" + achievement.description + "&score=" + score.description + "&difficulty=" + difficulty + "&secretWord=9ce95fad-4029-4ee1-97f4-c01a1aed04ca";
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
                return;
            }
        
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
        
//        var url = URLComponents(string: self.baseURL + self.webserviceName)!
//
//        url.queryItems = [
//            URLQueryItem(name:"action", value:"achievementaccomplished")
//        ]
//
//        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)
//        request.httpMethod = "POST"
//
//        let task = URLSession.shared.dataTask(with: request as URLRequest){
//            data, response, error in
//
//            if error != nil{
//                print("error is \(String(describing: error))")
//                return;
//            }
//
//            do {
//                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
//                if let parseJSON = myJSON {
//                    let newHighscore = parseJSON["achievements"]
//
//                    completion(newHighscore as! Array<Dictionary<String, Any>>)
//                }
//            } catch {
//                print(error)
//            }
//
//        }
//        task.resume()
    }
    
}
