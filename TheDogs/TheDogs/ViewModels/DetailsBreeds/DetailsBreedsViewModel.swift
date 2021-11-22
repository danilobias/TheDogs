//
//  DetailsBreedsViewModel.swift
//  TheDogs
//
//  Created by Danilo Lago on 22/11/2021.
//

import Foundation

struct DetailsBreedsViewModel {
    let name: String
    let image: String?
    let origin: String
    let temperament: String
    let category: String
    let hasImage: Bool
    
    init(name: String, image: String?, origin: String?, temperament: String?, category: String?) {
        self.name = name
        self.image = image
        self.origin = origin ?? "-"
        self.temperament = temperament ?? "-"
        self.category = category ?? "-"
        self.hasImage = image != nil
    }
}
