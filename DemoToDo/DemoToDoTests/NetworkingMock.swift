//
//  NetworkingMock.swift
//  DemoToDoTests
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation
@testable import DemoToDo

class NetworkingMock: Networking {
    
    static var data: Data?
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        guard let data = NetworkingMock.data else {
            throw NetworkError.dataNotFound
        }
        return (data, URLResponse())
    }
    
    func data(from url: URL,
              delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        guard let data = NetworkingMock.data else {
            throw NetworkError.dataNotFound
        }
        return (data, URLResponse())
    }
}
