//
//  User.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 26/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation

class User : NSObject {
    var public_id: String?
    var username: String?
    var name: String?
    var email: String?
    var phoneNumber: String?
    var picture: String?
    var gender: String?
    var birthday: String?
    
    init(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        public_id = dictionary["public_id"] as? String
        username = dictionary["username"] as? String
        name = dictionary["name"] as? String
        email = dictionary["email"] as? String
        phoneNumber = dictionary["phoneNumber"] as? String
        picture = dictionary["picture"] as? String
        gender = dictionary["gender"] as? String
        birthday = dictionary["birthday"] as? String
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "username": self.username ?? "",
            "name": self.name ?? "",
            "email": self.email ?? "",
            "phone_number": self.phoneNumber ?? "",
            "picture": self.picture ?? "",
            "gender": self.gender ?? "none",
            "birthday": self.birthday ?? ""
        ]
    }
}
