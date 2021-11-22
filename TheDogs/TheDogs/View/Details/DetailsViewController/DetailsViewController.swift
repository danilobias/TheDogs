//
//  DetailsViewController.swift
//  TheDogs
//
//  Created by Danilo Lago on 22/11/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedCategory: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var temperament: UILabel!
    
    var breedDetails: DetailsBreedsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Details"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        showDetails()
    }
    
    // MARK: - Layout
    func showDetails() {
        guard let details = breedDetails else { return }
        
        breedImage.superview?.isHidden = !details.hasImage
        if details.hasImage {
            
            breedImage.layer.cornerRadius = breedImage.frame.size.height / 2.0
            breedImage.layer.borderColor = UIColor.systemGray2.cgColor
            breedImage.layer.borderWidth = 1.0
            
            breedImage.loadImage(urlString: details.image, placeholder: Constants.Placeholders.imagePlaceholder) {
                self.breedImage.contentMode = .scaleAspectFill
            }
        }
        
        breedName.text = "Name: " + details.name
        breedCategory.text = "Category: " +  details.category
        origin.text = "Origin: " +  details.origin
        temperament.text = "Temperament: " + details.temperament
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
