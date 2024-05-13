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
            Text("Test Logout")
            Button(action: {print("Login")
                dataModel.Logout()
            }) {
                HStack{
                    Label("LogOut", systemImage: "nil")}
            }.padding().frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,maxWidth: .infinity).background(Color.white)
                .font(.system(size: 24))
                .foregroundColor(.black)
                .bold().cornerRadius(40)
                .padding(.top,10)
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile().environmentObject(Data_Model())
    }
}
