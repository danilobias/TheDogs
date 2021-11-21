//
//  SearchBreedsTableViewCell.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

class SearchBreedsTableViewCell: UITableViewCell {
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedGroup: UILabel!
    @IBOutlet weak var breedOrigin: UILabel!
    
    var breedCellViewModel : SearchBreedCellViewModel? {
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
        breedGroup.text = breedCellViewModel?.group
        breedOrigin.text = breedCellViewModel?.origin
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
