//
//  BreedTableViewCell.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit

struct BreedTableCellViewModel {
    var name: String
    var image: String
}

class BreedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    
    var breedCellViewModel : BreedTableCellViewModel? {
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
