//
//  UIImageView+Extensions.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func loadImage(urlString: String?, placeholder: String, completion: (() -> Void)? = nil) {
        if let _url = urlString, let url = URL(string: _url) {
            let placeholderImage = UIImage(named: placeholder)
            self.af.setImage(withURL: url, placeholderImage: placeholderImage, completion:  { newImage in
                self.image = newImage.value
                completion?()
            })
        }
    }
}
