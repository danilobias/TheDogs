//
//  Constants.swift
//  TheDogs
//
//  Created by Danilo Lago on 21/11/2021.
//

import Foundation

struct Constants {
    
    //MARK: URL's
    struct APIPreffix {
        static let urlPreffix: String = "https://api.thedogapi.com/v1"
    }
    
    struct Methods {
        static let breeds: String = "/breeds"
        static let search: String = "/search"
    }
    
    struct APIUrls {
        static let getBreeds: String = Constants.APIPreffix.urlPreffix + Methods.breeds
        static let searchBreeds: String = Constants.APIPreffix.urlPreffix + Methods.search
    }
}
