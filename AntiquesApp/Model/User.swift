//
//  User.swift
//  Lab4
//
//  Created by Chinnaphat Dumpong on 2/4/2567 BE.
//
import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable,Codable{
    @DocumentID var id: String?
    var email:String
    var password:String
    var confirm_password:String
    var Username:String?
    var Phone:String?
    var Address:String?
    var profilePicURL: String?
    var backgroundPicURL: String?
    var Nickname: String?
}
