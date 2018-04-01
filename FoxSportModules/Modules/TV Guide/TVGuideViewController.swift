//
//  TVGuideViewController.swift
//  FoxSportModules
//
//  Created by BimBim on 3/28/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class TVGuideViewController: UIViewController {

    let viewModel = TVGuideViewModel(channel: ChannelFactory.generateChannelModel(),
                                     schedules: ChannelFactory.generateSchedulesOfChannel())

    override func loadView() {
        super.loadView()
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        bindDelegate()
    }

    @IBOutlet weak var calendarTitle: UILabel!
    @IBOutlet weak var channelTitle: UILabel!

    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var nextCalendarButton: UIButton!
    @IBOutlet weak var channelButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
}

// MARK: Handler functions
extension TVGuideViewController {
    func setupUI() {
        channelButton.layer.borderWidth = 1
        channelButton.layer.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1).cgColor
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    func bindUI() {
        /* Example for using RxDataSources
        let dataSource = TVGuideViewController.dataSource()
        Observable.just(viewModel.sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: viewModel.disposeBag)
        */
        viewModel.observableSchedules.asObservable().bind(to: tableView.rx.items(cellIdentifier: "ChannelCell")) { index, model, cell in
            guard let castedCell = cell as? ChannelTableViewCell else { return }
            castedCell.configureCell(startTime: model.startTime, endTime: model.endTime, description: model.description, isLive: model.isLive)
        }.disposed(by: viewModel.disposeBag)
    }
    
    func bindDelegate() {
        tableView.rx.setDelegate(self).disposed(by: viewModel.disposeBag)
    }
}

// MARK: TableView Delegate
extension TVGuideViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "ChannelHeaderCell") as? ChannelHeaderTableViewCell else { return nil }
        headerCell.configureCell(title: viewModel.channel.name, icon: viewModel.channel.icon)
        return headerCell
    }
}

/* Example for using RxDataSources
// MARK: TableView DataSource
extension TVGuideViewController {
    static func dataSource() -> RxTableViewSectionedReloadDataSource<MultipleSectionModel> {
        return RxTableViewSectionedReloadDataSource<MultipleSectionModel>(
            configureCell: { (dataSource, table, idxPath, _) in
                switch dataSource[idxPath] {
                case .ChannelItem(let channel):
                    guard let cell = table.dequeueReusableCell(withIdentifier: "ChannelHeaderCell", for: idxPath) as? ChannelHeaderTableViewCell else { return UITableViewCell() }
                    cell.configureCell(title: channel.name, icon: channel.icon)
                    return cell
                case .ScheduleItem(let schedule):
                    guard let cell = table.dequeueReusableCell(withIdentifier: "ChannelCell", for: idxPath) as? ChannelTableViewCell else { return UITableViewCell() }
                    cell.configureCell(startTime: schedule.startTime, endTime: schedule.endTime, description: schedule.description, isLive: schedule.isLive)
                    return cell
                }
        }, titleForHeaderInSection: { _, _ in
            return ""
        })
    }
}
 */
