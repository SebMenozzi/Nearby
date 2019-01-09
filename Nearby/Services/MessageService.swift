//
//  MessageService.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 30/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation

class MessageService {
    
    static let instance = MessageService()
    
    var messages = [Message]()
    
    func clearMessages() {
        messages.removeAll()
    }
}
