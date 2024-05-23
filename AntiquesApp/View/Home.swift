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
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "list.bullet.circle.fill")
                    .resizable()
                    .frame(width:30, height: 30)
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Image(systemName: "cart.fill.badge.questionmark")
                    .resizable()
                    .frame(width:30, height: 30)
                    .aspectRatio(contentMode: .fit)
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
                                   ForEach(viewModel.products) { product in
                                       ProductCardShow(product: product)
                                   }
                               }
                           }
                           .onAppear {
                               viewModel.fetchProducts()
                           }
                Spacer()
        }
    }
}

#Preview {
    Home()
}
