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
    
    
    func addToFavorites(id: String) {
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let userRef = db.collection("Users").document(userId)
        let favoritesRef = userRef.collection("favorites")
        
        favoritesRef.document(id).setData([
            "productId": id
        ]) { error in
            if let error = error {
                print("Error adding product to favorites: \(error.localizedDescription)")
            } else {
                print("Product added to favorites successfully!")
            }
        }
    }
    
    func toggleFavorite(id: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(userId)
        let favoritesRef = userRef.collection("favorites")
        
        // Check if the product is already in favorites
        favoritesRef.whereField("productId", isEqualTo: id).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error checking favorite product: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                return
            }
            
            if snapshot.isEmpty {
                // Product not in favorites, add it
                favoritesRef.addDocument(data: ["productId": id]) { error in
                    if let error = error {
                        print("Error adding product to favorites: \(error.localizedDescription)")
                    } else {
                        print("Product added to favorites successfully!")
                    }
                }
            } else {
                // Product already in favorites, remove it
                for document in snapshot.documents {
                    let favoriteId = document.documentID
                    favoritesRef.document(favoriteId).delete { error in
                        if let error = error {
                            print("Error removing product from favorites: \(error.localizedDescription)")
                        } else {
                            print("Product removed from favorites successfully!")
                        }
                    }
                }
            }
        }
    }
    @Published var favoriteProducts: [ProductCart] = []
    
    func fetchFavoriteProducts() {
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let userRef = db.collection("Users").document(userId)
        let favoritesRef = userRef.collection("favorites")
        
        favoritesRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching favorites: \(error.localizedDescription)")
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No favorite products found")
                return
            }
            
            let productIds = documents.compactMap { $0["productId"] as? String }
            self.loadFavoriteProducts(productIds: productIds)
        }
    }
    
    private func loadFavoriteProducts(productIds: [String]) {
        let db = Firestore.firestore()
        let productsRef = db.collection("products")
        
        var fetchedProducts: [ProductCart] = []
        
        let group = DispatchGroup()
        for productId in productIds {
            group.enter()
            productsRef.document(productId).getDocument { (document, error) in
                if let document = document, document.exists, let product = try? document.data(as: ProductCart.self) {
                    fetchedProducts.append(product)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.favoriteProducts = fetchedProducts
        }
    }
    func removeFromFavorites(id: String) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("Users").document(userId)
        let favoritesRef = userRef.collection("favorites")
        
        favoritesRef.whereField("productId", isEqualTo: id).getDocuments { (snapshot, error) in
            if let error = error {
                print("Error checking favorite product: \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                return
            }
            
            if !snapshot.isEmpty {
                // Product found in favorites, remove it
                for document in snapshot.documents {
                    let favoriteId = document.documentID
                    favoritesRef.document(favoriteId).delete { error in
                        if let error = error {
                            print("Error removing product from favorites: \(error.localizedDescription)")
                        } else {
                            print("Product removed from favorites successfully!")
                        }
                    }
                }
            }
        }
    }
    
    func AddtoCart(id: String) {
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let userRef = db.collection("Users").document(userId)
        let cartRef = userRef.collection("MyCart")
        
        // ตรวจสอบว่ามีสินค้า id นี้อยู่ในตะกร้าหรือไม่
        cartRef.document(id).getDocument { (document, error) in
            if let document = document, document.exists {
                // ถ้ามีสินค้า id นี้อยู่ในตะกร้าแล้ว
                print("Product is already in the cart")
            } else {
                // ถ้าไม่มีสินค้า id นี้ในตะกร้า ให้เพิ่มเข้าไป
                cartRef.document(id).setData(["addedAt": FieldValue.serverTimestamp()]) { error in
                    if let error = error {
                        print("Error adding product to cart: \(error.localizedDescription)")
                    } else {
                        print("Product added to cart successfully")
                    }
                }
            }
        }
    }
    
    @Published var Cartproducts: [ProductCart] = []
    
    func fetchCartProducts() {
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let userRef = db.collection("Users").document(userId)
        let cartRef = userRef.collection("MyCart")
        
        // Fetch product ids from MyCart
        cartRef.getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents in MyCart")
                return
            }
            
            let productIds = documents.map { $0.documentID }
            
            // Check if productIds is not empty
            guard !productIds.isEmpty else {
                self.Cartproducts = []
                print("No products in the cart")
                return
            }
            
            // Fetch product details for each product id
            let productsCollection = db.collection("products")
            productsCollection.whereField(FieldPath.documentID(), in: productIds).getDocuments { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No products found for the cart")
                    return
                }
                
                self.Cartproducts = documents.compactMap { queryDocumentSnapshot -> ProductCart? in
                    do {
                        let product = try queryDocumentSnapshot.data(as: ProductCart.self)
                        print("Fetched product: \(product)")
                        return product
                    } catch {
                        print("Error decoding product: \(error)")
                        return nil
                    }
                }
                
                print("Total products fetched for the cart: \(self.Cartproducts.count)")
            }
        }
    }
    
    func removeFromCart(id: String) {
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        let userRef = db.collection("Users").document(userId)
        let cartRef = userRef.collection("MyCart")
        
        // ลบเอกสารที่มี id ตรงกับสินค้าที่ต้องการลบ
        cartRef.document(id).delete { error in
            if let error = error {
                print("Error removing product from cart: \(error.localizedDescription)")
            } else {
                print("Product removed from cart successfully")
            }
        }
    }
    
    
    func BuyProducts(selectedProducts: [ProductCart], totalPrice: Double, user: User, shippingOption: String, paymentOption: String) {
            let db = Firestore.firestore()
            guard let userId = Auth.auth().currentUser?.uid else {
                print("User not logged in")
                return
            }
            
            let orderRef = db.collection("Orders").document()
        
            let orderData: [String: Any] = [
                "userId": userId,
                "id": orderRef.documentID,
                "username": user.Username ?? "",
                "phone": user.Phone ?? "",
                "address": user.Address ?? "",
                "totalPrice": totalPrice,
                "orderDate": Timestamp(date: Date()),
                "shippingOption": shippingOption,
                "paymentOption": paymentOption,
                "products": selectedProducts.map { product in
                    return [
                        "name": product.name,
                        "quantity": product.quantity ?? 1,
                        "description": product.description,
                        "imageUrl": product.imageUrl,
                        "stock": product.stock,
                        "price": product.price,
                        "totalPrice": product.price * Double(product.quantity ?? 1)
                    ]
                }
            ]
            
            db.collection("Orders").addDocument(data: orderData) { error in
                if let error = error {
                    print("Error adding order: \(error.localizedDescription)")
                } else {
                    print("Order successfully added")
                }
            }
        }
}
        
       



