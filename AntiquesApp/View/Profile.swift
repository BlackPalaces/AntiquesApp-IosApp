//
//  Profile.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 12/5/2567 BE.
//


import SwiftUI

struct Profile: View {
    @EnvironmentObject var dataModel : Data_Model
    @State private var navigateToEdit = false
    @State private var navigateToAdmin = false
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    VStack{
                        ZStack{
                            Image("Snow")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width ,height: 250)
                                .previewInterfaceOrientation(.landscapeLeft)
                            HStack{
                                Spacer()
                                
                                Menu {
                                    Button( action: { navigateToEdit = true })
                                    {
                                Label("Edit Profile", systemImage: "pencil")
                                    }
                                    Button(action: { navigateToAdmin = true })
                                    {
                                Label("Admin Manager", systemImage: "person.badge.key.fill")
                                                                        }
                                    Button("Logout", action: { dataModel.Logout()})
                                } label: {
                                    Image(systemName: "line.3.horizontal.circle.fill")
                                        .resizable()
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                }
                            }.padding(.bottom , 200)
                                .padding(.trailing,10)
                        }
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
                }
                Spacer()
                
                NavigationLink(
                    destination: AdminPage(),
                    isActive: $navigateToAdmin,
                    label: {
                        EmptyView()
                    }
                )
                NavigationLink(
                    destination: EditProfilePage(),
                    isActive: $navigateToEdit,
                    label: {
                        EmptyView()
                    }
                )
            }
        }
    }
}




struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile().environmentObject(Data_Model())
    }
}
