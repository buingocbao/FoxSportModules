//
//  ChannelFactory.swift
//  FoxSportModules
//
//  Created by BimBim on 3/28/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import Foundation

class ChannelFactory {
    static func generateChannelModel() -> ChannelModel {
        return ChannelModel(id: 0, icon: "fox_icon", name: "Fox Sports")
    }

    static func generateSchedulesOfChannel() -> [ScheduleModel] {
        let schedulesJson = """
        [
        { "id" : 1, "startTime" : "12:00am", "endTime" : "01:00am", "description" : "Bundesliga 2017/18 Koln vs. Leipzig", "isLive" : true  },
        { "id" : 2, "startTime" : "01:00am", "endTime" : "03:00am", "description" : "MotoGP - Highlights - Movistar Grand Prix Of Aragon", "isLive" : false  },
        { "id" : 3, "startTime" : "04:00am", "endTime" : "05:00am", "description" : "Clubland", "isLive" : false },
        { "id" : 4, "startTime" : "05:00am", "endTime" : "05:30am", "description" : "2017 Formula 1 Petronas Malaysia Grand Prix - Highlights", "isLive" : true },
        { "id" : 5, "startTime" : "05:30am", "endTime" : "06:00am", "description" : "The Outdoor Sports 2017", "isLive" : false },
        { "id" : 6, "startTime" : "08:00am", "endTime" : "09:00am", "description" : "Dutch Eredivise 2016/18 Highlights", "isLive" : false },
        { "id" : 7, "startTime" : "09:00am", "endTime" : "10:30am", "description" : "Presidents Cup", "isLive" : false },
        { "id" : 8, "startTime" : "10:30am", "endTime" : "12:00pm", "description" : "Blancpain GT Serires 2017", "isLive" : true },
        { "id" : 9, "startTime" : "12:00pm", "endTime" : "03:00pm", "description" : "NASCAR Cup Serires: Apache Warrior 400", "isLive" : false },
        { "id" : 10, "startTime" : "03:00pm", "endTime" : "05:00pm", "description" : "American League Wild Card 2017", "isLive" : false },
        { "id" : 11, "startTime" : "05:00pm", "endTime" : "06:00pm", "description" : "ATP 250 Shenzhen Open 2017 H/Ls", "isLive" : false }
        ]
        """.data(using: .utf8)!


        do {
            return try JSONDecoder().decode([ScheduleModel].self, from: schedulesJson)
        } catch {
            debugPrint(error)
            return []
        }
    }
}
