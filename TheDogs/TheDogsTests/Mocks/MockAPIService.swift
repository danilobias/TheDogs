//
//  MockAPIService.swift
//  TheDogsTests
//
//  Created by Danilo Lago on 22/11/2021.
//

import Foundation
import TheDogs

class MockAPIService: APIServiceProtocol {
    private var testErrorAPI: Bool = false
    private var testErrorNetwork: Bool = false
    private var objectsSuffix: String
    
    required init(outputObjectsSuffix: String?) {
        objectsSuffix = outputObjectsSuffix ?? ""
    }
    
    func get<T: Decodable>(_ url: String, _ parameters: [String:Any]? = nil,  completion: @escaping (Result<T, Error>) -> Void) {
        let result: Result<T, Error>
        
        if testErrorAPI {
            result = .apiFailure( MockGenericErrorAPI(error: ServiceErrorAPI.parsingFailed) )
        } else if testErrorNetwork {
            result = .networkFailure(ServiceErrorAPI.noData)
        } else {
            result = loadMockJSON()
        }
        
        completion(result)

    }
    
    func post<T: Decodable>(_ url: String, _ parameters: [String:Any]?,  completion: @escaping (Result<T, Error>) -> Void) {
        let result: Result<T, Error>
        
        if testErrorAPI {
            result = .apiFailure( MockGenericErrorAPI(error: ServiceErrorAPI.parsingFailed) )
        } else if testErrorNetwork {
            result = .networkFailure(ServiceErrorAPI.noData)
        } else {
            result = loadMockJSON()
        }
        
        completion(result)
    }
    
    private func loadMockJSON<T: Decodable>() -> (Result<T, Error>) {
        let result: Result<T, Error>
        let objectName = String(describing: T.self)
        let outputAndSuffix = objectName + objectsSuffix

        let fileName = outputAndSuffix.filter {
            return ($0 != "<" && $0 != ">")
        }

        if let fileURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") {

            do {
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                let output = try JSONDecoder().decode(T.self, from: data)
                result = .success(output)
            } catch {
                debugPrint("Object: \(objectName) doesn't match with content of \(fileName)")
                debugPrint("error: \(error)")
                result = .apiFailure( MockGenericErrorAPI(error: error) )
            }

        } else {
            debugPrint("missing file named: \(fileName)")
            result = .apiFailure( MockGenericErrorAPI(error: ServiceErrorAPI.parsingFailed))
        }

        return result
    }
        
    func errorNetwork(_ error: Bool) {
        testErrorNetwork = error
    }
    
    func errorAPI(_ error: Bool) {
        testErrorAPI = error
    }
}

struct MockGenericErrorAPI: GeneralErrorAPIProtocol {
    internal(set) public var code: String
    internal(set) public var message: String?
    var stackTrace: String?

    internal init(error: Error) {
        switch error {
        case let error as ServiceErrorAPI:
            self.code = error.rawValue
        case let error as URLError:
            self.code = "\(error.code)"
        default:
            self.code = "unknown"
        }

        self.message = error.localizedDescription
    }
}
