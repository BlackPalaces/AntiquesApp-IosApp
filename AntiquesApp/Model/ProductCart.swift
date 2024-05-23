//
//  ProductCart.swift
//  AntiquesApp
//
//  Created by 24 on 18/5/2567 BE.
//

import Foundation
import FirebaseFirestoreSwift

struct ProductCart: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
    var description: String
    var price: Double
    var imageUrl: String
    var stock: Int
}

