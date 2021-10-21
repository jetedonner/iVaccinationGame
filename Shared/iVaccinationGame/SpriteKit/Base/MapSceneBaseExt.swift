//
//  MapSceneBaseExt.swift
//  iVaccinationGame
//
//  Created by Kim David Hauser on 21.10.21.
//

import Foundation
import SpriteKit
import GameplayKit

extension MapSceneBase{
    
    func posDoctorNode(level:Level){
        if(level == .NewGame){
            self.doctorPos = self.imgMeadow.imgNode.position
        }else if(level == .Meadow){
            self.doctorPos = self.imgMeadow.imgNode.position
        }else if(level == .CitySkyline){
            self.doctorPos = self.imgCitySkyline.imgNode.position
        }else if(level == .CityStreet){
            self.doctorPos = self.imgCityStreet.imgNode.position
        }else if(level == .Wallway){
            self.doctorPos = self.imgWallway.imgNode.position
        }else if(level == .CityJapan){
            self.doctorPos = self.imgJapanStreet.imgNode.position
        }else if(level == .CityNight){
            self.doctorPos = self.imgBackstreet.imgNode.position
        }else if(level == .ScarryStreet){
            self.doctorPos = self.imgScarryStreet.imgNode.position
        }
        self.doctor.position = self.doctorPos
        self.currentLevelForDoctor = level
    }
    
    func moveDoctorNodeToNextLevel(){
        if(currentLevelForDoctor == .NewGame){
            currentLevelForDoctor = .Meadow
        }
        self.moveDoctorNodeToLevel(level: currentLevelForDoctor.getNextLevel())
    }
    
    func moveDoctorNodeToLevel(level:Level){
        if(level == .MissionAccomplished){
            return
        }
        self.doctor.removeAllActions()
        self.doctor.run(SKAction.sequence(doctorPathAction[level]!), completion: {
            self.currentLevelForDoctor = level
            self.doctor.run(self.doctorHoppingAction)
        })
    }
    
    func loadDoctorGraph(doctorGraph:[String:GKGraph]){
        self.doctorGraph = doctorGraph
        var currentLevel:Level = .CitySkyline
        if let daGraph = self.doctorGraph.first?.value{
            var idx:Int = 0
            
            for theNode in daGraph.nodes! {
                if(idx == 0){
                    idx += 1
                    continue
                }
                if let point2d = theNode as? GKGraphNode2D {
                    let point = CGPoint(x: CGFloat(point2d.position.x), y: CGFloat(point2d.position.y))
                    let action = SKAction.move(to: point, duration: 0.25)
                    if(doctorPathAction[currentLevel] == nil){
                        doctorPathAction[currentLevel] = [SKAction]()
                    }
                    doctorPathAction[currentLevel]!.append(action)
                }
                if(idx % 5 == 0){
                    currentLevel = currentLevel.getNextLevel()
                }
                idx += 1
            }
        }
    }
}
