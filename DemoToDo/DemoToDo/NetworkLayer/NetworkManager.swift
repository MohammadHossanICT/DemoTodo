//
//  NetworkManager.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation

struct NetworkManager {
    
    private let urlSession: Networking
    init(urlSession: Networking = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager: Fetchable {
    func delete(id: Int) async throws -> Data {
        do {
            guard let url =  URL(string: Endpoint.updateToDoUrl + "\(id)") else { return Data()}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            let (data, _) = try await urlSession.data(from: urlRequest)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
    
    func put(isCompleted: Bool, id: Int) async throws -> Data {
        do {
            guard let url =  URL(string: Endpoint.updateToDoUrl + "\(id)") else { return Data()}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PUT"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let json: [String: Any] = ["completed": isCompleted]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            urlRequest.httpBody = jsonData
            let (data, _) = try await urlSession.data(from: urlRequest)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
    
    func get(url: URL) async throws -> Data {
        do {
            let (data, _) = try await urlSession.data(from: url)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
    
    func post(todo: String, isCompleted: Bool, userID: Int) async throws -> Data {
        do {
            guard let url =  URL(string: Endpoint.addToDoUrl) else { return Data()}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let json: [String: Any] = ["todo": todo, "completed": isCompleted, "userId": userID]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            urlRequest.httpBody = jsonData
            let (data, _) = try await urlSession.data(from: urlRequest)
            return data
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}
