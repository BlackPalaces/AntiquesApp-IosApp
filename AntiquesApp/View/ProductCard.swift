//
//  ProductCard.swift
//  AntiquesApp
//
//  Created by 24 on 18/5/2567 BE.
//

import SwiftUI


struct ProductCard: View {
   
    @EnvironmentObject var Productmodel : Product_Model

    var body: some View {
                    HStack {
                Image("")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .aspectRatio(contentMode: .fit)
                    .padding(5)
                
                VStack(alignment: .leading) {
                    Text("")
                        .font(.system(size: 20))
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    Text(String(format: "%.2f", ""))
                        .font(.headline)
                    Text(String("Stock: \(String(2))"))
                        .font(.headline)
                       
                }.frame(width: 150,height: 130 ,alignment: .topLeading)
                Spacer()
                HStack{
                    Button(action: {
                        
                    }) {Label("",systemImage: "pencil")
                        .foregroundColor(.gray)}
                    Button(action: {
                        
                    }) {Label("",systemImage: "trash.fill")
                        .foregroundColor(.gray)}
                }.frame(alignment: .topTrailing)
                    .padding(.bottom,100)
                    .padding(.trailing,5)
            }
            .frame(width: 380 ,height: 150)
            .border(Color.gray, width: 1)
            .cornerRadius(2)
        
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard().environmentObject(Product_Model())
    }
}

