import SwiftUI

/// Starting point only — replace this with your product listing.
///
/// `Constants.productCatalogURL` is the one thing we're giving you; the
/// model, the networking, and the view are yours to design. See the README
/// for what we're looking for.
struct ContentView: View {
    var body: some View {
        NavigationStack {
            ProductListView(
                viewModel: ProductListViewModel()
            )
        }
    }
}

#Preview {
    ContentView()
}
