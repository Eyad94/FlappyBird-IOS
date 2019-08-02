 //
//  Score.swift
//  FlappyBird
//
//  Created by Ali on 17/07/2019.
//  Copyright © 2019 Afeka. All rights reserved.
//

 import Foundation
 import CoreLocation
 
 class Score :NSObject,NSCoding {
    var name:String
    var level = 0
    var score = 0
    
    static let RECORDS_NAME_FILE = "Scores"
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode("\(self.level)", forKey: "level")
        aCoder.encode("\(self.score)", forKey: "score")
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = (aDecoder.decodeObject(forKey: "name") as? String), let level = aDecoder.decodeObject(forKey: "level") as? String, let score = aDecoder.decodeObject(forKey: "score") as? String else { return nil }
        self.name = name
        self.level = Int(level) ?? 0
        self.score = Int(score) ?? 0
        
        
    }
    
    init(name:String,level:Int,score:Int) {
        self.name = name
        self.level = level
        self.score = score
        
    }
    
    static func loadFromDisk() -> [Score]?{
        if let data = UserDefaults.standard.object(forKey: RECORDS_NAME_FILE) as? Data, let scores = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Score]
        {
            return scores
        }
        return nil
    }
    
    static func save(score:Score){
        var scores:[Score]? = loadFromDisk()
        if scores != nil{
            
            scores?.append(score)
            scores?.sort{$0.score > $1.score}
        }
        else
        {
            scores = [score]
        }
        
        saveToFile(scores: scores!)
    }
    
    static func saveToFile(scores:[Score]){
        var tempScores = scores
        if scores.count != nil , scores.count > 10
        {
            tempScores.remove(at: scores.count-1)
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: tempScores)
        UserDefaults.standard.set(data, forKey: RECORDS_NAME_FILE)
        
    }
    
    
    
 }
 
 
 
 
 
 
 

 
 
 
 
 
