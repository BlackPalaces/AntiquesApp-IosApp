//
//  AdminPage.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 19/5/2567 BE.
//

import SwiftUI

struct AdminPage: View {
    
    var body: some View {
        VStack{
            HStack{
                
                Menu {
                    Button("Home", action: { print("Home") })
                    Button("Manager", action: { print("Home")})
                    Button("Logout", action: { print("Home")})
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 20, height: 20)
                }
                Spacer()
            }.padding(.leading,10)
            Text("Product")
                .bold()
                .font(.title)
            VStack{
                Button(action: {
                    print("dd")
                })
                { Label("Add Product",systemImage: "plus.circle")
                        .foregroundColor(.white)
                        .bold()
                }.frame(width: 300,height: 40)
                    .padding(5)
                    .background(Color.blue)
                    .cornerRadius(6)
            }
            .frame(width:390, height: 100)
            .cornerRadius(6)
            VStack{
                List{
                    ProductCard()
                    ProductCard()
                    ProductCard()
                    ProductCard()
                    ProductCard()
                    ProductCard()
                    ProductCard()
                    ProductCard()
                    ProductCard()
                    
                }.frame(width:450)
                    .padding()

                Spacer()
            }.frame(width: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    AdminPage().frame(maxHeight: 800 - (UIApplication.shared.connectedScenes.filter
                                        { $0.activationState == .foregroundActive}
                  .map {$0 as? UIWindowScene}
                  .compactMap{ $0?.statusBarManager?.statusBarFrame.height}.first ?? 0))
}
