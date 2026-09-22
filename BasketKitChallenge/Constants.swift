import Foundation

enum Constants {
    /// Product catalog for this exercise. GET-only, no auth, CORS-enabled.
    ///
    ///     {
    ///       "currency": "GBP",
    ///       "products": [
    ///         {
    ///           "id": "skn-001",
    ///           "name": "Superfluid Vitamin C Serum 15%",
    ///           "brand": "Lab No.4",
    ///           "category": "Skincare",
    ///           "memberPricePence": 1400,
    ///           "rrpPence": 6800,
    ///           "stock": 34,
    ///           "rating": 4.7,
    ///           "benefits": [
    ///             "Brightens uneven tone in four weeks",
    ///             "Softens the look of fine lines",
    ///             "Absorbs in seconds with no tacky finish",
    ///             "Stabilised 15% vitamin C"
    ///           ],
    ///           "imageURL": "https://picsum.photos/seed/skn-001/600/600",
    ///           "description": "..."
    ///         },
    ///         ...
    ///       ]
    ///     }
    ///
    /// 14 products across Skincare / Makeup / Haircare / Fragrance / Bodycare.
    /// A few things worth noticing before you model this:
    ///
    /// - Two products have `stock: 0`.
    /// - One omits `rating` entirely rather than sending it as `null`.
    /// - `rating` is sometimes a whole number (`4`) rather than a decimal.
    /// - `benefits` is ordered by importance, and its length varies from 3 to
    ///   5 across the catalog — it is not a fixed-size list.
    ///
    /// Decide how each of those should affect your model and your UI.
    static let productCatalogURL = URL(string: "https://api.npoint.io/9467e4b907b04a8eb9cd")!
}
