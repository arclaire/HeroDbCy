//
//  CellCollectionHeroes.swift
//  HeroDbCy
//
//  Created by Lucy on 21/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class CellCollectionHeroes: UICollectionViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDataToUI(model: ModelHeroes?, hideTitle: Bool = false) {
        if let data = model {
            self.labelTitle.text = data.localized_name
            if let url = data.getURlImageFullString() {
                self.img.setImage(url)
            }
            
        }
       
        self.labelTitle.isHidden = hideTitle
    }

}
