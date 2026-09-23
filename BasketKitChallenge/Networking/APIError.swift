//
//  APIError.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 22/09/2026.
//

import Foundation

enum APIError:Error, Sendable {
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
    case networkError(Error)
}

extension APIError {

    var userMessage: String {
        switch self {
        case .invalidResponse:
            return "We couldn't connect to the server. Please try again."

        case .httpError:
            return "We're having trouble loading the products. Please try again."

        case .decodingError:
            return "We couldn't load the products right now. Please try again."

        case .networkError:
            return "Please check your internet connection and try again."
      }
    }
}
