//
//  ProductFavoriteCard.swift
//  AntiquesApp
//
//  Created by 24 on 25/5/2567 BE.
//

import SwiftUI

struct ProductFavoriteCard: View {
    var product: ProductCart

    var body: some View {
        NavigationLink(destination: ProductDetails(product: product)) {
            HStack {
                AsyncImage(url: URL(string: product.imageUrl)) { Image in Image
                        .frame(width: 150, height: 250)
                } placeholder: {
                    ProgressView()
                }
                .padding(5)
                
                VStack {
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.system(size: 25))
                            .multilineTextAlignment(.trailing)
                            .lineLimit(2)
                            .bold()
                        Text("\(String(format: "%.2f", product.price)) Bath")
                            .font(.headline)
                            .multilineTextAlignment(.trailing)
                        Text("Stock: \(product.stock)")
                            .font(.headline)
                    }
                    .frame(width: 150, height: 130, alignment: .topTrailing)
                    .foregroundColor(.black)
                    .padding(.top, 45)
                    Spacer()
                    VStack {
                        Button(action: {
                            print("Added to favorites")
                        }) {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .topTrailing)
                                .padding(.leading, 40)
                        }
                        Button(action: {
                            print("Add to cart pressed")
                        }) {
                            Label("Cart", systemImage: "cart.badge.plus")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 100, height: 50)
                                .background(Color.blue)
                                .cornerRadius(6)
                        }
                    }
                    .frame(width: 150, height: 150, alignment: .bottomTrailing)
                    .padding(10)
                }
            }
            .frame(width: 350, height: 350)
            .background(Color.white)
            .border(Color.gray, width: 0)
            .cornerRadius(8)
            .shadow(color: .primary, radius: 2, x: 1, y: 1)
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    ProductFavoriteCard(product: ProductCart(id: "1", name: "Mona", description: "A famous painting", price: 100.0, imageUrl: "", stock: 10))
}
