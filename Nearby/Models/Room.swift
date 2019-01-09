//
//  Room.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 27/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation

enum RoomType: String
{
    case public_room
    case private_room
    case personal_room
    case direct_room
}

class Room: NSObject {
    var identifier: String?
    var name: String?
    var isLocationBased: Bool?
    var type: RoomType?
    var lastMessage: String?
    var messages: [Message]?
    var users: [User]?
    var numberConnected: Int?
}
