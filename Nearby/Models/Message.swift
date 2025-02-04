//
//  Message.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 28/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation
import KTVJSONWebToken

class Message: NSObject {
    var text: String?
    var date: Date?
    var user: User?
    
    init(dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        text = dictionary["text"] as? String
        date = dictionary["date"] as? Date
        //user = User(dictionary: dictionary["user"] as? [String : Any])
    }
    
    func isSender() -> Bool? {
        let token: String? = AuthService.instance.authToken
        
        do {
            let jwt: JSONWebToken = try JSONWebToken(string : token!)
            
            let public_id = jwt.payload["public_id"] as! String
            
            return self.user?.public_id == public_id
        } catch {
            return false
        }
    }
}
