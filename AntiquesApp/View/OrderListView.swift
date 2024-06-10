import SwiftUI
import Firebase
import FirebaseAuth

struct OrderListView: View {
    @StateObject var orderViewModel = OrderViewModel()
    @EnvironmentObject var dataModel : Data_Model
    var body: some View {
           NavigationView {
               if dataModel.user.role == "admin" {
                   List {
                       ForEach(orderViewModel.orders.sorted(by: { $0.orderDate > $1.orderDate })) { order in
                           NavigationLink(destination: OrderDetailView(order: order)) {
                               OrderCard(order: order)
                           }
                       }
                   }
                   .onAppear {
                       orderViewModel.fetchAllOrders()
                   }
                   .navigationTitle("Orders")
               } else {
                   List {
                       ForEach(orderViewModel.orders
                                    .filter { $0.userId == Auth.auth().currentUser?.uid }
                                   .sorted(by: { $0.orderDate > $1.orderDate })) { order in
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
}
