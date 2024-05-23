//
//  DataModel.swift
//  Lab4
//
//  Created by Chinnaphat Dumpong on 2/4/2567 BE.
//
import Foundation
import Firebase
import SwiftUI

final class Data_Model: ObservableObject{
    @Published var user = User(email: "", password: "",confirm_password: "",Username: "",Phone: "",Address: "",Nickname: "")
    @Published var isLogin: Bool = false
    @Published var LoginFail: Bool = false
    @Published var isEditSubmitting: Bool = false
    @Published var errorMessage: String?
    init(){
        CheckLogin()
    }
    
    func MyLogin(){
        /*if user.email == "sut" && user.password == "1234"{
         self.isLogin = true
         } else{
         self.isLogin = false
         self.LoginFail = true
         }*/
        Auth.auth().signIn(withEmail: user.email, password: user.password) { authResult, error in
            
            if authResult != nil {
                self.isLogin = true
            } else{
                self.LoginFail = true
            }
        }
    }
    
    func Logout(){
        //self.isLogin = false
        // self.LoginFail = false
        let firebaseauth = Auth.auth()
        do{
            try firebaseauth.signOut()
            self.isLogin = false
            self.LoginFail = false
        }catch let signoutError as NSError{
            print("Error:\(signoutError)")
        }
    }
    
    func CheckLogin(){
        Auth.auth().addStateDidChangeListener{
            auth, user in
            
            if user != nil {
                self.isLogin = true
                self.user.email = user?.email ?? ""
            } else{
                self.isLogin = false
                self.LoginFail = false
            }
        }
    }
    
    func MyRegister() {
        // ตรวจสอบว่ารหัสผ่านและยืนยันรหัสผ่านตรงกันหรือไม่
        guard user.password == user.confirm_password else {
            // ถ้ารหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน ให้กำหนด LoginFail เป็น true
            self.LoginFail = true
            return
        }
        
        // ถ้ารหัสผ่านและยืนยันรหัสผ่านตรงกัน
        // ให้ดำเนินการลงทะเบียนผู้ใช้
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            // ตรวจสอบว่ามีข้อผิดพลาดหรือไม่
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                // หากมีข้อผิดพลาดในการสร้างผู้ใช้ กำหนด LoginFail เป็น true
                self.LoginFail = true
            } else {
                // ถ้าสร้างผู้ใช้สำเร็จ กำหนด isLogin เป็น true
                self.isLogin = true
                
                // สร้างโฟลเดอร์ใหม่ใน Firestore ด้วย ID ของผู้ใช้ที่ Firebase Authentication สร้างขึ้น
                let db = Firestore.firestore()
                guard let userID = authResult?.user.uid else {
                    print("Error: User ID not found")
                    return
                }
                
                let userRef = db.collection("Users").document(userID)
                
                // เพิ่มข้อมูลของผู้ใช้ในเอกสารใหม่
                userRef.setData([
                    "email": self.user.email,
                    "Username": "",
                    "Nickname": "",
                    "Phone": "",
                    "Address": ""
                    // เพิ่มข้อมูลอื่น ๆ ตามต้องการ
                ]) { error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added with ID: \(userID)")
                    }
                }
            }
        }
    }
    
    
    func forgotPassword() {
        Auth.auth().sendPasswordReset(withEmail: self.user.email) { error in
            if let error = error {
                print("Error sending password reset email: \(error.localizedDescription)")
                // หากเกิดข้อผิดพลาดในการส่งอีเมลลืมรหัสผ่าน สามารถทำการแจ้งให้ผู้ใช้ทราบได้
            } else {
                print("Password reset email sent successfully!")
                print(self.user.email)
                // ถ้าส่งอีเมลลืมรหัสผ่านสำเร็จ สามารถแจ้งให้ผู้ใช้ทราบได้
            }
        }
    }
    
    
    func EditProfile() {
        isEditSubmitting = true
        errorMessage = nil
        
        let db = Firestore.firestore()
        
        if let userID = Auth.auth().currentUser?.uid {
            let userRef = db.collection("Users").document(userID)
            isEditSubmitting = false
            // ดึงข้อมูลปัจจุบันของผู้ใช้จาก Firestore
            userRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    var SendEditProfile: [String: Any] = document.data() ?? [:]
                    
                    // อัปเดตข้อมูลที่ไม่ได้ระบุใหม่ในแอพพลิเคชัน ให้ใช้ค่าเดิมจาก Firestore
                    SendEditProfile["Username"] = self.user.Username != "" ? self.user.Username : SendEditProfile["Username"]
                    SendEditProfile["Nickname"] = self.user.Nickname != "" ? self.user.Nickname : SendEditProfile["Nickname"]
                    SendEditProfile["Phone"] = self.user.Phone != "" ? self.user.Phone : SendEditProfile["Phone"]
                    SendEditProfile["Address"] = self.user.Address != "" ? self.user.Address : SendEditProfile["Address"]
                    
                    // อัปเดตข้อมูลใน Firestore
                    userRef.updateData(SendEditProfile) { error in
                        if let error = error {
                            self.errorMessage = "Error updating document: \(error)"
                        } else {
                            self.errorMessage = "Document updated successfully!"
                        }
                    }
                } else {
                    self.errorMessage = "Document does not exist"
                }
            }
        }
    }
}
