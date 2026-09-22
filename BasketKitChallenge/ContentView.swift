import SwiftUI

/// Starting point only — replace this with your product listing.
///
/// `Constants.productCatalogURL` is the one thing we're giving you; the
/// model, the networking, and the view are yours to design. See the README
/// for what we're looking for.
struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "bag")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
            Text("Build your product listing here")
                .font(.headline)
            Text(Constants.productCatalogURL.absoluteString)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .textSelection(.enabled)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
