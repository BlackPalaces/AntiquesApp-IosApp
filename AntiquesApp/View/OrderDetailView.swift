import SwiftUI

struct OrderDetailView: View {
    var order: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("รหัสการสั่งซื้อ: \(order.id ?? "")")
                .font(.headline)
            Text("ราคารวม: \(order.totalPrice, specifier: "%.2f") บาท")
                .font(.subheadline)
            Text("วันที่สั่งซื้อ: \(order.orderDate, formatter: dateFormatter)")
                .font(.subheadline)
            
            // ตัวอย่าง: แสดงรายการสินค้าที่สั่งซื้อ
//            ForEach(order.products) { product in
//                Text("\(product.name) x \(product.quantity!)")
//                    .font(.subheadline)
//            }
            Section(header: Text("สินค้าที่สั่งซื้อ")) {
                           ForEach(order.products.indices, id: \.self) { index in
                               let product = order.products[index]
                               VStack(alignment: .leading) {
                                   Text("\(product.name) x \(product.quantity!)")
                                                       .font(.subheadline)
                               }
                           }
                       }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
}
