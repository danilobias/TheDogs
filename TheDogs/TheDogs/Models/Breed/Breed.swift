//
//  Breed.swift
//  TheDogs
//
//  Created by Danilo Lago on 20/11/2021.
//

import Foundation

struct Breed: Codable {
    let bredFor: String?
    let breedGroup: String?
    let height: Measures
    let identifier: Int
    let image: Image
    let lifeSpan: String
    let name: String
    let origin: String?
    let reference_image_id: String
    let temperament: String?
    let weight: Measures
    
    enum CodingKeys: String, CodingKey {
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case identifier = "id"
        case lifeSpan = "life_span"
        case reference_image_id = "reference_image_id"
        case height, image, name, origin, temperament, weight
    }
}
