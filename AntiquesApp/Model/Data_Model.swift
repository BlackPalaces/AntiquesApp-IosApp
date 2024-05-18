//
//  DataModel.swift
//  Lab4
//
//  Created by Chinnaphat Dumpong on 2/4/2567 BE.
//
import Foundation
import Firebase

final class Data_Model: ObservableObject{
    @Published var user = User(email: "", password: "",confirm_password: "")
    @Published var isLogin: Bool = false
    @Published var LoginFail: Bool = false
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

}
