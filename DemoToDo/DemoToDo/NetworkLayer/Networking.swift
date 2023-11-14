//
//  Networking.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation

protocol Networking {
    
    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
extension Networking {
    
    // MARK: - Todo url Request.
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url, delegate: nil)
    }
    // MARK: - Todo URLRequest.
    func data(from url: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: url, delegate: nil)
    }
}
extension URLSession: Networking {}
