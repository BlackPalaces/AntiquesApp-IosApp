//
//  User.swift
//  Lab4
//
//  Created by Chinnaphat Dumpong on 2/4/2567 BE.
//
import Foundation

struct User: Identifiable,Codable{
    var id = UUID()
    var email:String
    var password:String
}
