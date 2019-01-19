//
//  Post.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 15/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import Foundation

enum MediaType: String {
    case photo
    case video
    case none
}

class Post: NSObject {
    var public_id: String?
    var user: User?
    var text: String?
    var media: String?
    var mediaType: MediaType?
    var comments: [Comment]?
    var commentsCount: Int?
}
