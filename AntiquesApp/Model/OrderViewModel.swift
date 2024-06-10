import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []

    func fetchAllOrders() {
        let db = Firestore.firestore()
        
        db.collection("Orders").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error fetching orders: \(error.localizedDescription)")
            } else {
                var allOrders: [Order] = []
                for document in snapshot!.documents {
                    print("Fetching order with id: \(document.documentID)")
                    do {
                        var order = try document.data(as: Order.self)
                        order.products = order.products.enumerated().map { index, product in
                            var uniqueProduct = product
                            uniqueProduct.id = uniqueProduct.id ?? "\(document.documentID)-\(index)"
                            return uniqueProduct
                        }
                        allOrders.append(order)
                    } catch let decodingError {
                        print("Error decoding order with id \(document.documentID): \(decodingError)")
                    }
                }
                DispatchQueue.main.async {
                    self.orders = allOrders
                }
            }
        }
    }
}
