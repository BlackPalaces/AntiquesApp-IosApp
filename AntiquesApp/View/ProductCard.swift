//
//  ProductCard.swift
//  AntiquesApp
//
//  Created by 24 on 18/5/2567 BE.
//

import SwiftUI

struct Product: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var name: String
    var price: Double
    var image: String
}

struct ProductCard: View {
   
    var product: Product
       

    var body: some View {
        HStack {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text(String(format: "%.2f", product.price))
                    .font(.headline)
            }
            Spacer()
        }
        .border(Color.gray, width: 2)
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        let sampleProduct = Product(id: UUID(), name: "monalisa ", price: 190000, image: "Mona")
        return ProductCard(product: sampleProduct)
    }
}

// Correct the variable name from Prodcut to Product
var products = [
    Product(name: "monalisa", price:19000, image:"Mona"),
    Product(name: "grandma vase", price:2500, image:"grandma vase"),
    Product(name: "moai", price:5555, image:"moai")
]
