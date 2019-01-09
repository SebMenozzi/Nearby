//
//  User.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 26/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation

enum Gender: String
{
    case male
    case female
    case none
}

class User : NSObject {
    var id: Int?
    var username: String?
    var name: String?
    var email: String?
    var phoneNumber: String?
    var picture: String?
    var gender: Gender?
    
    init(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        id = dictionary["id"] as? Int
        username = dictionary["username"] as? String
        name = dictionary["name"] as? String
        email = dictionary["email"] as? String
        phoneNumber = dictionary["phoneNumber"] as? String
        picture = dictionary["picture"] as? String
        gender = dictionary["gender"] as? Gender
    }
}
