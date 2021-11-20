//
//  BreedsRequest.swift
//  TheDogs
//
//  Created by Danilo Lago on 20/11/2021.
//

import Foundation

class BreedsRequests: NSObject {
    static func getBreeds(params: [String: Any]? = nil, completion: @escaping (Result<[Breed], Error>)->Void) {
        APIService.get("https://api.thedogapi.com/v1/breeds", params, completion: completion)
    }
}
