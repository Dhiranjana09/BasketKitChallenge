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
                    quantityInBasket: viewModel.quantityInBasket(for: product),
                    canAddToBasket: viewModel.canAddToBasket(product),
                    onAddToBasket: {
                        viewModel.addToBasket(product)
                    }
                )
            }

            basketSummary
        }
        .navigationTitle("Products")
    }

    private var basketSummary: some View {
        HStack {
            Text("Basket (\(viewModel.basket.itemCount))")
            Spacer()
            Text(
                "£\(Double(viewModel.basket.totalPence) / 100, specifier: "%.2f")"
            )
        }
        .font(.headline)
        .padding()
        .background(.bar)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "Basket, \(viewModel.basket.itemCount) items, total £\(Double(viewModel.basket.totalPence) / 100, specifier: "%.2f")"
        )
    }
    
    private func errorView(_ message: String) -> some View {
        ContentUnavailableView {
            Label(
                "Unable to Load Products",
                systemImage: "exclamationmark.triangle"
            )
        } description: {
            Text(message)
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.fetchProducts()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}


#Preview {
    ProductListView(viewModel: ProductListViewModel())
}
