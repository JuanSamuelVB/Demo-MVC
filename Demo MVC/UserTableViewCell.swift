//
//  UserTableViewCell.swift
//  Demo MVC
//
//  Created by isc on 11/29/16.
//  Copyright © 2016 isc. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red: 255.0/255.0, green: 244.0/255.0, blue: 168.0/255.0, alpha: 1)
        self.selectedBackgroundView = bgColorView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
