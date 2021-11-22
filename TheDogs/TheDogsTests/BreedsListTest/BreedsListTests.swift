//
//  BreedsListTests.swift
//  TheDogsTests
//
//  Created by Danilo Lago on 22/11/2021.
//

import XCTest
@testable import TheDogs

class BreedsListTests: XCTestCase {

    var sut: BreedsRequests!
    
    var mockAPIService: MockAPIService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIService = MockAPIService(outputObjectsSuffix: "ListResult")
        sut = BreedsRequests(apiService: mockAPIService)
        XCTAssertNotNil(sut)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
    }

    func testBreedsListResult() throws {
        checkMockConfigs()
        
        let expectation = XCTestExpectation(description: "tesMessageTypesResultOuput fail on return")
        
        sut.getBreeds { [weak self]  result in
            XCTAssertNotNil(self)
            self?.successResultOuput(output: result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testBreedsListErrorAPIResult() throws {
        checkMockConfigs()
        
        mockAPIService.errorNetwork(false)
        mockAPIService.errorAPI(true)
        
        let expectation = XCTestExpectation(description: "tesMessageTypesResultOuput fail on return")
        
        sut.getBreeds { [weak self]  result in
            XCTAssertNotNil(self)
            self?.errorResultOutput(output: result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testBreedsListErrorNetworkResult() throws {
        checkMockConfigs()
        
        mockAPIService.errorNetwork(true)
        mockAPIService.errorAPI(false)
        
        let expectation = XCTestExpectation(description: "tesMessageTypesResultOuput fail on return")
        
        sut.getBreeds { [weak self]  result in
            XCTAssertNotNil(self)
            self?.errorResultOutput(output: result)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

    
    //MARK: - Generic tests functions
    func checkMockConfigs() {
        XCTAssertNotNil(mockAPIService)
        XCTAssertNotNil(sut)
    }

    func successResultOuput<T: Decodable>(output: Result<T, Error>) {
        switch output {
        case .success(let object):
            XCTAssertNotNil(object)
        default:
            XCTFail()
            break
        }
    }

    func errorResultOutput<T: Decodable>(output: Result<T, Error>) {
        switch output {
        case .success(_):
            XCTFail()
        case .unknowError(let error):
            XCTAssertNotNil(error)
        case .apiFailure(let error):
            XCTAssertNotNil(error)
        case .networkFailure(let error):
            XCTAssertNotNil(error)
        }
    }
}
