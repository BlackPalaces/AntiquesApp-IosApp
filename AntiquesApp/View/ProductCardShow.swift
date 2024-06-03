import SwiftUI

struct ProductCardShow: View {
    var product: ProductCart
    @StateObject private var viewModel = Product_Model()
    var body: some View {
        NavigationLink(destination: ProductDetails(product: product)) {
            HStack {
                AsyncImage(url: URL(string: product.imageUrl)) { Image in Image
                        .frame(width: 150, height: 250)
                } placeholder: {
                    ProgressView()
                }
                .padding(5)
                
                VStack {
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .bold()
                            .font(.system(size: 25))
                            .multilineTextAlignment(.trailing)
                            .lineLimit(2)
            
                        Text("\(String(format: "%.2f", product.price)) Bath")
                            .font(.headline)
                            .multilineTextAlignment(.trailing)
                        Text("Stock: \(product.stock)")
                            .font(.headline)
                    }
                    .frame(width: 150, height: 130, alignment: .topTrailing)
                    .foregroundColor(.black)
                    .padding(.top, 45)
                    Spacer()
                    VStack {
                        Button(action: {
                            viewModel.addToFavorites(id: product.id!)
                        }) {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .topTrailing)
                                .padding(.leading, 40)
                        }
                        Button(action: {
                            viewModel.AddtoCart(id: product.id!)
                        }) {
                            Label("Cart", systemImage: "cart.badge.plus")
                                .font(Font.body.bold()) // Use the font modifier to make the text bold
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.blue)
                                .cornerRadius(6)
                        }

                    }
                    .frame(width: 150, height: 150, alignment: .bottomTrailing)
                    .padding(10)
                }
            }
            .frame(width: 350, height: 350)
            .background(Color.white)
            .border(Color.gray, width: 0)
            .cornerRadius(8)
            .shadow(color: .primary, radius: 2, x: 1, y: 1)
            .contentShape(Rectangle())
        }
    }
}

struct ProductCardShow_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardShow(product: ProductCart(id: "1", name: "Mona", description: "A famous painting", price: 100.0, imageUrl: "", stock: 10))
    }
}
