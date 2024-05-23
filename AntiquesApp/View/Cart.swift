//
//  Cart.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 12/5/2567 BE.
//

import SwiftUI

struct Cart: View {
    @StateObject private var viewModel = Product_Model()
    var body: some View {
        VStack{
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.products) { product in
                        ProductInCartView(product: product)
                    }
                }
            }
            .onAppear {
                viewModel.fetchProducts()
            }
            VStack{
                HStack{
                    Text("เลือกสินค้าที่ต้องการขำระเงิน")
                    Spacer()
                }.frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,alignment: .topLeading)
            }.frame(width: UIScreen.main.bounds.width,height: 100)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 1)
                        .stroke(Color.primary, lineWidth: 0.2)
                )
            Spacer()
        }
    }
}

#Preview {
    Cart()
}
