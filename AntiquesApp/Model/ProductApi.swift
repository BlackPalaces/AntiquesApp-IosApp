//
//  ProductApi.swift
//  AntiquesApp
//
//  Created by 24 on 18/5/2567 BE.
//



import Foundation

struct ProductApi: Identifiable, Codable, Hashable{
    var id: Int
    var title: String
    var price: Double
    var category: String
    var description: String
    var image: String
}

