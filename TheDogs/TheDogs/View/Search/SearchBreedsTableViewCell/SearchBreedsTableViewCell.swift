//
//  SearchBreedsTableViewCell.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

class SearchBreedsTableViewCell: UITableViewCell {
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
        breedImage.loadImage(urlString: breedCellViewModel?.image, placeholder: Constants.Placeholders.imagePlaceholder) {
            self.breedImage.contentMode = .scaleAspectFill
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
