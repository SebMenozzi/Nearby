//
//  User.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 26/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation

enum Gender: String {
    case male
    case female
    case none
}

class User : NSObject {
    var public_id: String?
    var username: String?
    var name: String?
    var email: String?
    var phoneNumber: String?
    var picture: String?
    var gender: Gender?
    var birthday: Date?
    
    func create(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        public_id = dictionary["public_id"] as? String
        username = dictionary["username"] as? String
        name = dictionary["name"] as? String
        email = dictionary["email"] as? String
        phoneNumber = dictionary["phoneNumber"] as? String
        picture = dictionary["picture"] as? String
        gender = dictionary["gender"] as? Gender
        birthday = dictionary["birthday"] as? Date
    }
}
