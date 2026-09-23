//
//  ProductRowView.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 23/09/2026.
//

import SwiftUI

struct ProductRowView: View {
   
    let product : Product
    let onAddToBasket: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(product.brand)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Text(product.name)
                .font(.headline)
            
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text(memberPrice)
                    .font(.headline)
                
                Text(rrpPrice)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .strikethrough()
            }
            
            if product.stock == 0 {
                Text("Sold Out")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }  else {
                Button ("Add to Basket"){
                    onAddToBasket()
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    private var memberPrice: String {
        formatPrice(product.memberPricePence)
    }
    
    private var rrpPrice: String {
        formatPrice(product.rrpPence)
    }
    
    private func formatPrice(_ pence: Int) -> String {
        String(format: "£%.2f", Double(pence) / 100)
    }
}

#Preview {
    ProductRowView(
        product: Product(
            id: "1",
            name: "Vitamin C Serum",
            brand: "Beauty Pie",
            category: "Skincare",
            memberPricePence: 1400,
            rrpPence: 6800,
            stock: 10,
            rating: 4.5,
            benefits: [],
            imageURL: "",
            description: ""
        ), onAddToBasket:{}
    )
}
