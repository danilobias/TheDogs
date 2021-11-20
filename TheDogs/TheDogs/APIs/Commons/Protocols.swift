//
//  Protocols.swift
//  TheDogs
//
//  Created by Danilo Lago on 20/11/2021.
//

import Foundation

public protocol GeneralErrorAPIProtocol: Error, Codable {
    var code: String { get }
    var message: String? { get }
}

public enum Result<Success, Failure: Error> {
    case success(Success)
    case apiFailure(GeneralErrorAPIProtocol)
    case networkFailure(Error)
    case unknowError(Failure)
}

public protocol APIServiceProtocol {
    static func get<T: Decodable>(_ url: String, _ parameters: [String:Any]?,  completion: @escaping (Result<T, Error>) -> Void)
    static func post<T: Decodable>(_ url: String, _ parameters: [String:Any]?,  completion: @escaping (Result<T, Error>) -> Void)
}
