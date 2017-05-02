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
    var useNaturalLanguageTime = true
    
    
    struct ListItem {
        var title: String
        var storyPoints: Double
        var priority: Double
        
        init(title: String, storyPoints: Double, priority: Double) {
            self.title = title
            self.storyPoints = storyPoints
            self.priority = priority
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
    
    func getAllItems() -> [ListItem] {
        return self.items
    }
    
    func itemsToString() -> String {
        let ret = self.items.map({"\($0)"}).joined(separator: ",")
        return ret
    }
    
    //ETA or inputted time methods
    func setTimeForTasks(time: TimeInterval) {
        self.timeIsSet = true
        self.timeInSeconds = time

    }
    
    func getTimeForTask() -> TimeInterval {
        return self.timeInSeconds!
    }
    
    func getNaturalLanguageTime() -> String  {
        let currTime = self.timeInSeconds
        let minutes = currTime! / 60
        let hours = floor(minutes / 60)
        
        let leftOverMinutes = minutes - (hours * 60)
        
        print(currTime)
        print("\(leftOverMinutes) <- minutes")
        print("\(hours) <- hours")
        
        return "yo"
    }
    
    
    
}
