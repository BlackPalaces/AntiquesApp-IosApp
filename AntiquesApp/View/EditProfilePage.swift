//
//  EditProfilePage.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 22/5/2567 BE.
//

import SwiftUI
import FirebaseFirestore
import FirebaseStorage
import UIKit
import MobileCoreServices // เพิ่มไว้สำหรับการเลือกภาพ

struct EditProfilePage: View {
    @StateObject private var UserInfo = Data_Model()
    @State private var profileImage: UIImage?
    @State private var backgroundImage: UIImage?
    @State private var showingProfileImagePicker = false
    @State private var showingBackgroundImagePicker = false
    
    var body: some View {
        VStack{
            ZStack{
                if let backgroundImage = backgroundImage {
                    Image(uiImage: backgroundImage)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 250)
                        .previewInterfaceOrientation(.landscapeLeft)
                } else {
                    Button(action: {
                        self.showingBackgroundImagePicker = true
                    }) {
                        Text("Edit Background Image")
                    }
                    .sheet(isPresented: $showingBackgroundImagePicker) {
                        ImagePicker(image: self.$backgroundImage)
                    }
                }

                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .offset(y: 20)
                } else {
                    Button(action: {
                        self.showingProfileImagePicker = true
                    }) {
                        Text("Edit Profile Image")
                    }
                    .sheet(isPresented: $showingProfileImagePicker) {
                        ImagePicker(image: self.$profileImage)
                    }
                    .padding(.top,100)
                }
            }.frame(width: UIScreen.main.bounds.width,alignment: .top)
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
                
                Button(action: {
                    UserInfo.editProfile(profileImage: profileImage, backgroundImage: backgroundImage)
                }) {
                    if UserInfo.isEditSubmitting {
                        ProgressView()
                    } else {
                        Label("Edit Profile", systemImage: "pencil")
                    }
                }
                .disabled(UserInfo.isEditSubmitting)

            }
            .onAppear {
                UserInfo.loaduserInfo()
            }
        }
    }
}

// สร้าง View สำหรับเลือกรูปภาพจากอัลบั้ม
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [kUTTypeImage as String]
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }

    }
}
#Preview {
    EditProfilePage().environmentObject(Data_Model())
}
