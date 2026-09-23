//
//  ProductListViewModel.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 23/09/2026.
//

import Foundation
import Observation

enum ProductListState: Equatable {
    case loading
    case loaded([Product])
    case error(String)
}

@MainActor
@Observable
final class ProductListViewModel {
    
    @ObservationIgnored
    private let productService: any ProductServiceProtocol
    
    var state: ProductListState = .loading
    var basket = Basket()
    
    init(productService: any ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }
    
    func fetchProducts() async {
        state = .loading
        
        do {
            let productResponse = try await productService.fetchProductList()
            state = .loaded(productResponse.products)
        } catch  let error as APIError {
            state = .error(error.userMessage)
        } catch {
            state = .error("Something went wrong. Please try again.")
        }
    }
    
    func addToBasket(_ product: Product) {
        basket.add(product)
    }
}

