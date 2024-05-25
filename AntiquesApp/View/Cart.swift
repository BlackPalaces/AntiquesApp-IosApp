import SwiftUI

struct Cart: View {
    @StateObject private var viewModel = Product_Model()
    @State private var itemCount: Int = 0
    @State private var totalPrice: Double = 0.0
    @State private var totalStock: Int = 0

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.products) { product in
                            ProductInCartView(product: product, itemCount: $itemCount, totalPrice: $totalPrice, totalStock: $totalStock)
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchProducts()
                }

                HStack {
                    VStack {
                        HStack {
                            Text("เลือกสินค้าที่ต้องการขำระเงิน")
                                .bold()
                            Spacer()
                        }
                        .padding(.leading, 10)
                        .padding(.top, 5)

                        Spacer()

                        HStack {
                            Text("สินค้าที่ถูกเลือก")
                            Text("\(itemCount) รายการ")
                            Spacer()
                        }
                        .padding(.leading, 10)
                        .padding(.bottom, 30)
                    }
                    .frame(height: 130)

                    VStack {
                        VStack {
                            Text("ยอดชำระ")
                                .multilineTextAlignment(.trailing)
                                .bold()
                                .padding(.top, 5)
                            Spacer()
                            Text("\(totalPrice, specifier: "%.2f")")
                                .multilineTextAlignment(.trailing)
                                .padding(5)
                                .border(Color.black)

                            NavigationLink(destination: PayView()) {
                                Label("ชำระเงิน", systemImage: "basket.fill")
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 100, height: 40)
                                    .background(Color.green)
                                    .cornerRadius(6)
                            }
                            .padding(.bottom, 5)
                        }
                        .padding(.trailing, 20)
                    }
                    .frame(height: 130)
                }
                .frame(width: UIScreen.main.bounds.width, height: 130)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.primary, lineWidth: 0.2)
                )
                Spacer()
            }
        }
    }
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
    }
}
