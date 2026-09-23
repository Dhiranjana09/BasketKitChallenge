//
//  ProductListView.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 23/09/2026.
//

import SwiftUI

struct ProductListView: View {
    
    @State private var viewModel: ProductListViewModel
    
    init(viewModel: ProductListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .task {
                await viewModel.fetchProducts()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading products...")
            
        case .loaded(let products):
            productList(products)
            
        case .error(let message):
            errorView(message)
        }
    }
    
    private func productList(_ products: [Product]) -> some View {
        VStack(spacing: 0) {
            List(products) { product in
                ProductRowView(
                    product: product,
                    onAddToBasket: {
                        viewModel.addToBasket(product)
                    }
                )
            }
            
            Text(
                "Basket Total: £\(Double(viewModel.basket.totalPence) / 100, specifier: "%.2f")"
            )
            .font(.headline)
            .padding()
        }
        .navigationTitle("Products")
    }
    
    private func errorView(_ message: String) -> some View {
        ContentUnavailableView(
            "Unable to Load Products",
            systemImage: "exclamationmark.triangle",
            description: Text(message)
        )
    }
}


#Preview {
    ProductListView(viewModel: ProductListViewModel())
}
