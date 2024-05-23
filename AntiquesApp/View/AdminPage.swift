//
//  AdminPage.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 19/5/2567 BE.
//

import SwiftUI

struct AdminPage: View {
    @StateObject private var viewModel = Product_Model()
    var body: some View {
        NavigationView {
            VStack{
                Text("Product")
                    .bold()
                    .font(.title)
                VStack{
                    NavigationLink(destination: AddProductView()) {
                        Label("Add Product", systemImage: "plus.circle")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 300, height: 40)
                            .padding(5)
                            .background(Color.blue)
                            .cornerRadius(6)
                    }
                }
                .frame(width:390, height: 100)
                .cornerRadius(6)
                VStack{
                    ScrollView {
                                   LazyVStack {
                                       ForEach(viewModel.products) { product in
                                           ProductCard(product: product)
                                       }
                                   }
                               }
                               .onAppear {
                                   viewModel.fetchProducts()
                               }
                    
                    Spacer()
                }.frame(width: UIScreen.main.bounds.width)
            }
        }.navigationBarBackButtonHidden(false)
    }
}

#Preview {
    AdminPage().frame(maxHeight: 800 - (UIApplication.shared.connectedScenes.filter
                                        { $0.activationState == .foregroundActive}
        .map {$0 as? UIWindowScene}
        .compactMap{ $0?.statusBarManager?.statusBarFrame.height}.first ?? 0))
}
