//
//  Basket.swift
//  BasketKitChallenge
//
//  Created by Dhiranjana Yadav on 23/09/2026.
//

import Foundation

struct Basket {
    private var quantities: [String : Int] = [:]
    private var products: [String: Product] = [:]
    
    mutating func add(_ product: Product) {
        let currentQuantity = quantities[product.id, default: 0]
        
        guard currentQuantity < product.stock else {
            return
        }
        
        quantities[product.id] = currentQuantity + 1
        products[product.id] = product
    }
    
    func quantity(for productID: String) -> Int {
        quantities[productID, default: 0]
    }
    
    var totalPence: Int {
        quantities.reduce(0) { total, item in
            guard let product = products[item.key] else {
                return total
            }
            
            return total + product.memberPricePence * item.value
            
        }
    }
}

