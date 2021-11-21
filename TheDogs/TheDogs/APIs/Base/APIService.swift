//
//  APIService.swift
//  TheDogs
//
//  Created by Danilo Lago on 20/11/2021.
//

import Foundation
import Alamofire

class APIService: APIServiceProtocol {
    
    lazy var timeout: TimeInterval = 10.0
    
    lazy var basicHeaders: HTTPHeaders = [
        "accept-language": "en",
        "cache-control": "no-cache",
        "x-api-key": "0dde82cb-9a5b-4161-a264-32b6ea234f33"
    ]
        
    func get<T: Decodable>(_ url: String, _ parameters: [String:Any]? = nil,  completion: @escaping (Result<T, Error>) -> Void) {
        let finalUrl = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? url
        
        AF.request(finalUrl, method: .get, parameters: parameters, encoding: URLEncoding.queryString,
                   headers: basicHeaders, requestModifier: { $0.timeoutInterval = self.timeout }).validate().responseDecodable(of: T.self) { response in
//            debugResponse(response: response)
            self.handleResponse(response: response, completion: completion)
        }
    }

    func post<T: Decodable>(_ url: String, _ parameters: [String:Any]?,  completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: basicHeaders, requestModifier: { $0.timeoutInterval = self.timeout }).validate().responseDecodable(of: T.self) { response in
//            debugResponse(response: response)
            self.handleResponse(response: response, completion: completion)
        }
    }
    
    private func handleResponse<T: Decodable>(response: DataResponse<T, AFError>, completion: (Result<T, Error>) -> Void) {
        let result: Result<T, Error>
        switch response.result{
        case .success(let object):
            result = .success(object)
        case .failure(let error):
            result = .unknowError(error)
            break
        }
        return completion(result)

    }
    
    static func debugResponse<T: Decodable>(response: DataResponse<T, AFError>) {
        print(response.request ?? "Nil response.request")  // original URL request
        print(response.response ?? "Nil response.reponse ") // HTTP URL response
        print(response.data ?? "Nil response.data")     // server data
        print(response.result)   // result of response serialization
        print("Error: \(String(describing: response.error))")
    }
}
