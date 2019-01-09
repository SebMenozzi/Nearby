//
//  DirectRoomsControllerHelper.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 09/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

extension DirectRoomsController {
    func setupData() {
        let room = Room()
        room.identifier = "#test"
        room.name = "Donald"
        room.isLocationBased = false
        room.type = RoomType.direct_room
        
        directRooms = [room]
    }
}
