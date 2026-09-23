# BasketKitChallenge — take-home exercise

Thanks for taking the time to do this. It's meant to take a focused 2–3
hours, not a weekend — see "Time and scope" below.


A SwiftUI iOS application that fetches a product catalogue from the provided API and allows users to add available products to a basket.

## Architecture

The app uses a simple MVVM-style structure:

- **Views** – SwiftUI views responsible for displaying products and user interactions.
- **ViewModel** – Manages product loading state and coordinates basket actions.
- **Basket** – Owns basket state and business rules such as stock limits and total calculation.
- **ProductService** – Provides product catalogue data.
- **NetworkClient** – Handles HTTP requests and JSON decoding.
- **Models** – Represents API response and product data.

The structure intentionally keeps responsibilities small without introducing additional abstractions that are not required by the current feature set.

## Key Decisions

### Swift Concurrency

The catalogue is loaded using `async/await`.

The ViewModel is `@MainActor` because it owns UI-facing state.

### Basket and Stock

The basket is responsible for enforcing the stock limit.

A product cannot be added when the requested quantity would exceed available stock.

The basket total is calculated using the member price.

### Dependency Injection

`ProductServiceProtocol` and `NetworkClientProtocol` allow the networking layer to be replaced with mocks in tests.

### Testing

The basket behaviour is covered with unit tests using XCTest.

Tests cover:

- Adding products increases quantity
- Quantity cannot exceed available stock
- Sold-out products cannot be added
- Basket total uses the member price

## Assumptions

- Prices are provided in pence and displayed as GBP.
- `memberPricePence` is the price used for the basket total.
- The API is treated as read-only.
- Basket state only needs to live for the current app session.
- Authentication and payments are outside the scope of this assignment.

## Future Improvements

If this were extended further, I would consider:

- Search and filtering
- Sorting by price
- Pull-to-refresh
- Image caching
- More detailed basket functionality such as removing items and changing quantities
- Persistent basket storage if required by the product

## Running the Project

1. Open `BasketKitChallenge.xcodeproj` in Xcode.
2. Select an iOS 18 simulator.
3. Build and run the application.
4. Run the XCTest target with `⌘U`.
