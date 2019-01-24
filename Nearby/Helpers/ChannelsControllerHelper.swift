//
//  DirectRoomsControllerHelper.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 09/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import UIKit

extension ChannelsController {
    func setupData() {
        let channel = Channel()
        channel.identifier = "#test"
        channel.name = "Donald"
        //channel.isLocationBased = false
        
        channels = [channel]
    }
}
