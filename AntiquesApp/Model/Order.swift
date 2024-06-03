//
//  Order.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 3/6/2567 BE.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift // Import this if you haven't already
import Combine

struct Order: Identifiable, Codable {
    var id: String?
    var userId: String
    var username: String // เพิ่ม properties สำหรับชื่อผู้ใช้
    var phone: String // เพิ่ม properties สำหรับเบอร์โทร
    var address: String // เพิ่ม properties สำหรับที่อยู่
    var totalPrice: Double
    var orderDate: Date
    var products: [ProductCart]
}
