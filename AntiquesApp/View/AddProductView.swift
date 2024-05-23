//
//  AddProductView.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 22/5/2567 BE.
//

import SwiftUI
import FirebaseFirestore

struct AddProductView: View {
    
    @StateObject private var productModel = Product_Model()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Information")) {
                    TextField("Name", text: $productModel.name)
                    TextField("Description", text: $productModel.description)
                    TextField("Price", text: $productModel.priceString)
                        
                    TextField("Image URL", text: $productModel.imageUrl)
                    TextField("Stock", text: $productModel.stockString)
                        .keyboardType(.numberPad)
                }
                
                if let errorMessage = productModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.green)
                    }
                }
                
                Button(action: productModel.addProduct) {
                    if productModel.isSubmitting {
                        ProgressView()
                    } else {
                        Text("Add Product")
                    }
                }
                .disabled(productModel.isSubmitting)
            }
            .navigationTitle("Add Product")
        }
    }
}

#Preview {
    AddProductView().environmentObject(Product_Model())
}
