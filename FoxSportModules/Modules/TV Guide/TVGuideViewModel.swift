//
//  TVGuideViewModel.swift
//  FoxSportModules
//
//  Created by BimBim on 3/28/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

enum TableViewModel {
    case title(ChannelModel)
    case content(ScheduleModel)
}

enum MultipleSectionModel {
    case ChannelSection(title: String, items: [SectionItem])
    case ScheduleSection(title: String, items: [SectionItem])
}

enum SectionItem {
    case ChannelItem(channel: ChannelModel)
    case ScheduleItem(schedule: ScheduleModel)
}

extension MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem

    var items: [SectionItem] {
        switch  self {
        case .ChannelSection(title: _, items: let items):
            return items.map {$0}
        case .ScheduleSection(title: _, items: let items):
            return items.map {$0}
        }
    }
    
    init(original: MultipleSectionModel, items: [Item]) {
        switch original {
        case let .ChannelSection(title: title, items: _):
            self = .ChannelSection(title: title, items: items)
        case let .ScheduleSection(title, _):
            self = .ScheduleSection(title: title, items: items)
        }
    }
}

class TVGuideViewModel: RxViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    var stateVariable: Variable<State> = Variable(.idle)

    var sections: [MultipleSectionModel] = []

    //Input
    let channel: ChannelModel!
    let schedules: [ScheduleModel]!
    let observableSchedules: Variable<[ScheduleModel]> = Variable([])

    //Output

    init(channel: ChannelModel, schedules: [ScheduleModel]) {
        self.channel = channel
        self.schedules = schedules
        observableSchedules.value = schedules
        let scheduleItems = schedules.map { schedule in
            return SectionItem.ScheduleItem(schedule: schedule)
        }
        self.sections = [
            .ChannelSection(title: "Section 1", items: [.ChannelItem(channel: channel)]),
            .ScheduleSection(title: "Section 2", items: scheduleItems)
        ]
    }
}
