//
//  DataModel.swift
//  Lab4
//
//  Created by Chinnaphat Dumpong on 2/4/2567 BE.
//
import Foundation
import Firebase

final class Data_Model: ObservableObject{
    @Published var user = User(email: "", password: "")
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
}
