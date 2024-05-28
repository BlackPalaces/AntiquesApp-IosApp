import SwiftUI

struct ProductInCartView: View {
    var product: ProductCart
    @Binding var itemCount: Int
    @Binding var totalPrice: Double
    @Binding var totalStock: Int
    @State private var isChecked: Bool = false
    @StateObject private var viewModel = Product_Model()
    @State private var quantity: Int = 1

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 250)
                    .clipped()
            } placeholder: {
                ProgressView()
            }
            .padding(5)

            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.system(size: 20))
                    .lineLimit(2)
                Text(String(format: "%.2f", product.price))
                    .font(.headline)
                Text("Stock: \(product.stock)")
                    .font(.headline)
            }
            .frame(width: 150, height: 130, alignment: .topLeading)

            Spacer()

            VStack {
                HStack {
                    Button(action: {
                        viewModel.removeFromCart(id: product.id!)
                        resetCart()
                    }) {
                        Image(systemName: "cart.fill.badge.minus")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                }
                .padding(.top, 10)
                .padding(.leading, 10)

                Spacer()

                VStack {
                    Button(action: {
                        toggleCheck()
                    }) {
                        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(isChecked ? .green : .gray)
                    }
                }
                .padding(.bottom, 10)
                .padding(.trailing, 10)

                HStack {
                    Button(action: {
                        if quantity > 1 {
                            quantity -= 1
                            if isChecked {
                                totalPrice -= product.price
                                itemCount -= 1
                            }
                        }
                    }) {
                        Image(systemName: "minus.circle.fill")
                    }
                    Text("\(quantity)")
                        .multilineTextAlignment(.trailing)
                    Button(action: {
                        if quantity < product.stock {
                            quantity += 1
                            if isChecked {
                                totalPrice += product.price
                                itemCount += 1
                            }
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                }
                .padding(.trailing, 30)
                .padding(.bottom, 10)
            }
            .frame(width: 100, height: 150)
        }
        .frame(width: 380, height: 150)
        .border(Color.gray, width: 1)
        .cornerRadius(2)
    }

    private func toggleCheck() {
        if isChecked {
            totalPrice -= product.price * Double(quantity)
            itemCount -= quantity
        } else {
            totalPrice += product.price * Double(quantity)
            itemCount += quantity
        }
        isChecked.toggle()
    }

    private func resetCart() {
        if isChecked {
            totalPrice -= product.price * Double(quantity)
            itemCount -= quantity
        }
        isChecked = false
        quantity = 1
    }
}

struct ProductInCartView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInCartView(
            product: ProductCart(
                id: "1",
                name: "Mona",
                description: "A famous painting",
                price: 100.0,
                imageUrl: "https://i.pinimg.com/originals/82/d0/4d/82d04df570ede6802350a931917bb155.jpg",
                stock: 10
            ),
            itemCount: .constant(0),
            totalPrice: .constant(0),
            totalStock: .constant(0)
        )
    }
}
