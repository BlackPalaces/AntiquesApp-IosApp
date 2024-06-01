//
//  Home.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 12/5/2567 BE.
//

import SwiftUI

struct Home: View {
    @StateObject private var viewModel = Product_Model()
    @State private var searchText: String = ""
    @State private var cartItemCount: Int = 0
    var filteredProducts: [ProductCart] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                NavigationLink(destination: Cart()) {
                ZStack{
                        Image(systemName: "cart.fill.badge.questionmark")
                            .resizable()
                            .frame(width:30, height: 30)
                            .aspectRatio(contentMode: .fit)
                        Text("\(viewModel.Cartproducts.count)")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: 7, y: -7)
                    }
                }.foregroundColor(Color.black)
            }.padding(10)
                .frame(alignment: .top)
            ZStack {
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(10)
                        .background(Color(.white))
                        .cornerRadius(10)
                        .padding(.trailing, 40)
                        .background(Color(.white))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }.padding([.leading, .trailing, .top], 5)
                
                HStack {
                    Spacer()  // ผลักดันเนื้อหาไปด้านขวา
                    Button(action: {
                        print("Search button pressed")
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .padding(.trailing, 30)
                .padding(.top,2)
            }
            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .top)
            
            ScrollView {
                LazyVStack {
                    ForEach(filteredProducts) { product in
                        ProductCardShow(product: product)
                    }
                }
            }
            .onAppear {
                viewModel.fetchProducts()
                viewModel.fetchCartProducts()
            }
            Spacer()
        }
    }
}

#Preview {
    Home()
}
