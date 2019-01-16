//
//  Feed.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 27/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation

enum FeedType: String
{
    case public_feed
    case private_feed
    case personal_feed
}

class Feed: NSObject {
    var id: String?
    var identifier: String?
    var name: String?
    var isLocationBased: Bool?
    var type: FeedType?
    var messages: [Message]?
    var users: [User]?
    var numberConnected: Int?
    var posts: [Post]?
    var numberPosts: Int?
}
