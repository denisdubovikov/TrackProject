//
//  TableViewCell.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 09/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var TableViewCellTitle: UILabel!
    @IBOutlet weak var TableViewCellImageView: UIImageView!
    
    override func awakeFromNib() {
                
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
