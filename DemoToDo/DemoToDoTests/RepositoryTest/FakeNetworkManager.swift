//
//  FakeNetworkManager.swift
//  DemoToDoTests
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation
@testable import DemoToDo

class FakeNetworkManager: Fetchable {
    func post(todo: String, isCompleted: Bool, userID: Int) async throws -> Data {
        return Data()
    }
    
    func put(isCompleted: Bool, id: Int) async throws -> Data {
        return Data()
    }
    
    func delete(id: Int) async throws -> Data {
        return Data()
    }
    
    func get(url: URL) async throws -> Data {
        do {
            let bundle = Bundle(for: FakeNetworkManager.self)
            guard let path =  bundle.url(forResource:url.absoluteString, withExtension: "json") else {
                throw NetworkError.invalidURL
            }
            let data = try Data(contentsOf: path)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}
