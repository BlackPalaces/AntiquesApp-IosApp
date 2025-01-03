//
//  AdminPage.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 19/5/2567 BE.
//

import SwiftUI

struct AdminPage: View {
    @StateObject private var viewModel = Product_Model()
    @ObservedObject var userOrderViewModel = OrderViewModel()
    var body: some View {
        NavigationView {
            VStack{
                HStack{
                        NavigationLink(destination: OrderListView().navigationBarBackButtonHidden(true)) {
                                               Image(systemName: "line.3.horizontal.circle.fill")
                                                   .resizable()
                                                   .foregroundColor(.white)
                                                   .background(Color.black)
                                                   .cornerRadius(60)
                                                   .frame(width: 30, height: 30)
                                           }
                    Spacer()
                }.padding(.leading,10)
                Text("Product")
                    .bold()
                    .font(.title)
                VStack{
                    NavigationLink(destination: AddProductView().navigationBarBackButtonHidden(true)) {
                        Label(
                            title: { Text("Add Product").bold().foregroundColor(.white) },
                            icon: { Image(systemName: "plus.circle").foregroundColor(.white) }
                        )
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

struct AdminPage_Previews: PreviewProvider {
    static var previews: some View {
        let maxHeight = 800 - (UIApplication.shared.connectedScenes
                                .filter { $0.activationState == .foregroundActive }
                                .compactMap { $0 as? UIWindowScene }
                                .compactMap { $0.statusBarManager?.statusBarFrame.height }
                                .first ?? 0)
        return AdminPage()
            .frame(maxHeight: maxHeight)
    }
}
