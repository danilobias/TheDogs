//
//  BreedsRequest.swift
//  TheDogs
//
//  Created by Danilo Lago on 20/11/2021.
//

import Foundation

class BreedsRequests: NSObject {
    static func getBreeds(params: [String: Any]? = nil, completion: @escaping (Result<[Breed], Error>)->Void) {
        APIService.get(Constants.APIUrls.getBreeds, params, completion: completion)
    }
    
    static func searchBreeds(params: [String: Any]? = nil, completion: @escaping (Result<[Breed], Error>)->Void) {
        APIService.get(Constants.APIUrls.searchBreeds, params, completion: completion)
    }
}
