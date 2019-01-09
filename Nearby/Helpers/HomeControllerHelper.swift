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
        
        let france = Room()
        france.identifier = "#france"
        france.name = "France 🇫🇷"
        france.isLocationBased = false
        france.type = RoomType.public_room
        france.numberConnected = 10203
        
        let fun = Room()
        fun.identifier = "#fun"
        fun.name = "Fun 🎉"
        fun.isLocationBased = false
        fun.type = RoomType.public_room
        fun.numberConnected = 6456
        
        let food = Room()
        food.identifier = "#food"
        food.name = "Food 🍎"
        food.isLocationBased = false
        food.type = RoomType.public_room
        food.numberConnected = 3340
        
        let seb = Room()
        seb.identifier = "#(seb)"
        seb.name = "Seb"
        seb.isLocationBased = false
        seb.type = RoomType.private_room
        seb.numberConnected = 2789
        
        let dals = Room()
        dals.identifier = "#music"
        dals.name = "Music 🎧"
        dals.isLocationBased = false
        dals.type = RoomType.public_room
        dals.numberConnected = 1492
        
        let onpc = Room()
        onpc.identifier = "#(onpc)"
        onpc.name = "ONPC 📺"
        onpc.isLocationBased = false
        onpc.type = RoomType.private_room
        onpc.numberConnected = 102
        
        let seb2 = Room()
        seb2.identifier = "@seb"
        seb2.name = "Seb 🔥"
        seb2.isLocationBased = false
        seb2.type = RoomType.personal_room
        seb2.numberConnected = 56
        
        let menozzi = Room()
        menozzi.identifier = "#(menozzi)"
        menozzi.name = "Menozzi 🍩"
        menozzi.isLocationBased = false
        menozzi.type = RoomType.private_room
        menozzi.numberConnected = 24
        
        popularRooms = [france, fun, food, seb, dals, onpc, seb2, menozzi]
    }
    
    func createMessage(text: String, user: User, minutesAgo: Double) -> Message {
        return Message(dictionary: ["user": user, "text": text, "date": Date().addingTimeInterval(-minutesAgo * 60)])
    }
}

