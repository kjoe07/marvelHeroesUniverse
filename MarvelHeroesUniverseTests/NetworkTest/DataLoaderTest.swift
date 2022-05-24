//
//  DataLoaderTest.swift
//  MarvelHeroesUniverseTests
//
//  Created by kjoe on 5/18/22.
//

import XCTest
@testable import MarvelHeroesUniverse
class DataLoaderTest: XCTestCase {
    
    let configuration = URLSessionConfiguration.default
    var dataLoader: DataLoaderProtocol!
    var expectation: XCTestExpectation!
    
    override func setUpWithError() throws {
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        dataLoader = NetworkLoader(session: urlSession)
    }

    override func tearDownWithError() throws {
       dataLoader = nil
        expectation = nil
    }
    
    func testNetWorkloaderConformToDataLoader() {
        dataLoader = NetworkLoader()
        XCTAssertNotNil(dataLoader as DataLoaderProtocol)
    }

    func testResponseWithNo200ResponseCode() {
        expectation = expectation(description: "Expectation")
        MockURLProtocol.requestHandler = { _ in
          let response = HTTPURLResponse(url: URL(string: baseUrl)!,
                                         statusCode: 400,
                                         httpVersion: nil,
                                         headerFields: nil)!
          return (response, Data())
        }
        let request = URLRequest(url: URL(string: baseUrl)!)

        dataLoader.loadData(request: request, completion: { (result: Result<Data, Error>) in
            switch result {
            case .success:
                XCTFail("Success response was not expected.")
            case .failure:
                self.expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 1.0)
      }
    
    func testResponseWithNo401ResponseCode() {
        expectation = expectation(description: "Expectation")
        MockURLProtocol.requestHandler = { _ in
          let response = HTTPURLResponse(url: URL(string: baseUrl)!,
                                         statusCode: 401,
                                         httpVersion: nil,
                                         headerFields: nil)!
          return (response, Data())
        }
        let request = URLRequest(url: URL(string: baseUrl)!)

        dataLoader.loadData(request: request, completion: { result in
            switch result {
            case .success:
                XCTFail("Success response was not expected.")
            case .failure(let error):
                print(error.localizedDescription)
                guard let error = error as? ServerError else {
                  self.expectation.fulfill()
                  return
                }
                XCTAssertEqual(error.localizedDescription,
                               ServerError.unAuthorized.localizedDescription,
                               "Client unAuthorized.")
                self.expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 1.0)
      }
    func testResponseWithNo501ResponseCode() {
        expectation = expectation(description: "Expectation")
        MockURLProtocol.requestHandler = { _ in
          let response = HTTPURLResponse(url: URL(string: baseUrl)!,
                                         statusCode: 501,
                                         httpVersion: nil,
                                         headerFields: nil)!
          return (response, Data())
        }
        let request = URLRequest(url: URL(string: baseUrl)!)

        dataLoader.loadData(request: request, completion: { result in
            switch result {
            case .success:
                XCTFail("Success response was not expected.")
            case .failure(let error):
                print(error.localizedDescription)
                guard let error = error as? ServerError else {
                  self.expectation.fulfill()
                  return
                }
                XCTAssertEqual(error.localizedDescription,
                               "Internal server error",
                               "Client unAuthorized.")
                self.expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 1.0)
      }
    
    func testSuccessfulResponse() {
        expectation = expectation(description: "Expectation")
        let jsonString = "a long string nom important for this pourpouse"
        let data = jsonString.data(using: .utf8)

        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url.absoluteString == baseUrl else {
              throw ServerError.invalidRequest
          }
          let response = HTTPURLResponse(url: URL(string: baseUrl)!,
                                         statusCode: 200,
                                         httpVersion: nil,
                                         headerFields: nil)!
          return (response, data)
        }
            let request = URLRequest(url: URL(string: baseUrl)!)
        dataLoader.loadData(request: request, completion: { result in
                switch result {
                case .success(let post):
                    XCTAssertTrue(post.isEmpty == false)
                    self.expectation.fulfill()
                case .failure(let error):
                    XCTFail("Error was not expected: \(error)")
                }
            })
        wait(for: [expectation], timeout: 1.0)
      }
    func testSuccessfulResponseWithNullData() {
        expectation = expectation(description: "Expectation")
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url.absoluteString == baseUrl else {
              throw ServerError.invalidRequest
          }
          let response = HTTPURLResponse(url: URL(string: baseUrl)!,
                                         statusCode: 200,
                                         httpVersion: nil,
                                         headerFields: nil)!
          return (response, nil)
        }
            let request = URLRequest(url: URL(string: baseUrl)!)
        dataLoader.loadData(request: request, completion: { result in
                switch result {
                case .success:
                    XCTFail("Unexpected Success")
                case .failure:
                    self.expectation.fulfill()
                }
            })
        wait(for: [expectation], timeout: 1.0)
      }
    
    func testNetworkLoaderGetServerErrorResponse() throws {
        expectation = expectation(description: "Expectation")
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url.absoluteString == baseUrl else {
                throw ServerError.invalidRequest
            }
            let response = HTTPURLResponse(url: URL(string: baseUrl)!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, nil)
        }
            let request = URLRequest(url: URL(string: baseUrl)!)
        dataLoader.loadData(request: request, completion: { result in
                switch result {
                case .success:
                    XCTFail("Success was not expected:")
                case .failure:
                    self.expectation.fulfill()
                }
            })
        wait(for: [expectation], timeout: 1.0)
    }

}
