//
//  CommutrResources.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//

class CommutrResources {
    static let sharedResources = CommutrResources()
    var items = [ListItem]()
    var name = ""
    
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
        print("Singleton initialized")
    }
    
    func getProps() -> String {
        return self.name
    }
    
    func setName(name: String) {
        self.name = name;
    }
    
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
    
}
