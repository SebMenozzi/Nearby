//
//  FeedCellHelper.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 23/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import Foundation

extension FeedCell {
    
    func setupData() {
        
        // Users
        let seb = User(dictionary: [
            "username": "seb",
            "name": "Seb 🔥",
            "picture": "seb"
        ])
        
        let cesar = User(dictionary: [
            "username": "cesar",
            "name": "MattGorko 🕺",
            "picture": "cesar"
        ])
        
        let steve = User(dictionary: [
            "username": "steve",
            "name": "Steve Jobs",
            "picture": "steve"
        ])
        
        // France
        
        let france = Feed()
        france.identifier = "#france"
        france.name = "France 🇫🇷🍷"
        france.emoji = "🇫🇷"
        france.color = FeedColor.violet
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
        france_post2.media = "https://scontent-cdg2-1.xx.fbcdn.net/v/t1.0-9/50407325_10157371386944880_6421135218878447616_n.png?_nc_cat=1&_nc_ht=scontent-cdg2-1.xx&oh=4c5164a609213ff639250cb49657bb7b&oe=5CCFCB7D"
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
        fun.emoji = "🎉"
        fun.color = FeedColor.blue
        fun.isLocationBased = false
        fun.type = FeedType.public_feed
        fun.numberConnected = 6456
        
        let food = Feed()
        food.identifier = "#food"
        food.name = "Food 🍎"
        food.emoji = "🍎"
        food.color = FeedColor.red
        food.isLocationBased = false
        food.type = FeedType.public_feed
        food.numberConnected = 3340
        
        let foot = Feed()
        foot.identifier = "#football"
        foot.name = "Football"
        foot.emoji = "⚽️"
        foot.color = FeedColor.azure
        foot.isLocationBased = false
        foot.type = FeedType.public_feed
        foot.numberConnected = 2789
        
        let music = Feed()
        music.identifier = "#music"
        music.name = "Music 🎧"
        music.emoji = "🎧"
        music.isLocationBased = false
        music.type = FeedType.public_feed
        music.numberConnected = 1492
        
        let onpc = Feed()
        onpc.identifier = "#(onpc)"
        onpc.name = "ONPC 📺"
        onpc.emoji = "📺"
        onpc.isLocationBased = false
        onpc.type = FeedType.private_feed
        onpc.numberConnected = 102
        
        let seb2 = Feed()
        seb2.identifier = "@seb"
        seb2.name = "Seb 🔥"
        seb2.emoji = "🔥"
        seb2.color = FeedColor.pink
        seb2.isLocationBased = false
        seb2.type = FeedType.personal_feed
        seb2.numberConnected = 56
        
        let menozzi = Feed()
        menozzi.identifier = "#(menozzi)"
        menozzi.name = "Menozzi 🍩"
        menozzi.emoji = "🍩"
        menozzi.isLocationBased = false
        menozzi.type = FeedType.private_feed
        menozzi.numberConnected = 24
        
        feeds = [france, fun, food, foot, music, onpc, seb2, menozzi]
    }
    
}
