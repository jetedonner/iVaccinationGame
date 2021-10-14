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
    
        static let VaccinationsCell = "VaccinationsCell"
        static let CertificatesCell = "CertificatesCell"
    }
    
    @IBOutlet var tblHighscore:NSTableView!
    @IBOutlet var tblCertificates:NSTableView!
    @IBOutlet var tblVaccinations:NSTableView!
    @IBOutlet weak var collectionView: NSCollectionView!
    
    @IBOutlet var prgLoading:NSProgressIndicator!
    
    var highscore:Any!
    var vaccinations:Any!
    var certificates:Any!
    var achievements:Any!
    
    let onlineHelper:OnlineHighscoreHelper = OnlineHighscoreHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testInsertHS(nil)
        
        self.configureCollectionView()
        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
        self.collectionView.reloadData()
    }
    
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var tmpArr:Array<Dictionary<String, Any>> = []
        tmpArr.removeAll()
        
        var text: String = ""
        var cellIdentifier: String = ""
        let textColor:NSColor = NSColor.white
        let newRow:Int = row
        
        var scoreColumnTitle:String = "Score"
        var scoreColumnValue:String = ""
        if(tableView == self.tblHighscore){
            tmpArr = self.highscore as! Array<Dictionary<String, Any>>
            if(row > 0){
                scoreColumnValue = tmpArr[row-1]["score"] as! String
            }
            cellIdentifier = CellIdentifiers.ScoreCell
        }else if(tableView == self.tblVaccinations){
            tmpArr = self.vaccinations as! Array<Dictionary<String, Any>>
            scoreColumnTitle = "Vaccinations"
            if(row > 0){
                scoreColumnValue = tmpArr[row-1]["vaccinations"] as! String
            }
            cellIdentifier = CellIdentifiers.VaccinationsCell
        }else if(tableView == self.tblCertificates){
            tmpArr = self.certificates as! Array<Dictionary<String, Any>>
            scoreColumnTitle = "Certificates"
            if(row > 0){
                scoreColumnValue = tmpArr[row-1]["certificates"] as! String
            }
            cellIdentifier = CellIdentifiers.CertificatesCell
        }

            

            if tableColumn == tableView.tableColumns[0] {
                if(row == 0){
                    text = "Rank"
                }else{
                    text = (tmpArr[newRow-1]["rank"] as! NSNumber).stringValue
                }
                cellIdentifier = CellIdentifiers.RankCell
            } else if tableColumn == tableView.tableColumns[1] {
                if(newRow <= 0){
                    text = "Player"
                }else{
                    text = tmpArr[newRow-1]["player"] as! String
                }
                cellIdentifier = CellIdentifiers.PlayerCell
            } else if tableColumn == tableView.tableColumns[2] {
                if(newRow <= 0){
                    text = scoreColumnTitle
                }else{
                    text = scoreColumnValue //tmpArr[newRow-1]["score"] as! String
                }
                
            }else if tableColumn == tableView.tableColumns[3] {
                if(newRow <= 0){
                    text = "Difficulty"
                }else{
                    text = tmpArr[newRow-1]["difficulty"] as! String
                }
                cellIdentifier = CellIdentifiers.DifficultyCell
            }
            
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
                cell.textField?.stringValue = text
    //            cell.textField?.font = NSFont(name: SuakeVars.defaultFontName, size: 24.0)
//                cell.textField?.sizeToFit()
//                cell.setFrameSize((cell.textField?.frame.size)!)
//                cell.textField?.setFrameOrigin(NSZeroPoint)
//                cell.textField?.backgroundColor = NSColor.gray
                cell.textField?.textColor = textColor
                cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.width, height: 15))
//                tableView.rowHeight = 60
//                tableView.rowHeight = (cell.textField?.frame.height)! + 2
                return cell
            }
//        }
        return nil
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        if(tableView == self.tblHighscore){
            if let highscore = self.highscore as? Array<Dictionary<String, Any>>{
                return highscore.count + 1
            }
        }else if(tableView == self.tblVaccinations){
            if let vaccination = self.vaccinations as? Array<Dictionary<String, Any>>{
                return vaccination.count + 1
            }
        }else if(tableView == self.tblCertificates){
            if let certificate = self.certificates as? Array<Dictionary<String, Any>>{
                return certificate.count + 1
            }
        }
        return 0
    }
    
    @IBAction func close(_ sender:Any){
//        self.gameScene?.endGame()
//        self.gameScene?.getViewController().loadMenuScene()
        self.dismiss(sender)
    }
    
    //ivaccination.kimhauser.ch/webservice.php?action=gethighscore
    
    private func configureCollectionView() {
      // 1
      let flowLayout = NSCollectionViewFlowLayout()
      flowLayout.itemSize = NSSize(width: 160.0, height: 290.0)
      flowLayout.sectionInset = NSEdgeInsets(top: 30.0, left: 20.0, bottom: 30.0, right: 20.0)
      flowLayout.minimumInteritemSpacing = 20.0
      flowLayout.minimumLineSpacing = 20.0
      collectionView.collectionViewLayout = flowLayout
       view.wantsLayer = true
      collectionView.layer?.backgroundColor = NSColor.black.cgColor
    }
    
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
    
    @IBAction func testInsertHS(_ sender:Any?){
        self.prgLoading.isHidden = false
        self.prgLoading.startAnimation(sender)
        self.onlineHelper.loadHighscore(completion: { loadedHighscore in
            DispatchQueue.main.async {
                self.highscore = loadedHighscore
                self.tblHighscore.delegate = self
                self.tblHighscore.dataSource = self
                self.tblHighscore.reloadData()
                
                self.onlineHelper.loadVaccinations(completion: { loadedVaccinations in
                    DispatchQueue.main.async {
                        self.vaccinations = loadedVaccinations
                        self.tblVaccinations.delegate = self
                        self.tblVaccinations.dataSource = self
                        self.tblVaccinations.reloadData()
                        
                        self.onlineHelper.loadCertificates(completion: { loadedCertificates in
                            DispatchQueue.main.async {
                                self.certificates = loadedCertificates
                                self.tblCertificates.delegate = self
                                self.tblCertificates.dataSource = self
                                self.tblCertificates.reloadData()
                                
                                self.onlineHelper.loadAchievements(completion: { loadedAchievements in
                                    DispatchQueue.main.async {
                                        self.achievements = loadedAchievements
//                                        self.collectionView.delegate = self
                                        self.collectionView.dataSource = self
                                        self.collectionView.reloadData()
//                                        self.tblCertificates.delegate = self
//                                        self.tblCertificates.dataSource = self
//                                        self.tblCertificates.reloadData()
                                        self.prgLoading.stopAnimation(sender)
                                        self.prgLoading.isHidden = true
                                    }
                                })
//                                self.prgLoading.stopAnimation(sender)
//                                self.prgLoading.isHidden = true
                            }
                        })
                    }
                })
            }
        })
        
    }
    
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


extension HighscoreViewController: NSCollectionViewDataSource{
    
    func checkAchievement(achievement:String)->Bool{
        for ach in self.achievements as! Array<Dictionary<String, Any>>{
            if(ach["achievement"] as! String == achievement){
                return true
            }
        }
        return false
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath)// .makeItemWithIdentifier("CollectionViewItem", forIndexPath: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {return item}
        collectionViewItem.textField?.stringValue = "Stay healthy"
        collectionViewItem.lblDesc?.stringValue = "Try to stay healthy - to complete this task you must avoid to be bitten by the zombies"
        if(self.checkAchievement(achievement: "grp.ch.kimhauser.swift.ivaccinationgame.achivements.stayhealthy")){
            collectionViewItem.imageView?.image = NSImage(named: "StayHealthy")
        }else{
            collectionViewItem.imageView?.image = NSImage(named: "StayHealthyBW")
        }
        collectionViewItem.view.frame = CGRect(origin: collectionViewItem.view.frame.origin, size: CGSize(width: 160, height: 290))
        if(indexPath.item == 1){
            if(self.checkAchievement(achievement: "grp.ch.kimhauser.swift.ivaccinationgame.achivements.perfectthrows")){
                collectionViewItem.imageView?.image = NSImage(named: "PerfectShot")
            }else{
                collectionViewItem.imageView?.image = NSImage(named: "PerfectShotBW")
            }
            
            collectionViewItem.textField?.stringValue = "Perfect shot"
            collectionViewItem.lblDesc?.stringValue = "Try to hit the zombies with every single syringe you shoot at them"
        }else if(indexPath.item == 2){
            collectionViewItem.imageView?.image = NSImage(named: "CertificatesBW")
            collectionViewItem.textField?.stringValue = "All certificates"
            collectionViewItem.lblDesc?.stringValue = "Try to collect all certificates in the current level before they disapear"
        }else if(indexPath.item == 3){
            collectionViewItem.imageView?.image = NSImage(named: "CertificatesBW")
            collectionViewItem.textField?.stringValue = "All levels"
            collectionViewItem.lblDesc?.stringValue = "Try to complete all levels for the current difficulty"
        }else if(indexPath.item == 4){
            collectionViewItem.imageView?.image = NSImage(named: "CertificatesBW")
            collectionViewItem.textField?.stringValue = "All certificates (levels)"
            collectionViewItem.lblDesc?.stringValue = "Try to collect all certificates in all levels before they disapear"
        }else if(indexPath.item == 5){
            collectionViewItem.imageView?.image = NSImage(named: "PerfectShotBW")
            collectionViewItem.textField?.stringValue = "Perfect shot (levels)"
            collectionViewItem.lblDesc?.stringValue = "Try to hit the zombies with every single shot in all levels"
        }else if(indexPath.item == 6){
            collectionViewItem.imageView?.image = NSImage(named: "CertificatesBW")
            collectionViewItem.textField?.stringValue = "All certificates"
            collectionViewItem.lblDesc?.stringValue = "Try to collect all certificates in the current level before they disapear"
        }else if(indexPath.item == 7){
            collectionViewItem.imageView?.image = NSImage(named: "CertificatesBW")
            collectionViewItem.textField?.stringValue = "All levels"
            collectionViewItem.lblDesc?.stringValue = "Try to complete all levels for the current difficulty"
        }else if(indexPath.item == 8){
            collectionViewItem.imageView?.image = NSImage(named: "CertificatesBW")
            collectionViewItem.textField?.stringValue = "All certificates"
            collectionViewItem.lblDesc?.stringValue = "Try to collect all certificates in the current level before they disapear"
        }
//        let imageFile = imageDirectoryLoader.imageFileForIndexPath(indexPath)
//        collectionViewItem.imageFile = imageFile
        
//        if let selectedIndexPath = collectionView.selectionIndexPaths.first where selectedIndexPath == indexPath {
//          collectionViewItem.setHighlight(true)
//        } else {
//          collectionViewItem.setHighlight(false)
//        }
        
//        let currentCGImage = collectionViewItem.imageView?.image?.cgImage //else { return nil }
//        let currentCIImage = CIImage(cgImage: currentCGImage as! CGImage)
//
//        let filter = CIFilter(name: "CIColorMonochrome")
//        filter?.setValue(currentCIImage, forKey: "inputImage")
//
//        // set a gray value for the tint color
//        filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")
//
//        filter?.setValue(1.0, forKey: "inputIntensity")
//        let outputImage = filter?.outputImage
//
//        let context = CIContext()
//
//        let cgimg = context.createCGImage(outputImage!, from: outputImage!.extent)
////            let processedImage = UIImage(cgImage: cgimg)
////            print(processedImage.size)
//        collectionViewItem.imageView?.image = NSImage(cgImage: cgimg!, size: CGSize(width: 128, height: 128))
//        }
        
        return item
    }
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
      return 9 //imageDirectoryLoader.numberOfSections
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
      return 9// imageDirectoryLoader.numberOfItemsInSection(section)
    }
    
//    func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: NSIndexPath) -> NSCollectionViewItem {
//
//      let item = collectionView.makeItemWithIdentifier("CollectionViewItem", forIndexPath: indexPath)
//      guard let collectionViewItem = item as? CollectionViewItem else {return item}
//
//      let imageFile = imageDirectoryLoader.imageFileForIndexPath(indexPath)
//      collectionViewItem.imageFile = imageFile
//
//      if let selectedIndexPath = collectionView.selectionIndexPaths.first where selectedIndexPath == indexPath {
//        collectionViewItem.setHighlight(true)
//      } else {
//        collectionViewItem.setHighlight(false)
//      }
//
//      return item
//    }
    
    func collectionView(collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> NSView {
        let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.SupplementaryElementKind("SectionHeader"), withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HeaderView"), for: indexPath as IndexPath)// .makeSupplementaryViewOfKind(NSCollectionElementKindSectionHeader, withIdentifier: "HeaderView", forIndexPath: indexPath) as! HeaderView
//        view.tit .sectionTitle.stringValue = "Section \(indexPath.section)"
//      let numberOfItemsInSection = imageDirectoryLoader.numberOfItemsInSection(indexPath.section)
//      view.imageCount.stringValue = "\(numberOfItemsInSection) image files"
      return view
    }
}
