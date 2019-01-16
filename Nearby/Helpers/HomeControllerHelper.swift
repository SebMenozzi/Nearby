//
//  HomeControllerHelper.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 28/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

extension HomeController {
    func setupData() {
        
        // Users
        let seb = User(dictionary: [
            "id" : 2,
            "picture": "seb",
            "name": "Seb 🔥",
            "username": "seb"
        ])
        
        let cesar = User(dictionary: [
            "id" : 3,
            "picture": "cesar",
            "name": "MattGorko 🕺",
            "username": "cesar"
        ])
        
        let steve = User(dictionary: [
            "id" : 4,
            "picture": "steve",
            "name": "Steve Jobs",
            "username": "steve"
        ])
        
        // France
        
        let france = Feed()
        france.identifier = "#france"
        france.name = "France 🇫🇷"
        france.isLocationBased = false
        france.type = FeedType.public_feed
        france.numberConnected = 10203
        
        let france_post1 = Post()
        france_post1.user = seb
        france_post1.text = "Ceci est un post !"
        france_post1.mediaType = MediaType.none
        france_post1.commentsCount = 12
        france_post1.comments = []
        
        let france_post2 = Post()
        france_post2.user = cesar
        france_post2.text = "J'aime les grosses bites de noirs 🍆"
        france_post2.mediaType = MediaType.photo
        france_post2.media = "https://scontent-cdg2-1.xx.fbcdn.net/v/t1.15752-9/49898248_279526686054443_1034684095784812544_n.jpg?_nc_cat=111&_nc_ht=scontent-cdg2-1.xx&oh=bb9816cf528c9a4c452d2c301da4c643&oe=5CBB3FA3"
        france_post2.commentsCount = 3
        france_post2.comments = []
        
        let france_post3 = Post()
        france_post3.user = steve
        france_post3.text = "Most people make the mistake of thinking design is what it looks like. People think it’s this veneer – that the designers are handed this box and told, “Make it look good!” That’s not what we think design is. It’s not just what it looks like and feels like. Design is how it works."
        france_post3.mediaType = MediaType.none
        france_post3.commentsCount = 0
        france_post3.comments = []
        
        france.posts = [france_post1, france_post2, france_post3]
        
        // Fun
        
        let fun = Feed()
        fun.identifier = "#fun"
        fun.name = "Fun 🎉"
        fun.isLocationBased = false
        fun.type = FeedType.public_feed
        fun.numberConnected = 6456
        
        let food = Feed()
        food.identifier = "#food"
        food.name = "Food 🍎"
        food.isLocationBased = false
        food.type = FeedType.public_feed
        food.numberConnected = 3340
        
        let seb_feed = Feed()
        seb_feed.identifier = "#(seb)"
        seb_feed.name = "Seb"
        seb_feed.isLocationBased = false
        seb_feed.type = FeedType.private_feed
        seb_feed.numberConnected = 2789
        
        let dals = Feed()
        dals.identifier = "#music"
        dals.name = "Music 🎧"
        dals.isLocationBased = false
        dals.type = FeedType.public_feed
        dals.numberConnected = 1492
        
        let onpc = Feed()
        onpc.identifier = "#(onpc)"
        onpc.name = "ONPC 📺"
        onpc.isLocationBased = false
        onpc.type = FeedType.private_feed
        onpc.numberConnected = 102
        
        let seb2 = Feed()
        seb2.identifier = "@seb"
        seb2.name = "Seb 🔥"
        seb2.isLocationBased = false
        seb2.type = FeedType.personal_feed
        seb2.numberConnected = 56
        
        let menozzi = Feed()
        menozzi.identifier = "#(menozzi)"
        menozzi.name = "Menozzi 🍩"
        menozzi.isLocationBased = false
        menozzi.type = FeedType.private_feed
        menozzi.numberConnected = 24
        
        feeds = [france, fun, food, seb_feed, dals, onpc, seb2, menozzi]
    }
    
    func createMessage(text: String, user: User, minutesAgo: Double) -> Message {
        return Message(dictionary: ["user": user, "text": text, "date": Date().addingTimeInterval(-minutesAgo * 60)])
    }
}

