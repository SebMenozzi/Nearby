//
//  Comment.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 16/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import Foundation

class Comment: NSObject {
    var id: String?
    var user: User?
    var text: String?
    var media: String?
    var mediaType: MediaType?
    var likesCount: Int?
}

