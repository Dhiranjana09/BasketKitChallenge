//
//  ProductResponse.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 22/09/2026.
//

import Foundation

struct ProductResponse: Decodable, Sendable {
    let currency: String
    let products: [Product]
}
