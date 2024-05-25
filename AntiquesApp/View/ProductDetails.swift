import SwiftUI
struct ProductDetails: View {
    var product: ProductCart

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            } placeholder: {
                ProgressView()
            }
            .padding(5)
            
            Text(product.name)
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            Text("\(String(format: "%.2f", product.price)) Bath")
                .font(.title2)
                .padding(.top, 10)
            Text("Stock: \(product.stock)")
                .font(.title3)
                .padding(.top, 5)
            Text(product.description)
                .font(.body)
                .padding(.top, 20)
                .padding(.horizontal, 15)
            Spacer()
        }
    }
}

// ตัวอย่างข้อมูลสำหรับแสดงผลใน Preview
struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetails(product: ProductCart(id: "1", name: "Mona", description: "A famous painting", price: 100.0, imageUrl: "https://i.pinimg.com/originals/82/d0/4d/82d04df570ede6802350a931917bb155.jpg", stock: 10))
    }
}
