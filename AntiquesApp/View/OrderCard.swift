import SwiftUI

struct OrderCard: View {
    var order: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("รหัสการสั่งซื้อ: \(order.id ?? "")") 
                .font(.headline)
            Text("ราคารวม: \(order.totalPrice, specifier: "%.2f") บาท")
                .font(.subheadline)
            Text("วันที่สั่งซื้อ: \(order.orderDate, formatter: dateFormatter)")
                .font(.subheadline)
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


