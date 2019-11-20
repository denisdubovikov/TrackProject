//
//  TableViewCell.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 09/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
        
    lazy var cellTitleLabel: UILabel = {
        let label = UILabel()
        label.frame = self.frame
        return label
    }()
    
    lazy var cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.frame
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()

        cellImageView.image = nil
    }
    
    override func layoutSubviews() {
        
        addSubview(cellTitleLabel)
        addSubview(cellImageView)
    }
    
    
    
    override func awakeFromNib() {
                
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
