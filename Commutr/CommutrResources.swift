//
//  CommutrResources.swift
//  Commutr
//
//  Created by Ignacio Streuly on 4/29/17.
//  Copyright © 2017 New York University. All rights reserved.
//

class CommutrResources {
    static let sharedResources = CommutrResources()
    var name = "Iggy"
    
    
    init() {
        print("Singleton initialized")
    }
    
    func getProps() -> String {
        return self.name
    }
    
    func setName(name: String) {
        self.name = name;
    }
}
