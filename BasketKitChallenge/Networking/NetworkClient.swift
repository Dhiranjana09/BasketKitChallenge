//
//  NetworkClient.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 22/09/2026.
//

import Foundation


protocol NetworkClientProtocol: Sendable {
    func request<T: Decodable & Sendable>(_ url: URL) async throws -> T
}

struct NetworkClient: NetworkClientProtocol, Sendable {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable & Sendable>(_ url: URL) async throws -> T {
        let data: Data
        let response: URLResponse
        
        do {
            (data, response) = try await session.data(from: url)
        } catch {
            throw APIError.networkError(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.httpError(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
}
