import XCTest
@testable import BasketKitChallenge

final class BasketKitChallengeTests: XCTestCase {
    
    func testAddingProductIncreaseQuantity() {
        
        // Given
        let product = makeProduct(stock: 5)
        var basket = Basket()
        
        //When
        basket.add(product)
        basket.add(product)
        
        //Then
        XCTAssertEqual(
            basket.quantity(for: product.id),
            2
        )
    }
    
    func testCannotAddMoreThanAvailableStock() {
        //Given
        let product = makeProduct(stock: 2)
        var basket = Basket()
        
        //When
        basket.add(product)
        basket.add(product)
        basket.add(product)
        
        //Then
        XCTAssertEqual(
            basket.quantity(for: product.id),
            2
        )
    }
    
    func testSoldProductCannotBeAdded() {
        //Given
        let product = makeProduct(stock: 0)
        var basket = Basket()
        
        //When
        basket.add(product)
        
        //Then
        XCTAssertEqual(
            basket.quantity(for: product.id),
            0
        )
    }
    
    func testTotalUsesMemberPrice() {
        //Given
        let product = makeProduct(
            stock: 5,
            memberPricePence: 1400
        )
        
        var basket = Basket()
        
        //When
        basket.add(product)
        basket.add(product)
        
        //Then
        XCTAssertEqual(
            basket.totalPence,
            2800
        )
    }
    
    
    
    private  func makeProduct(
        stock: Int,
        memberPricePence: Int = 1400
    ) -> Product {
        Product(
            id: "1",
            name: "Vitamin C Serum",
            brand: "Beauty Pie",
            category: "Skincare",
            memberPricePence: memberPricePence,
            rrpPence: 6800,
            stock: stock,
            rating: 4.5,
            benefits: [],
            imageURL: "",
            description: ""
        )
    }
}

