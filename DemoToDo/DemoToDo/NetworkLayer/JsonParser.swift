//
//  JsonParser.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation

protocol JsonParser {
    func parse<T: Decodable>(data: Data, type:T.Type)throws -> T
}

extension JsonParser {
    func parse<T: Decodable>(data: Data, type:T.Type)throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
           return try decoder.decode(T.self, from: data )
        } catch {
           throw NetworkError.parsingError
        }
    }
}
