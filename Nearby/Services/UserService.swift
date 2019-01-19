//
//  UserService.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 19/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import Foundation

class UserService {
    
    let defaults = UserDefaults.standard
    
    static let instance = UserService()
    
    var user: User? {
        get {
            return defaults.value(forKey: "user") as? User
        }
        set {
            defaults.setValue(newValue, forKey: "user")
        }
    }
    
}
