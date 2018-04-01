//
//  ScheduleModel.swift
//  FoxSportModules
//
//  Created by BimBim on 3/28/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import Foundation

class ScheduleModel: Decodable {
    var id: Int
    var startTime: String
    var endTime: String
    var description: String
    var isLive: Bool
}
