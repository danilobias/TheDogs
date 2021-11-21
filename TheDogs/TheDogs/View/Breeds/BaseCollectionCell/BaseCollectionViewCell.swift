//
//  BaseCollectionViewCell.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    
    var breedCellViewModel : BreedCellViewModel? {
        didSet {
            self.showBreedInfo()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func showBreedInfo() {
        breedName.text = breedCellViewModel?.name
    }
}
