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
                      
                        .padding(.horizontal,10)
                        
                        VStack{
                            Text("name@gmail.com")
                                .lineLimit(1)
                        }.frame(width: 170 , alignment: .leading)
                            
                    }
                    HStack{
                        HStack{
                            Image(systemName: "phone.circle.fill")
                                    .resizable()
                                    .frame(width:30, height: 30)
                                    .aspectRatio(contentMode: .fit)
                                Text("Phone Number")
                                    .bold()
                                    .lineLimit(1)
                        }
                        .frame(width: 170,alignment: .leading)
                      
                        .padding(.horizontal,10)
                        
                        VStack{
                            Text("0999999999")
                                .lineLimit(1)
                        }.frame(width: 170 , alignment: .leading)
                          
                    }
                    HStack{
                        HStack{
                            Image(systemName: "envelope.circle.fill")
                                    .resizable()
                                    .frame(width:30, height: 30)
                                    .aspectRatio(contentMode: .fit)
                                Text("Email")
                                    .bold()
                                    .lineLimit(1)
                        }
                        .frame(width: 170,alignment: .leading)
                        
                        .padding(.horizontal,10)
                        
                        VStack{
                            Text("name@gmail.com")
                                .lineLimit(1)
                        }.frame(width: 170 , alignment: .leading)
                           
                    }
                    
                    VStack{
                        HStack{
                            Image(systemName: "location.fill")
                                    .resizable()
                                    .frame(width:30, height: 30)
                                    .aspectRatio(contentMode: .fit)
                                Text("Address")
                                    .bold()
                                    .lineLimit(1)
                        }
                        .frame(width: 170,alignment: .leading)
                        .padding(.horizontal,10)
                        VStack{
                            Text("บ้านซอยแดง แตงแมงแตงแม๊งแต่งแน่งแนง")
                        }.padding(.horizontal,10)
                      
                    }
                }
                VStack{
                    Button(action: {print("Login")
                        dataModel.Logout()
                    }) {
                        HStack{
                            Label("LogOut", systemImage: "nil")
                        }
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
