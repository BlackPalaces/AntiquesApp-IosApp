//
//  EditProfilePage.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 22/5/2567 BE.
//

import SwiftUI
import FirebaseFirestore

struct EditProfilePage: View {
    @StateObject private var UserInfo = Data_Model()
    var body: some View {
        Form {
            Section(header: Text("Edit UserProfile")
                .bold()) {
                    TextField("NickName", text: Binding(
                        get: { UserInfo.user.Nickname ?? "" },
                        set: { UserInfo.user.Nickname = $0 }
                    ))
                TextField("UserName", text: Binding(
                    get: { UserInfo.user.Username ?? "" },
                    set: { UserInfo.user.Username = $0 }
                ))
                TextField("Phonenumber", text: Binding(
                    get: { UserInfo.user.Phone ?? "" },
                    set: { UserInfo.user.Phone = $0 }
                )).keyboardType(.numberPad)
                TextField("Address", text: Binding(
                    get: { UserInfo.user.Address ?? "" },
                    set: { UserInfo.user.Address = $0 }
                ))
            }
            
            if let errorMessage = UserInfo.errorMessage {
                Section {
                    Text(errorMessage)
                        .foregroundColor(.green)
                }
            }
            
            Button(action: UserInfo.EditProfile) {
                if UserInfo.isEditSubmitting {
                    ProgressView()
                } else {
                    Label("Edit Prodile", systemImage: "pencil")
                }
            }
            .disabled(UserInfo.isEditSubmitting)
        }
    }
}

#Preview {
    EditProfilePage().environmentObject(Data_Model())
}
