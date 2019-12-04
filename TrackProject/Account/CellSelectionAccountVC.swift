//
//  CellSelectorAccountVC.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 23/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class CellSelectionAccountVC: UITableViewCell {
    
    var accView = AccountViewController()
    
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.frame = self.frame
        
        return label
    }()
    
    lazy var cellButtonSelected: UIButton! = {
        let button = UIButton()
        button.frame = self.frame
        button.addTarget(self, action: #selector(cellButtonSelectedPressed), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    lazy var cellTickImageView: UIImageView! = {
        let tickImageView = UIImageView()
        tickImageView.frame = self.frame
        
        return tickImageView
    }()
    
    @IBAction func cellButtonSelectedPressed() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        
        addSubview(cellLabel)
        addSubview(cellButtonSelected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
