//
//  Product.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 22/09/2026.
//

import Foundation

struct Product: Decodable, Identifiable, Sendable, Equatable {
    let id: String
    let name: String
    let brand: String
    let category: String
    let memberPricePence: Int
    let rrpPence: Int
    let stock: Int
    let rating: Double?
    let benefits: [String]
    let imageURL: String
    let description: String
}
