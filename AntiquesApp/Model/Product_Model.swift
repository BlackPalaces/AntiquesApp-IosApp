//  Product_Model.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 19/5/2567 BE.
//

import Foundation
import Firebase
import FirebaseFirestore
import StoreKit
import SwiftUI


final class Product_Model: ObservableObject{
      @Published var name: String = ""
      @Published var description: String = ""
      @Published var priceString: String = ""
      @Published var imageUrl: String = ""
      @Published var stockString: String = ""
      @Published var isSubmitting: Bool = false
      @Published var errorMessage: String?
    @Published var products: [ProductCart] = []
    
    private var dataModel: Data_Model
       
       // สร้าง initializer ที่รับ Data_Model เป็น parameter
       init(dataModel: Data_Model) {
           self.dataModel = dataModel
       }
    
    func addProduct() {
            guard !name.isEmpty,
                  !description.isEmpty,
                  let price = Double(priceString),
                  let stock = Int(stockString),
                  !imageUrl.isEmpty else {
                errorMessage = "Please fill in all fields correctly."
                return
            }
            
            isSubmitting = true
            errorMessage = nil
            
            let db = Firestore.firestore()
        
            let newProduct: [String: Any] = [
                "name": name,
                "description": description,
                "price": price,
                "imageUrl": imageUrl,
                "stock": stock
            ]
            
            db.collection("products").addDocument(data: newProduct) { error in
                self.isSubmitting = false
                if let error = error {
                    self.errorMessage = "Error adding product: \(error.localizedDescription)"
                } else {
                    self.errorMessage = "Product added successfully!"
                    // Reset form
                    self.name = ""
                    self.description = ""
                    self.priceString = ""
                    self.imageUrl = ""
                    self.stockString = ""
                    self.fetchProducts()
                }
            }
        }
    
    
    func fetchProducts() {
        let db = Firestore.firestore()
        db.collection("products").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.products = documents.compactMap { queryDocumentSnapshot -> ProductCart? in
                do {
                    let product = try queryDocumentSnapshot.data(as: ProductCart.self)
                    print("Fetched product: \(product)")
                    return product
                } catch {
                    print("Error decoding product: \(error)")
                    return nil
                }
            }
            
            print("Total products fetched: \(self.products.count)")
        }
    }

    
    func EditProduct(id: String!) {
        isSubmitting = true
        errorMessage = nil
        
        let db = Firestore.firestore()
        let productRef = db.collection("products").document(id)
        
        productRef.getDocument { (document, error) in
            if let document = document, document.exists {
                var sendEditProduct: [String: Any] = document.data() ?? [:]
                
                sendEditProduct["name"] = self.name != "" ? self.name : sendEditProduct["name"]
                sendEditProduct["description"] = self.description != "" ? self.description : sendEditProduct["description"]
                
                // Convert string to double
                sendEditProduct["price"] = self.priceString != "" ? Double(self.priceString) ?? sendEditProduct["price"] : sendEditProduct["price"]
                
                sendEditProduct["imageUrl"] = self.imageUrl != "" ? self.imageUrl : sendEditProduct["imageUrl"]
                sendEditProduct["stock"] = self.stockString != "" ? Int(self.stockString) ?? sendEditProduct["stock"] : sendEditProduct["stock"]
                
                productRef.updateData(sendEditProduct) { error in
                    self.isSubmitting = false
                    if let error = error {
                        self.errorMessage = "Error updating document: \(error)"
                    } else {
                        self.errorMessage = "Document updated successfully!"
                        self.fetchProducts()  // Fetch the latest products
                    }
                }
            } else {
                self.isSubmitting = false
                self.errorMessage = "Document does not exist"
            }
        }
    }

    
    func loadProductDetails(id: String) {
            let db = Firestore.firestore()
            let productRef = db.collection("products").document(id)
            
            productRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let data = document.data() {
                        self.name = data["name"] as? String ?? ""
                        self.description = data["description"] as? String ?? ""
                        self.priceString = String(data["price"] as? Double ?? 0.0)
                        self.imageUrl = data["imageUrl"] as? String ?? ""
                        self.stockString = String(data["stock"] as? Int ?? 0)
                    }
                } else {
                    self.errorMessage = "Failed to load product details"
                }
            }
        }
    func deleteProduct(id: String) {
        let db = Firestore.firestore()
        let productRef = db.collection("products").document(id)
        
        // Show confirmation alert
        let alert = UIAlertController(title: "Do you want to Delete?", message: "คุณแน่ใจหรือไม่ว่าต้องการลบสินค้านี้?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            // Perform delete operation
            productRef.delete { error in
                if let error = error {
                    print("Error deleting product: \(error)")
                    // Handle error if necessary
                } else {
                    print("Product deleted successfully!")
                    // Handle success if necessary
                }
            }
        }))
        
        // Get the top most view controller
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            topViewController.present(alert, animated: true, completion: nil)
        }
    }

    
    func Addcart() {
        
        let db = Firestore.firestore()
        let userID = dataModel.userID
    }

}

