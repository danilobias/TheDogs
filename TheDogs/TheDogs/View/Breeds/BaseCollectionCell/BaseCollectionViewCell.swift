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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        breedImage.image = nil
        breedImage.contentMode = .center
    }
    
    private func showBreedInfo() {
        guard let breed = breedCellViewModel else { return }
        breedName.text = "Name: " + breed.name
        breedImage.loadImage(urlString: breed.image, placeholder: Constants.Placeholders.imagePlaceholder) {
            self.breedImage.contentMode = .scaleAspectFill
        }
    }
}
