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
    @State private var navigateToOrder = false
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    VStack{
                        ZStack{
                            AsyncImage(url: URL(string: dataModel.user.backgroundPicURL!)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width, height: 250)
                                        .previewInterfaceOrientation(.landscapeLeft)
                                case .failure(let error):
                                    Text("Failed to load image: \(error.localizedDescription)")
                                case .empty:
                                    Text("Loading...")
                                @unknown default:
                                    Text("Loading...")
                                }
                            }
                            
                            
                            HStack{
                                Spacer()
                                
                                Menu {
                                    Button( action: { navigateToEdit = true })
                                    {
                                        Label("Edit Profile", systemImage: "pencil")
                                    }
                                    if dataModel.user.role == "admin" {
                                        Button(action: { navigateToAdmin = true }) {
                                            Label("Admin Manager", systemImage: "person.badge.key.fill")
                                        }
                                    } else {
                                        Button( action: { navigateToOrder = true })
                                        {
                                            Label("Your order", systemImage: "shippingbox.fill")
                                        }
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
                    AsyncImage(url: URL(string:dataModel.user.profilePicURL!)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .offset(y: 120)
                        case .failure(let error):
                            Text("Failed to load image: \(error.localizedDescription)")
                        case .empty:
                            Text("Loading...")
                        @unknown default:
                            Text("Loading...")
                        }
                    }
                    
                }.frame(width: UIScreen.main.bounds.width,alignment: .top)
                    .background(Color.black)
                
                VStack{
                    Text(dataModel.user.Nickname ?? "ไม่มีชื่อเล่น")
                        .bold()
                        .foregroundStyle(Color.black)
                        .padding(.top ,100)
                        .font(.title)
                    
                    
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
                                Text(dataModel.user.Username ?? "ไม่มีชื่อ")
                                    .foregroundStyle(Color.black)
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
                                Text(dataModel.user.Phone ?? "ไม่พบหมายเลขโทรศัพท์")
                                    .foregroundStyle(Color.black)
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
                                Text(dataModel.user.email)
                                    .foregroundStyle(Color.black)
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
                                Text(dataModel.user.Address ?? "ไม่พบที่อยู่").foregroundStyle(Color.black)
                            }.padding(.horizontal,10)
                            
                        }
                        
                    }
                }
                Spacer()
                
                NavigationLink(
                    destination: OrderListView(),
                    isActive: $navigateToOrder,
                    label: {
                        EmptyView()
                    }
                )
                
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
            .onAppear {
                dataModel.fetchUserinfo()
            }
        }
    }
}




struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile().environmentObject(Data_Model())
    }
}
