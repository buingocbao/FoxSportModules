//
//  ChannelHeaderTableViewCell.swift
//  FoxSportModules
//
//  Created by BimBim on 3/28/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import UIKit

class ChannelHeaderTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(title: String, icon: String) {
        channelTitle.text = String(format: "Now on %@", title)
        channelIcon.image = UIImage(named: icon)
    }

    @IBOutlet weak var channelIcon: UIImageView!
    @IBOutlet weak var channelTitle: UILabel!
}
