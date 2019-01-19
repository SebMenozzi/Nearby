//
//  UserDataService.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 19/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import Foundation

class UserDataService {
    
    let defaults = UserDefaults.standard
    
    static let instance = UserDataService()
    
    var userData: [String: Any]? {
        get {
            return defaults.value(forKey: "user") as? [String: Any]
        }
        set {
            guard var data = newValue else { return }
            for (key,value) in data { if value is NSNull { data[key] = "" as Any }}
            defaults.setValue(data, forKey: "user")
        }
    }
    
}
