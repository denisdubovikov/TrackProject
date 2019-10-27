//
//  CellSelectorAccountVC.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 23/10/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class CellSelectionAccountVC: UITableViewCell {
    
    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.frame = self.frame
        return label
    }()
    
    lazy var cellButtonSelected: UIButton! = {
        let button = UIButton()
        button.frame = self.frame
        button.addTarget(self, action: #selector(cellButtonSelectedPressed), for: .touchUpInside)
        return button
    }()
    
    @IBAction func cellButtonSelectedPressed() {
        if cellButtonSelected.backgroundColor != .green {
            cellButtonSelected.backgroundColor = .green
        } else {
            cellButtonSelected.backgroundColor = .blue
        }
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
