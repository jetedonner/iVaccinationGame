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
}
