//
//  ChannelModel.swift
//  FoxSportModules
//
//  Created by BimBim on 3/28/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import Foundation

class ChannelModel: Decodable {
    var id: Int
    var icon: String
    var name: String

    init(id: Int, icon: String, name: String) {
        self.id = id
        self.icon = icon
        self.name = name
    }
}
