//
//  CellTableRoles.swift
//  HeroDbCy
//
//  Created by Lucy on 22/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class CellTableRoles: UITableViewCell {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.labelTitle.textColor = UIColor.systemGray
                self.vwContainer.backgroundColor = UIColor.systemGray2
            } else {
                self.labelTitle.textColor = UIColor.systemBlue
                self.vwContainer.backgroundColor = UIColor.systemBackground
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelTitle.textColor = UIColor.systemBlue
        self.vwContainer.backgroundColor = UIColor.systemBackground
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
