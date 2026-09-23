//
//  ProductService.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 23/09/2026.
//

import Foundation

protocol ProductServiceProtocol: Sendable {
    func fetchProductList() async throws -> ProductResponse
}

final class ProductService: ProductServiceProtocol, Sendable {

    private let networkClient: any NetworkClientProtocol

    init(
        networkClient: any NetworkClientProtocol = NetworkClient()
    ) {
        self.networkClient = networkClient
    }

    func fetchProductList() async throws -> ProductResponse {
        try await networkClient.request(
            Constants.productCatalogURL
        )
    }
}
