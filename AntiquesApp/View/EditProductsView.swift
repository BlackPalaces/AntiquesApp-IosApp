//
//  EditProductsView.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 23/5/2567 BE.
//

import SwiftUI

struct EditProductsView: View {
    @StateObject private var ProductInfo = Product_Model()
    var productID: String
    var body: some View {
        Form {
            Section(header: Text("EditProduct")
                .bold()) {
                    TextField("Name", text: Binding(
                        get: { ProductInfo.name },
                        set: { ProductInfo.name = $0 }
                    ))
                    TextField("Description", text: Binding(
                        get: { ProductInfo.description },
                        set: { ProductInfo.description = $0 }
                    ))
                    TextField("Price", text: Binding(
                        get: { ProductInfo.priceString },
                        set: { ProductInfo.priceString = $0 }
                    ))
                    .keyboardType(.numberPad)
                    TextField("Image URL", text: Binding(
                        get: { ProductInfo.imageUrl },
                        set: { ProductInfo.imageUrl = $0 }
                    ))
                    TextField("Stock", text: Binding(
                        get: { ProductInfo.stockString },
                        set: { ProductInfo.stockString = $0 }
                    ))
                }
            
            if let errorMessage = ProductInfo.errorMessage {
                Section {
                    Text(errorMessage)
                        .foregroundColor(.green)
                }
            }
            
            Button(action: { ProductInfo.EditProduct(id: productID) }) {
                if ProductInfo.isSubmitting {
                    ProgressView()
                } else {
                    Text("Edit Product")
                }
            }
            .disabled(ProductInfo.isSubmitting)
        }
        .onAppear {
            ProductInfo.loadProductDetails(id: productID)
        }
    }
}

struct EditProductsView_Previews: PreviewProvider {
    static var previews: some View {
        EditProductsView(productID: "1")
            .environmentObject(Product_Model())
    }
}
