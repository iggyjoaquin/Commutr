//
//  CommutrResources.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//
import Foundation

class CommutrResources {
    static let sharedResources = CommutrResources()
    var items = [ListItem]()
    var timeIsSet = false
    var timeInSeconds : TimeInterval? = nil
    
    
    //settings
    var filterList = true
    var useNaturalLanguageTime = true
    var pointsScalar = 30
    
    struct ListItem {
        var title: String
        var storyPoints: Double
        var priority: Double
        var timeNeeded : Int
        var scale = CommutrResources.sharedResources.pointsScalar
        
        init(title: String, storyPoints: Double, priority: Double) {
            self.title = title
            self.storyPoints = storyPoints
            self.priority = priority
            self.timeNeeded = Int(storyPoints) * scale
        }
        
    }
    
    init() {
        //print("Singleton initialized")
    }
    
    //item methods
    func addItem(title: String, points: Double, priority: Double) {
        let newItem = ListItem(title: title, storyPoints: points, priority: priority)
        self.items.append(newItem)
    }
    
    func removeItem(idx: Int) {
        self.items.remove(at: idx)
    }
    
    func getAllItems() -> [ListItem] {
        return self.items
    }
    
    func itemsToString() -> String {
        let ret = self.items.map({"\($0)"}).joined(separator: ",")
        return ret
    }
    
    func sortTasks(callback: @escaping (Bool) -> Void) {
        //determine how to sort
        let currTime = self.timeInSeconds
        let minutes = currTime! / 60
        let hours = floor(minutes / 60)
        
        if (hours >= 2) {
            //sort by priority, then time
            self.items.sort { (first, second) in return first.priority < second.priority}
            self.items.sort { (first, second) in return first.timeNeeded < second.timeNeeded }
        }
        
        if (hours < 2) {
            //sort by time, then priority
            self.items.sort { (first, second) in return first.timeNeeded < second.timeNeeded }
            self.items.sort { (first, second) in return first.priority < second.priority}
        }
    
        //necessary to reload list table view at the right time
        callback(true)
        
    }
    
    //ETA or inputted time methods
    func setTimeForTasks(time: TimeInterval) {
        self.timeInSeconds = time
        self.timeIsSet = true
        
    }
    
    func resetTime() {
        self.timeIsSet = false
    }
    
    func getTimeForTask() -> TimeInterval {
        return self.timeInSeconds!
    }
    
    func getTime() -> String {
        var ret = ""
        
        if (self.useNaturalLanguageTime) {
            ret = self.getNaturalLanguageTime()
        } else {
            ret = self.getDigitalTime()
        }
        
        return ret
    }
    
    func getDigitalTime() -> String {
        let currTime = self.timeInSeconds
        let minutes = currTime! / 60
        let hours = floor(minutes / 60)
        let leftOverMinutes = minutes - (hours * 60)
        
        var ret = ""
        
        if Int(hours) == 0 {
            ret = "\(Int(leftOverMinutes)) minutes"
            return ret
        }
        
        if leftOverMinutes == 0 {
            ret = "\(Int(hours)) hours"
            return ret
        }
        
        ret = "\(Int(hours)):\(Int(leftOverMinutes))"
        return ret
    }
    
    
    func getNaturalLanguageTime() -> String  {
        let currTime = self.timeInSeconds
        let minutes = currTime! / 60
        let hours = floor(minutes / 60)
        let leftOverMinutes = minutes - (hours * 60)
        
        var ret = ""
        
        if Int(hours) == 0 {
            ret = "\(Int(leftOverMinutes)) minutes"
            return ret
        }
        
        if leftOverMinutes == 0 {
            ret = "\(Int(hours)) hours"
            return ret
        }
        
        ret = "\(Int(hours)) hours and \(Int(leftOverMinutes)) minutes"
        return ret
    }
    
    
    //settings methods
    func updateSettings(naturalLanguageClock: Bool, filterList: Bool, pointsScalar: Int) {
        self.useNaturalLanguageTime = naturalLanguageClock
        self.filterList = filterList
        self.pointsScalar = pointsScalar
    }
}
