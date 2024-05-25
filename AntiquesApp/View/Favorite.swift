import SwiftUI

struct Favorite: View {
    @StateObject private var productModel = Product_Model()

    var body: some View {
        VStack {
            if productModel.favoriteProducts.isEmpty {
                Text("No favorite products")
                    .font(.headline)
                    .padding()
            } else {
                List(productModel.favoriteProducts) { product in
                    ProductFavoriteCard(product: product)
                }
            }
        }
        .onAppear {
            productModel.fetchFavoriteProducts()
        }
        .navigationBarTitle("Favorite Products", displayMode: .inline)
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}
