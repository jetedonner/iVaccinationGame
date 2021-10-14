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
        
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url.url!)// URL(string: "http://ivaccination.kimhauser.ch/webservice.php")!)
        request.httpMethod = "GET"
        //getting values from text fields
//        let player = "FromMacOS"//textFieldName.text
//        let score = 123//textFieldMember.text
//        let difficulty = "Easy"//textFieldMember.text
//
//        //creating the post parameter by concatenating the keys and values from text field
//        let postParameters = "player=" + player + "&score=" + score.description + "&difficulty=" + difficulty;
        
        
        //adding the parameters to request body
//        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(String(describing: error))")
                return;
            }
        
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
//                    var msg : Dictionary<String, String>!
                    
                    //getting the json response
//                    msg = parseJSON["highscore"] as! Dictionary?
                    let newHighscore = parseJSON["highscore"]
                    //printing the response
                    
                    completion(newHighscore as! Array<Dictionary<String, Any>>)
                    
//                    retu rn msgng
//                    DispatchQueue.main.async {
//                        self.highscore = msgng
//                        self.tblHighscore.delegate = self
//                        self.tblHighscore.dataSource = self
//                        self.tblHighscore.reloadData()
//                    }
                    
                    
//                    for itm in msgng as! Array<Dictionary<String, Any>>{
//                        print("RANK: \(itm["rank"])")
//                        print("SCORE: \(itm["score"])")
//                        print("DIFFICULTY: \(itm["difficulty"])")
//                        print("PLAYER: \(itm["player"])")
//                    }
//                    print(msgng)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
    }
}
