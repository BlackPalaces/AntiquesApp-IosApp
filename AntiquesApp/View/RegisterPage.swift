//
//  RegisterPage.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 12/5/2567 BE.
//

import SwiftUI

struct RegisterPage: View {
    @EnvironmentObject var dataModel : Data_Model
    var body: some View {
        NavigationView {
            VStack{
                Text("Antiques SHOP")
                    .bold()
                    .font(.system(size: 45, design: .serif))
                    .foregroundColor(.white)
                VStack{
                    Text("Register")
                        .foregroundColor(.white)
                        .font(.system(size: 48))
                        .bold()
                    VStack{
                        Text("Email")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading) // กำหนดให้ข้อความชิดซ้าย
                            
                        VStack{
                            HStack{
                                TextField("", text: $dataModel.user.email)
                                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                                Image(systemName: "envelope.fill")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                            }.overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(height: 1)
                                    .foregroundColor(.white)
                                    .padding(.top, 30)
                            )
                        }
                        
                        Text("Password")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        VStack {
                            HStack {
                                SecureField("", text: $dataModel.user.password)
                                    .foregroundColor(.white)
                                Image(systemName: "lock.fill")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                    
                            } .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(height: 1)
                                    .foregroundColor(.white)
                                    .padding(.top, 30)
                            )
                            
                        }
                        
                        Text("Confirm Password")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                        VStack {
                            HStack {
                                SecureField("", text: $dataModel.user.confirm_password)
                                    .foregroundColor(.white)
                                Image(systemName: "lock.fill")
                                    .imageScale(/*@START_MENU_TOKEN@*/.medium/*@END_MENU_TOKEN@*/)
                                    
                            } .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(height: 1)
                                    .foregroundColor(.white)
                                    .padding(.top, 30)
                            )
                            
                        }
                    }.font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(.top,10)
                    
                    Button(action: {
                        print("Register")
                        dataModel.MyRegister()
                    }) {
                        HStack {
                            Label("Register", systemImage: "person")
                        }
                    }
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.white)
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .cornerRadius(40)
                    .padding(.top, 10)

                    if dataModel.LoginFail {
                        Text("Try Again").foregroundColor(.red)
                    }

                    NavigationLink(destination: LoginPage()) {
                        Text("Go Back")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .light, design: .serif))
                            .padding(5)
                    }

                    
                    
                }.frame(width: 300,height: 450).padding(20)
                    .background(Color(red: 0.016, green: 0.014, blue: 0.01, opacity: 0.3))
                    .cornerRadius(16)
            }.background(Image("BG2").scaledToFit())
                
        }.navigationBarBackButtonHidden(true)
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage().environmentObject(Data_Model())
    }
}

