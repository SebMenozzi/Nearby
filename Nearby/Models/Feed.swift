//
//  Feed.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 27/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation
import UIKit

enum FeedType: String
{
    case public_feed
    case private_feed
    case personal_feed
}

struct FeedColor {
    static let violet = UIColor(r: 77, g: 51, b: 241)
    static let pink = UIColor(r: 246, g: 102, b: 179)
    static let blue = UIColor(r: 105, g: 198, b: 255)
    static let red = UIColor(r: 246, g: 76, b: 96)
    static let azure = UIColor(r: 79, g: 198, b: 206)
}

class Feed: NSObject {
    var public_id: String?
    var identifier: String?
    var name: String?
    var emoji: String?
    var color: UIColor?
    var isLocationBased: Bool?
    var type: FeedType?
    var messages: [Message]?
    var users: [User]?
    var numberConnected: Int?
    var posts: [Post]?
    var numberPosts: Int?
}
