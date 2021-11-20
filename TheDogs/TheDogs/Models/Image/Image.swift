//
//  Image.swift
//  TheDogs
//
//  Created by Danilo Lago on 20/11/2021.
//

import Foundation

struct Image: Codable {
    let height: Int
    let identifier: String
    let url: String
    let width: Int
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case height, url, width
    }
}
