//
//  DogBreedTableViewCell.swift
//  Dogs
//
//  Created by Russell Wunder on 18.06.19.
//  Copyright © 2019 Russell Snyder. All rights reserved.
//

import UIKit

class DogBreedTableViewCell: UITableViewCell {

    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
