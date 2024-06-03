import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift // Import this if you haven't already
import Combine


class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = [] // แก้ชนิดของ orders เป็น [Order]
    func fetchAllOrders() {
        let db = Firestore.firestore()
        
        db.collection("Orders").getDocuments { (snapshot, error) in
            if let error = error {
                // จัดการข้อผิดพลาด
                print("Error fetching orders: \(error.localizedDescription)")
            } else {
                var allOrders: [Order] = []
                for document in snapshot!.documents {
                    print("Fetching order with id: \(document.documentID)")
                    if let order = try? document.data(as: Order.self) {
                        allOrders.append(order)
                    }
                }
                DispatchQueue.main.async {
                    self.orders = allOrders
                }
            }
        }
    }
  }

