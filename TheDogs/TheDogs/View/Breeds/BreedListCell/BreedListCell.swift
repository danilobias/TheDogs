//
//  BreedTableViewCell.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

class BreedListCell: BaseCollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        breedImage.layer.cornerRadius = breedImage.frame.size.height / 2.0
        breedImage.layer.borderColor = UIColor.systemGray2.cgColor
        breedImage.layer.borderWidth = 1.0
    }
}
