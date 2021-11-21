//
//  Protocols.swift
//  TheDogs
//
//  Created by Danilo Lago on 20/11/2021.
//

import Foundation

protocol ServiceInitializerProtocol {
    init(apiService: APIServiceProtocol)
}

protocol Countable {
    func numberOfRows() -> Int
}

protocol ListProtocol: Countable {
    func cellViewModel<T>(indexPath: IndexPath) -> T?
}

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
    func get<T: Decodable>(_ url: String, _ parameters: [String:Any]?,  completion: @escaping (Result<T, Error>) -> Void)
    func post<T: Decodable>(_ url: String, _ parameters: [String:Any]?,  completion: @escaping (Result<T, Error>) -> Void)
}
