//
//  ProductCard.swift
//  AntiquesApp
//
//  Created by 24 on 18/5/2567 BE.
//

import SwiftUI


struct ProductCard: View {
    
    var product: ProductCart
    @StateObject private var viewModel = Product_Model()
    var body: some View {
        NavigationLink(destination: ProductDetails(product: product)) {
            HStack {
                AsyncImage(url: URL(string: product.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 250)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                .padding(5)
                
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.system(size: 20))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    Text(String(format: "%.2f", product.price))
                        .font(.headline)
                    Text(String("Stock: \(product.stock)"))
                        .font(.headline)
                    
                }.frame(width: 150,height: 130 ,alignment: .topLeading)
                Spacer()
                HStack{
                    NavigationLink(destination: EditProductsView(productID: product.id!)) {
                        Label("", systemImage: "pencil")
                            .foregroundColor(.gray)
                    }
                    Button(action: {
                        viewModel.deleteProduct(id: product.id!)
                    }) {Label("",systemImage: "trash.fill")
                        .foregroundColor(.gray)}
                }.frame(alignment: .topTrailing)
                    .padding(.bottom,100)
                    .padding(.trailing,5)
            }
            .frame(width: 380 ,height: 150)
            .foregroundColor(Color.black)
            .border(Color.gray, width: 1)
            .cornerRadius(2)
            
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: ProductCart(id: "1", name: "Mona", description: "A famous painting", price: 100.0, imageUrl: "", stock: 10))
    }
}

