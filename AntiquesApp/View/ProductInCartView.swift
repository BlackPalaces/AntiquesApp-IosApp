//
//  ProductInCartView.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 23/5/2567 BE.
//

import SwiftUI

struct ProductInCartView: View {
    var product: ProductCart
    @State private var isChecked: Bool = false
    @StateObject private var viewModel = Product_Model()
    var body: some View {
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
            VStack{
                HStack{
                    Button(action: {
                        viewModel.deleteProduct(id: product.id!)
                    }) {
                        Image(systemName: "cart.fill.badge.minus")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                }.padding(.top,10)
                    .padding(.leading,10)
                Spacer()
                VStack{
                    Button(action: {
                        isChecked.toggle()
                    }) {
                        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 30,height:30)
                            .foregroundColor(isChecked ? .green : .gray)
                    }
                }.padding(.bottom,40)
                    .padding(.trailing,10)
            }.frame(width: 100,height: 150)
                
        }
        .frame(width: 380 ,height: 150)
        .border(Color.gray, width: 1)
        .cornerRadius(2)
        
    }
}


#Preview {
    ProductInCartView(product: ProductCart(id: "1", name: "Mona", description: "A famous painting", price: 100.0, imageUrl: "https://i.pinimg.com/originals/82/d0/4d/82d04df570ede6802350a931917bb155.jpg", stock: 10))
}
