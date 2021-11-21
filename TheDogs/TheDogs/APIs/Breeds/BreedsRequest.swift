//
//  BreedsRequest.swift
//  TheDogs
//
//  Created by Danilo Lago on 20/11/2021.
//

import Foundation

protocol BreedsServiceProtocol: ServiceInitializerProtocol {
    func getBreeds(params: [String: Any]?, completion: @escaping (Result<[Breed], Error>)->Void)
    func searchBreeds(params: [String: Any]?, completion: @escaping (Result<[Breed], Error>)->Void)
}

class BreedsRequests: BreedsServiceProtocol {
    var apiService: APIServiceProtocol
    
    required init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func getBreeds(params: [String: Any]? = nil, completion: @escaping (Result<[Breed], Error>)->Void) {
        apiService.get(Constants.APIUrls.getBreeds, params, completion: completion)
    }
    
    func searchBreeds(params: [String: Any]? = nil, completion: @escaping (Result<[Breed], Error>)->Void) {
        apiService.get(Constants.APIUrls.searchBreeds, params, completion: completion)
    }
}
