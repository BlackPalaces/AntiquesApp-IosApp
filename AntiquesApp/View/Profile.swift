//
//  Profile.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 12/5/2567 BE.
//


import SwiftUI

struct Profile: View {
    @EnvironmentObject var dataModel : Data_Model
    
    var body: some View {
        VStack{
                ZStack{
                    VStack{
                        Image("Snow")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width ,height: 250)
                   
                        
                        .previewInterfaceOrientation(.landscapeLeft)
                   
                    }
                    Image("Mona")
                        .resizable()
                        .frame(width: 200 ,height: 200)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .offset(y: 120)
               
                }.frame(width: UIScreen.main.bounds.width,alignment: .top)
                .background(Color.black)
           
            VStack{
                Text("Madam")
                    .padding(.top ,100)
                    .bold()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                VStack{
                    HStack{
                        HStack{
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width:30, height: 30)
                                    .aspectRatio(contentMode: .fit)
                                Text("Username")
                                    .bold()
                                    .lineLimit(1)
                        }
                        .frame(width: 170,alignment: .leading)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal,10)
                        
                        VStack{
                            Text("name@gmail.com")
                                .lineLimit(1)
                        }.frame(width: 170 , alignment: .leading)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    }
                }
               
            }
            Spacer()
           
        }
    }
    
}




struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile().environmentObject(Data_Model())
    }
}
