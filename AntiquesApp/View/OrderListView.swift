import SwiftUI

struct OrderListView: View {
    @StateObject var orderViewModel = OrderViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(orderViewModel.orders) { order in
                    NavigationLink(destination: OrderDetailView(order: order)) {
                        OrderCard(order: order)
                    }
                }
            }
            .onAppear {
                orderViewModel.fetchAllOrders()
            }
            .navigationTitle("Orders")
        }
    }
}
