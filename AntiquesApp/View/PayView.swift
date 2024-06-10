//
//  PayView.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 25/5/2567 BE.
//

import SwiftUI


struct PayView: View {
    @State private var shippingOption: String = "EMS"
    @State private var paymentOption: String = "COD"
    @EnvironmentObject var dataModel: Data_Model
    @StateObject private var viewModel = Product_Model()
    @Binding var itemCount: Int
    @Binding var totalPrice: Double
    var selectedProducts: [ProductCart]
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
            
            List(selectedProducts) { product in
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    HStack {
                        VStack {
                            Text("จำนวน:  \(product.quantity ?? 1)")
                                .font(.subheadline)
                        }
                        .padding(.bottom, 5)
                        VStack {
                            Text("ราคาต่อชิ้น: \(String(format: "%.2f", product.price))")
                                .font(.subheadline)
                        }
                        .padding(.bottom, 5)
                    }
                    HStack {
                        Text("ราคารวม: \(String(format: "%.2f", product.price * Double(product.quantity ?? 1)))")
                            .font(.subheadline)
                    }
                    .padding(.bottom, 5)
                }
                .padding(.vertical, 5)
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
                    viewModel.BuyProducts(
                        selectedProducts: selectedProducts,
                        totalPrice: totalPrice,
                        user: dataModel.user,
                        shippingOption: shippingOption,
                        paymentOption: paymentOption
                    )
                }) {
                    Text("ยืนยันคำสั่งซื้อ")
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
        @State var itemCount = 0
        @State var totalPrice = 0.0
        
        PayView(itemCount: $itemCount, totalPrice: $totalPrice, selectedProducts: [])   .environmentObject(Data_Model())
    }
}


