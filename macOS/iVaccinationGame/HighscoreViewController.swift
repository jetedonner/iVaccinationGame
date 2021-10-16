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
        self.collectionView.delegate = self
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
            scoreColumnValue = tmpArr[row]["score"] as! String
            cellIdentifier = CellIdentifiers.ScoreCell
        }else if(tableView == self.tblVaccinations){
            tmpArr = self.vaccinations as! Array<Dictionary<String, Any>>
            scoreColumnTitle = "Vaccinations"
            scoreColumnValue = tmpArr[row]["vaccinations"] as! String
            cellIdentifier = CellIdentifiers.VaccinationsCell
        }else if(tableView == self.tblCertificates){
            tmpArr = self.certificates as! Array<Dictionary<String, Any>>
            scoreColumnTitle = "Certificates"
            scoreColumnValue = tmpArr[row]["certificates"] as! String
            cellIdentifier = CellIdentifiers.CertificatesCell
        }

        if tableColumn == tableView.tableColumns[0] {
            text = (tmpArr[newRow]["rank"] as! NSNumber).stringValue
            cellIdentifier = CellIdentifiers.RankCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = tmpArr[newRow]["player"] as! String
            cellIdentifier = CellIdentifiers.PlayerCell
        } else if tableColumn == tableView.tableColumns[2] {
            tableColumn?.title = scoreColumnTitle
            text = scoreColumnValue
        }else if tableColumn == tableView.tableColumns[3] {
            text = tmpArr[newRow]["difficulty"] as! String
            cellIdentifier = CellIdentifiers.DifficultyCell
        }
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            cell.textField?.textColor = textColor
            cell.frame = CGRect(origin: cell.frame.origin, size: CGSize(width: cell.frame.width, height: 15))
            return cell
        }
        return nil
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        if(tableView == self.tblHighscore){
            if let highscore = self.highscore as? Array<Dictionary<String, Any>>{
                return highscore.count
            }
        }else if(tableView == self.tblVaccinations){
            if let vaccination = self.vaccinations as? Array<Dictionary<String, Any>>{
                return vaccination.count
            }
        }else if(tableView == self.tblCertificates){
            if let certificate = self.certificates as? Array<Dictionary<String, Any>>{
                return certificate.count
            }
        }
        return 0
    }
    
    @IBAction func close(_ sender:Any){
        self.dismiss(sender)
    }
    
    private func configureCollectionView() {
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 160.0, height: 290.0)
        flowLayout.sectionInset = NSEdgeInsets(top: 0.0, left: 20.0, bottom: 30.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 20.0
        flowLayout.minimumLineSpacing = 20.0
        collectionView.collectionViewLayout = flowLayout
        flowLayout.headerReferenceSize = CGSize(width: 1000, height: 50)
        view.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.black.cgColor
    }
    
    @IBAction func testInsertAch(_ sender:Any){
        self.onlineHelper.achievementAccomplished(achievementId: .achivementPerfectThrowsID)
    }
    
    @IBAction func testInsertHS2(_ sender:Any){
        let request:NSMutableURLRequest = NSMutableURLRequest(url: URL(string: "http://ivaccination.kimhauser.ch/highscore.php")!)
        request.httpMethod = "POST"
        let player = "FromMacOS"
        let score = 123
        let difficulty = "Easy"
        
        let postParameters = "player=" + player + "&score=" + score.description + "&difficulty=" + difficulty;
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            if error != nil{
                print("error is \(error)")
                return;
            }
            do {
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                if let parseJSON = myJSON {
                    
                    var msg : String!
                    msg = parseJSON["message"] as! String?
                    print(msg)
                }
            } catch {
                print(error)
            }
        }
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
                                        self.collectionView.delegate = self
                                        self.collectionView.dataSource = self
                                        self.collectionView.reloadData()
                                        self.prgLoading.stopAnimation(sender)
                                        self.prgLoading.isHidden = true
                                    }
                                })
                            }
                        })
                    }
                })
            }
        })
        
    }
}

extension HighscoreViewController: NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return NSSize(width: 1000, height: 40)
    }
}
  
extension HighscoreViewController: NSCollectionViewDataSource, NSCollectionViewDelegate{
    
    func checkAchievement(achievementId:AchievementId)->String{
        for ach in self.achievements as! Array<Dictionary<String, Any>>{
            if(ach["achievement"] as! String == achievementId.rawValue){
                return ach["dt_create"] as! String
            }
        }
        return ""
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CollectionViewItem"), for: indexPath)// .makeItemWithIdentifier("CollectionViewItem", forIndexPath: indexPath)
        guard let collectionViewItem = item as? CollectionViewItem else {return item}
        
        collectionViewItem.view.frame = CGRect(origin: collectionViewItem.view.frame.origin, size: CGSize(width: 160, height: 290))
        if(indexPath.section == 0 && indexPath.item == 0){
            collectionViewItem.textField?.stringValue = "Stay healthy"
            collectionViewItem.lblDesc?.stringValue = "Try to stay healthy - to complete this task you must avoid to be bitten by the zombies"
            let check = self.checkAchievement(achievementId: AchievementId.achivementStayHealthyID)
            if(check != ""){
                collectionViewItem.imageView?.image = NSImage(named: "StayHealthy")
                collectionViewItem.lblDate.stringValue = check
                collectionViewItem.lblDate.isHidden = false
                collectionViewItem.lblDate.drawsBackground = true
                collectionViewItem.lblDate.backgroundColor = NSColor(calibratedWhite: 0.75, alpha:0.35)
                collectionViewItem.lblDate.wantsLayer = true
                collectionViewItem.lblDate.layer?.cornerRadius = 10.0
            }else{
//                collectionViewItem.imageView?.image = NSImage(named: "LockedBW")
            }
        }else if(indexPath.section == 0 && indexPath.item == 1){
            if(self.checkAchievement(achievementId: AchievementId.achivementPerfectThrowsID /*"grp.ch.kimhauser.swift.ivaccinationgame.achivements.perfectthrows"*/) != ""){
                collectionViewItem.imageView?.image = NSImage(named: "PerfectShot")
                collectionViewItem.lblDate.stringValue = "2021-10-14"
                collectionViewItem.lblDate.isHidden = false
                collectionViewItem.lblDate.drawsBackground = true
                collectionViewItem.lblDate.backgroundColor = NSColor(calibratedWhite: 0.75, alpha:0.35)
                collectionViewItem.lblDate.wantsLayer = true
                collectionViewItem.lblDate.layer?.cornerRadius = 10.0
                collectionViewItem.setHighlight(selected: true)
            }else{
                collectionViewItem.imageView?.image = NSImage(named: "PerfectShotBW")
            }
            
            collectionViewItem.textField?.stringValue = "Perfect shot"
            collectionViewItem.lblDesc?.stringValue = "Try to hit the zombies with every single syringe you shoot at them"
        }else if(indexPath.section == 0 && indexPath.item == 2){
//            collectionViewItem.imageView?.image = NSImage(named: "CertificatesBW")
            collectionViewItem.textField?.stringValue = "All certificates"
            collectionViewItem.lblDesc?.stringValue = "Try to collect all certificates in the current level before they disapear"
        }else if(indexPath.section == 1 && indexPath.item == 0){
            collectionViewItem.textField?.stringValue = "All levels"
            collectionViewItem.lblDesc?.stringValue = "Try to complete all levels for the current difficulty"
        }else if(indexPath.section == 1 && indexPath.item == 1){
            collectionViewItem.textField?.stringValue = "Perfect shot (levels)"
            collectionViewItem.lblDesc?.stringValue = "Try to hit the zombies with every single shot in all levels"
        }else if(indexPath.section == 1 && indexPath.item == 2){
            collectionViewItem.textField?.stringValue = "All health (levels)"
            collectionViewItem.lblDesc?.stringValue = "Try to stay healthy in all levels - not a single bite by zombies"
        }else if(indexPath.section == 1 && indexPath.item == 3){
            collectionViewItem.textField?.stringValue = "All certificates (levels)"
            collectionViewItem.lblDesc?.stringValue = "Try to collect all certificates in all levels before they disapear"
        }else if(indexPath.section == 1 && indexPath.item == 4){
            collectionViewItem.textField?.stringValue = "Complete easy levels"
            collectionViewItem.lblDesc?.stringValue = "Complete all easy levels"
        }else if(indexPath.section == 1 && indexPath.item == 5){
            collectionViewItem.textField?.stringValue = "Complete medium levels"
            collectionViewItem.lblDesc?.stringValue = "Complete all medium levels"
        }else if(indexPath.section == 1 && indexPath.item == 6){
            collectionViewItem.textField?.stringValue = "Complete hard levels"
            collectionViewItem.lblDesc?.stringValue = "Complete all hard levels"
        }else if(indexPath.section == 1 && indexPath.item == 7){
            collectionViewItem.textField?.stringValue = "Complete nightmare levels"
            collectionViewItem.lblDesc?.stringValue = "Complete all nightmare levels"
        }else if(indexPath.section == 2 && indexPath.item == 0){
            collectionViewItem.textField?.stringValue = "Complete the game"
            collectionViewItem.lblDesc?.stringValue = "Complete all levels with all difficulties"
        }else if(indexPath.section == 2 && indexPath.item == 1){
            collectionViewItem.textField?.stringValue = "All achievements"
            collectionViewItem.lblDesc?.stringValue = "Complete all achievements"
        }
//        let imageFile = imageDirectoryLoader.imageFileForIndexPath(indexPath)
//        collectionViewItem.imageFile = imageFile
        
//        let selectedIndexPath = collectionView.selectionIndexPaths.first where selectedIndexPath == indexPath
//        if let selectedIndexPath = collectionView.selectionIndexPaths.first where selectedIndexPath == indexPath {
//          collectionViewItem.setHighlight(true)
//        } else {
//          collectionViewItem.setHighlight(false)
//        }
        return item
    }
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 3
    }
    
    func numberOfSectionsInCollectionView(collectionView: NSCollectionView) -> Int {
        return 3 //imageDirectoryLoader.numberOfSections
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 3
        }else if(section == 1){
            return 8
        }else{
            return 2
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: NSCollectionView.SupplementaryElementKind, at indexPath: IndexPath) -> NSView {
        if(kind == NSCollectionView.SupplementaryElementKind("UICollectionElementKindSectionHeader")){
            let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.SupplementaryElementKind("UICollectionElementKindSectionHeader"), withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HeaderView"), for: indexPath) as! HeaderView
            if(indexPath.section == 0){
                view.sectionTitle.stringValue = "Current level: 'Meadow'"
            }else if(indexPath.section == 1){
                view.sectionTitle.stringValue = "All levels: 'Easy'"
            }else{
                view.sectionTitle.stringValue = "Game overall"
            }
            return view
        }else{
            return NSView()
        }
    }
}
