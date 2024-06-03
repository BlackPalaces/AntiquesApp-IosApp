//
//  PayView.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 25/5/2567 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore


struct PayView: View {
    @State private var shippingOption: String = ""
    @State private var paymentOption: String = ""
    @EnvironmentObject var dataModel: Data_Model
    @StateObject private var viewModel = Product_Model()
    var selectedProducts: [ProductCart]
    var totalPrice: Double
    @State private var shippingOption: String = "EMS"
    @State private var paymentOption: String = "COD"

    
    
    @State private var checkedProductIds: Set<String> = []

    var checkedProducts: [ProductCart] {
        selectedProducts.filter { checkedProductIds.contains($0.id ?? "") }
    }
    
    
    var body: some View {
        
        NavigationView {
        VStack {
            VStack {
                Text("ที่อยู่ในการจัดส่ง")
                Text(dataModel.user.Username ?? "ไม่มีชื่อ")
                Text(dataModel.user.Phone ?? "ไม่มีเบอร์")
                Text(dataModel.user.Address ?? "ไม่มีที่อยู่")
            }
            .foregroundColor(.black) // Set the text color to black
            
            List(selectedProducts, id: \.id) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    HStack {
                        VStack{
                            Text("ราคา: \(String(format: "%.2f", product.price))")
                            //Text("จำนวนที่สั่ง: ")
                        }
                    }
                }
            }

            Spacer()
            Section(header: Text("วิธีการจัดส่ง").font(.headline).frame(maxWidth: .infinity, alignment: .leading)) {
                HStack {
                    Text("เลือกวิธีการจัดส่ง")
                        .font(.system(size: 16, weight: .bold))
                        .alignmentGuide(.leading) { d in d[.leading] }
                    Spacer()
                    Picker(selection: $shippingOption, label: Text("เลือกวิธีการจัดส่ง")) {
                        Text("จัดส่งทาง EMS").tag("EMS")
                        Text("จัดส่งทาง Kerry").tag("Kerry")
                    }
                    .pickerStyle(.menu)
                }
            }
            Spacer()
            Section(header: Text("วิธีการชำระเงิน").font(.headline).frame(maxWidth: .infinity, alignment: .leading)) {
                HStack {
                    Text("เลือกวิธีการชำระเงิน")
                        .font(.system(size: 16, weight: .bold))
                        .alignmentGuide(.leading) { d in d[.leading] }
                    Spacer()
                    Picker(selection: $paymentOption, label: Text("เลือกวิธีการชำระเงิน")) {
                        Text("ชำระเงินปลายทาง").tag("COD")
                        Text("ชำระเงินผ่านบัตรเครดิต").tag("Credit Card")
                    }
                    .pickerStyle(.menu)
                }
            }


            HStack {
                VStack(alignment: .leading) {
                    Text("ยอดสั่งซื้อทั้งหมดรวม: ")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(totalPrice, specifier: "%.2f") บาท")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading) //show total price from previous view
                }
                Spacer() 
                Button(action: {
                    let db = Firestore.firestore()
                    let user = Auth.auth().currentUser
                    let timestamp = Timestamp(date: Date())
                    let orderData: [String: Any] = [
                        "date": timestamp,
                        "products": selectedProducts.map { product in
                            return [
                                "name": product.name,
                                "image": product.imageUrl,
                                "price": product.price
                            ]
                        },
                        "shipping": shippingOption,
                        "payment": paymentOption
                    ]
                    if let userId = user?.uid {
                        db.collection("users").document(userId).collection("orders").addDocument(data: orderData) { err in
                            if let err = err {
                                print("Error adding document: \(err)")
                            } else {
                                print("Order successfully placed")
                                print("\(orderData)")
                            }
                        }
                    } else {
                        print("User not found")
                    }
                }) {
                    Text("ยืนยัน")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                }


            }
            Spacer()
        }
        .onAppear {
                    // Load dataModel here
                    dataModel.fetchUserinfo()
                }
    }
        
    }
    
}


struct PayView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyProducts: [ProductCart] = [
            ProductCart(id: "1", name: "Product 1", description: "Description 1", price: 10.0, imageUrl: "https://example.com/image1.jpg", stock: 5)
        ]
        let totalPrice: Double = 10.0
        return PayView(selectedProducts: dummyProducts, totalPrice: totalPrice)
            .environmentObject(Data_Model())
    }
}

