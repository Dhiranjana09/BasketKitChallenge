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

    func testTotalCombinesMultipleProducts() {
        let firstProduct = makeProduct(
            id: "1",
            stock: 2,
            memberPricePence: 1_400
        )
        let secondProduct = makeProduct(
            id: "2",
            stock: 1,
            memberPricePence: 750
        )
        var basket = Basket()

        basket.add(firstProduct)
        basket.add(firstProduct)
        basket.add(secondProduct)

        XCTAssertEqual(basket.itemCount, 3)
        XCTAssertEqual(basket.totalPence, 3_550)
    }

    func testProductResponseDecodesWhenRatingIsMissing() throws {
        let json = """
        {
          "currency": "GBP",
          "products": [
            {
              "id": "1",
              "name": "Vitamin C Serum",
              "brand": "Beauty Pie",
              "category": "Skincare",
              "memberPricePence": 1400,
              "rrpPence": 6800,
              "stock": 5,
              "benefits": ["Brightens", "Smooths"],
              "imageURL": "https://example.com/image.jpg",
              "description": "A serum"
            }
          ]
        }
        """

        let response = try JSONDecoder().decode(
            ProductResponse.self,
            from: Data(json.utf8)
        )

        XCTAssertEqual(response.currency, "GBP")
        XCTAssertEqual(response.products.first?.rating, nil)
        XCTAssertEqual(response.products.first?.benefits, ["Brightens", "Smooths"])
    }

    @MainActor
    func testViewModelLoadsProducts() async {
        let product = makeProduct(stock: 5)
        let service = StubProductService(response: .success(
            ProductResponse(currency: "GBP", products: [product])
        ))
        let viewModel = ProductListViewModel(productService: service)

        await viewModel.fetchProducts()

        XCTAssertEqual(viewModel.state, .loaded([product]))
    }

    @MainActor
    func testViewModelShowsAPIErrorMessage() async {
        let service = StubProductService(response: .failure(.httpError(503)))
        let viewModel = ProductListViewModel(productService: service)

        await viewModel.fetchProducts()

        XCTAssertEqual(
            viewModel.state,
            .error("We're having trouble loading the products. Please try again.")
        )
    }

    private func makeProduct(
        id: String = "1",
        stock: Int,
        memberPricePence: Int = 1400
    ) -> Product {
        Product(
            id: id,
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

private struct StubProductService: ProductServiceProtocol {
    enum Response: Sendable {
        case success(ProductResponse)
        case failure(APIError)
    }

    let response: Response

    func fetchProductList() async throws -> ProductResponse {
        switch response {
        case .success(let productResponse):
            return productResponse
        case .failure(let error):
            throw error
        }
    }
}
