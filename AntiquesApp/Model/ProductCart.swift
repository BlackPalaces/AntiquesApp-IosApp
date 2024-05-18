//
//  ProductCart.swift
//  AntiquesApp
//
//  Created by 24 on 18/5/2567 BE.
//

import Foundation


struct ProductCart: Identifiable, Hashable, Codable{
    var id = UUID()
    var title: String = ""
    var price: Double = 0.0
}
