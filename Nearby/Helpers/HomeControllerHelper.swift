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
        let seb = User()
        seb.picture = "seb"
        seb.name = "Seb 🔥"
        seb.username = "seb"
        
        let cesar = User()
        cesar.picture = "cesar"
        cesar.name = "MattGorko 🕺"
        cesar.username = "cesar"
        
        let steve = User()
        steve.picture = "steve"
        steve.name = "Steve Jobs"
        steve.username = "steve"
        
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
        
        // comment 1
        let france_post1_comment1 = Comment()
        france_post1_comment1.user = seb
        france_post1_comment1.text = "vive le cul et les nudes 😂🔞"
        france_post1_comment1.mediaType = MediaType.none
        
        // comment 2
        let france_post1_comment2 = Comment()
        france_post1_comment2.user = steve
        france_post1_comment2.text = "Vazy c dégueulasse va parler de ça en privé avec tes potes les pervers"
        france_post1_comment2.mediaType = MediaType.none
        
        france_post1.comments = [ france_post1_comment1, france_post1_comment2 ]
        
        let france_post2 = Post()
        france_post2.user = cesar
        france_post2.text = "J'aime les grosses bites de noirs 🍆"
        france_post2.mediaType = MediaType.photo
        france_post2.media = "https://sossafetymagazine.com/wp-content/uploads/A-Snapchat-Guide-for-Parents-snap-example.jpg"
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

