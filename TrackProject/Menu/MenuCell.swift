//
//  MenuCell.swift
//  TrackProject
//
//  Created by Денис Дубовиков on 30/11/2019.
//  Copyright © 2019 Денис Дубовиков. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    lazy var cellMenuOptionLabel: UILabel = {
        let label = UILabel()
        label.frame = self.frame
        return label
       }()
       
    lazy var cellMenuOptionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = self.frame
        imageView.contentMode = .scaleAspectFit
        return imageView
   }()
   
   override func prepareForReuse() {
       super.prepareForReuse()

   }
   
   override func layoutSubviews() {
       
       addSubview(cellMenuOptionLabel)
       addSubview(cellMenuOptionImage)
   }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        
        addSubview(cellMenuOptionImage)
        cellMenuOptionImage.translatesAutoresizingMaskIntoConstraints = false
        cellMenuOptionImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellMenuOptionImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        cellMenuOptionImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cellMenuOptionImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(cellMenuOptionLabel)
        cellMenuOptionLabel.translatesAutoresizingMaskIntoConstraints = false
        cellMenuOptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cellMenuOptionLabel.leftAnchor.constraint(equalTo: cellMenuOptionImage.rightAnchor, constant: 12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
