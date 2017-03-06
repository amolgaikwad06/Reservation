//
//  MyReservationsTableViewCell.swift
//  Reservation
//
//  Created by Amol Gaikwad on 2/19/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

class MyReservationsTableViewCell: UITableViewCell
{

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var partySizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
