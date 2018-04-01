//
//  ChannelTableViewCell.swift
//  FoxSportModules
//
//  Created by BimBim on 3/28/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(startTime: String, endTime: String, description: String, isLive: Bool) {
        timeLabel.text = startTime
        channelShowTime.text = String(format: "%@ - %@", startTime, endTime)
        channelDescription.text = description
        liveLabel.isHidden = !isLive

        if isLive {
            let highlightColor = UIColor(red: 240/255, green: 71/255, blue: 41/255, alpha: 1)
            timeLabel.textColor = highlightColor
            channelDescription.textColor = highlightColor
        } else {
            timeLabel.textColor = UIColor.black
            channelDescription.textColor = UIColor.black
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var channelDescription: UILabel!
    @IBOutlet weak var channelShowTime: UILabel!
}
