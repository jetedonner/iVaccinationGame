//
//  SettingsViewController.swift
//  SettingsViewController
//
//  Created by Kim David Hauser on 16.09.21.
//

import Foundation
import Cocoa



class HighscoreViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    fileprivate enum CellIdentifiers {
        static let RankCell = "RankCell"
        static let PlayerCell = "PlayerCell"
        static let ScoreCell = "ScoreCell"
        static let DifficultyCell = "DifficultyCell"
    }
    
    @IBOutlet var tblHighscore:NSTableView!
    
//    var gameScene:GameSceneBase?
//
//    @IBOutlet var volume:NSSlider?
//    @IBOutlet var playBGMusic:NSSwitch?
//    @IBOutlet var playSounds:NSSwitch?
//    @IBOutlet var sharedUserDefaultsController:NSUserDefaultsController?
//
//    @IBOutlet var swtDevMode:NSSwitch?
//
//    @IBOutlet var cmbTime:NSPopUpButton?
//    @IBOutlet var cmbDifficulty:NSPopUpButton?
//    @IBOutlet var cmbLevel:NSPopUpButton?
//
//    @IBOutlet var cmdAbortGame:NSButton?
//    @IBOutlet var cmdTestAch:NSButton?
//    @IBOutlet var cmdResetAch:NSButton?
//    @IBOutlet var cmdResetICloud:NSButton?
//    @IBOutlet var cmdResetUserDef:NSButton?
//    @IBOutlet var cmdResetALL:NSButton?
//    @IBOutlet var lblDevMode:NSTextField?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if(VersionHelper.getDevMode()){
//            self.swtDevMode?.isHidden = false
//            self.lblDevMode?.isHidden = false
//            self.showHideAchButtons(hide: (self.swtDevMode?.state == .off))
//        }else{
//            self.swtDevMode?.isHidden = true
//            self.lblDevMode?.isHidden = true
//            self.swtDevMode?.state = .off
//            self.showHideAchButtons(hide: true)
//        }
//        if(self.gameScene == nil || (self.gameScene != nil && (!self.gameScene!.gameRunning))){
//            self.cmdAbortGame?.isHidden = true
//        }
//    }
//
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var tmpArr:Array<Dictionary<String, Any>> = []
        tmpArr.removeAll()
        tmpArr = self.highscore as! Array<Dictionary<String, Any>>
//            msgng.removeFirst()
    //            return msgng.count
    //        }
    //        for itm in msgng as! Array<Dictionary<String, Any>>{
    //            print("RANK: \(itm["rank"])")
    //            print("SCORE: \(itm["score"])")
    //            print("DIFFICULTY: \(itm["difficulty"])")
    //            print("PLAYER: \(itm["player"])")
    //        }
            var text: String = ""
            var cellIdentifier: String = ""
            var textColor:NSColor = NSColor.white
            let newRow:Int = row

            if tableColumn == tableView.tableColumns[0] {
                if(row == 0){
                    text = "Rank"
                }else{
                    text = (tmpArr[newRow-1]["rank"] as! NSNumber).stringValue //SuakeStatsType.allCases[newRow - 1].rawValue
                }
                cellIdentifier = CellIdentifiers.RankCell
    //            textColor = NSColor.suake3DTextColor
            } else if tableColumn == tableView.tableColumns[1] {
                if(newRow <= 0){
                    text = "Player"
                }else{
                    text = tmpArr[newRow-1]["player"] as! String //self.game.playerEntityManager.ownPlayerEntity.statsComponent.suakeStats.getStatsValue(suakeStatsType: SuakeStatsType.allCases[newRow - 1]).description
                }
                cellIdentifier = CellIdentifiers.PlayerCell
    //            textColor = NSColor.suake3DRed
            } else if tableColumn == tableView.tableColumns[2] {
                if(newRow <= 0){
                    text = "Score"
                }else{
                    text = tmpArr[newRow-1]["score"] as! String //self.game.playerEntityManager.oppPlayerEntity.statsComponent.suakeStats.getStatsValue(suakeStatsType: SuakeStatsType.allCases[newRow - 1]).description // "T3S3T" //""
                }
    //            textColor = NSColor.suake3DOppBlue// NSColor(named: "Suake3DOpponentBlue")!
                cellIdentifier = CellIdentifiers.ScoreCell
            }else if tableColumn == tableView.tableColumns[3] {
                if(newRow <= 0){
                    text = "Difficulty"
                }else{
                    text = tmpArr[newRow-1]["difficulty"] as! String //self.game.playerEntityManager.oppPlayerEntity.statsComponent.suakeStats.getStatsValue(suakeStatsType: SuakeStatsType.allCases[newRow - 1]).description // "T3S3T" //""
                }
    //            textColor = NSColor.suake3DOppBlue// NSColor(named: "Suake3DOpponentBlue")!
                cellIdentifier = CellIdentifiers.DifficultyCell
            }
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = text
    //            cell.textField?.font = NSFont(name: SuakeVars.defaultFontName, size: 24.0)
                cell.textField?.sizeToFit()
                cell.setFrameSize((cell.textField?.frame.size)!)
                cell.textField?.setFrameOrigin(NSZeroPoint)
                cell.textField?.backgroundColor = NSColor.gray
                cell.textField?.textColor = textColor
                tableView.rowHeight = (cell.textField?.frame.height)! + 2
                return cell
            }
//        }
        return nil
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        if let msgng = self.highscore as? Array<Dictionary<String, Any>>{
            return msgng.count + 1
        }
//        for itm in msgng as! Array<Dictionary<String, Any>>{
//            print("RANK: \(itm["rank"])")
//            print("SCORE: \(itm["score"])")
//            print("DIFFICULTY: \(itm["difficulty"])")
//            print("PLAYER: \(itm["player"])")
//        }
        
        return 0
    }
    
    @IBAction func close(_ sender:Any){
//        self.gameScene?.endGame()
//        self.gameScene?.getViewController().loadMenuScene()
        self.dismiss(sender)
    }
    
    //ivaccination.kimhauser.ch/webservice.php?action=gethighscore
    
    @IBAction func testInsertHS2(_ sender:Any){
        var request:NSMutableURLRequest = NSMutableURLRequest(url: URL(string: "http://ivaccination.kimhauser.ch/highscore.php")!)
        request.httpMethod = "POST"
        //getting values from text fields
        let player = "FromMacOS"//textFieldName.text
        let score = 123//textFieldMember.text
        let difficulty = "Easy"//textFieldMember.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "player=" + player + "&score=" + score.description + "&difficulty=" + difficulty;
        
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
    }
    
    @IBAction func testInsertHS(_ sender:Any){
        
//        let getParameter = "action=gethighscore"
//        request.url?.parameterString = getParameter
        
        var url = URLComponents(string: "http://ivaccination.kimhauser.ch/webservice.php")!

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
                    var msg : Dictionary<String, String>!
                    
                    //getting the json response
//                    msg = parseJSON["highscore"] as! Dictionary?
                    let msgng = parseJSON["highscore"]
                    //printing the response
                    
                    
                    
                    DispatchQueue.main.async {
                        self.highscore = msgng
                        self.tblHighscore.delegate = self
                        self.tblHighscore.dataSource = self
                        self.tblHighscore.reloadData()
                    }
                    
                    
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
//        self.gameScene?.endGame()
//        self.gameScene?.getViewController().loadMenuScene()
//        self.dismiss(sender)
    }
    
    var highscore:Any!
//
//    @IBAction func switchDbgBorders(_ sender:Any){
////        self.showHideAchButtons(hide: (self.swtDevMode?.state == .off))
//    }
//
//    @IBAction func switchDevMode(_ sender:Any){
//        self.showHideAchButtons(hide: (self.swtDevMode?.state == .off))
//    }
//
//    func showHideAchButtons(hide:Bool){
//        self.cmdTestAch?.isHidden = hide
//        self.cmdResetAch?.isHidden = hide
//        self.cmdResetUserDef?.isHidden = hide
//        self.cmdResetICloud?.isHidden = hide
//        self.cmdResetALL?.isHidden = hide
//    }
//
//    @IBAction func resetALL(_ sender:Any){
//        ICloudStorageHelper.resetAllICloudValues()
//        UserDefaultsHelper.resetUserDefValues()
//        GCAchievements.shared.resetAllCompletedAchivements()
//        _ = AlertBox.dialogOK(message: "All values reset", text: "All values and achievements reset ok!")
//    }
//
//    @IBAction func resetICloud(_ sender:Any){
//        ICloudStorageHelper.resetAllICloudValues()
//        _ = AlertBox.dialogOK(message: "iCloud values reset", text: "All iCloud values reset ok!")
//    }
//
//    @IBAction func resetUserDef(_ sender:Any){
//        UserDefaultsHelper.resetUserDefValues()
//        _ = AlertBox.dialogOK(message: "UserDefault values reset", text: "All UserDefault values reset ok!")
//    }
//
//    @IBAction func resetGCAchivements(_ sender:Any){
//        GCAchievements.shared.resetAllCompletedAchivements()
//        _ = AlertBox.dialogOK(message: "All achievements reset", text: "All achievements reset ok!")
//    }
//
//    @IBAction func testGCAchivements(_ sender:Any){
//        GCAchievements.shared.add2perfectThrows()
//        GCAchievements.shared.add2stayHealthy()
//        GCAchievements.shared.add2completeAllLevels()
//    }
//
//    @IBAction func closeAndDiscardChanges(_ sender:Any){
//        self.sharedUserDefaultsController?.revert(nil)
//        if(gameScene != nil){
//            self.gameScene?.setGamePaused(isPaused: false)
//        }
//        self.dismiss(sender)
//    }
//
//    @IBAction func closeAndResume(_ sender:Any){
//        if(gameScene != nil){
//            if(self.playBGMusic!.state == .on){
//                SoundManager.shared.playBGSound()
//            }else{
//                SoundManager.shared.stopBGSound()
//            }
//            SoundManager.shared.songPlayer?.volume = self.volume!.floatValue
//            SoundManager.shared.masterVolume = CGFloat(self.volume!.floatValue)
//            UserDefaultsHelper.volume = self.volume!.floatValue
//        }
//        self.dismiss(sender)
//        if(self.gameScene != nil){
//            self.gameScene?.setGamePaused(isPaused: false)
////            let answer = AlertBox.dialogOKCancel(question: "Ok?", text: "Settings changed! Do you want to abort the current level?")
////            if(answer){
////                self.gameScene!.runLevelConfig(levelID: UserDefaultsHelper.levelID, difficulty: UserDefaultsHelper.difficulty)
////            }else{
////                self.gameScene?.setGamePaused(isPaused: false)
////            }
//        }
//    }
}

