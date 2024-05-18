//
//  MainPage.swift
//  AntiquesApp
//
//  Created by Chinnaphat Dumpong on 12/5/2567 BE.
//

import SwiftUI


struct MainPage: View {
@EnvironmentObject var dataModel: Data_Model
    
    var body:some View {
        if dataModel.isLogin {
            ContentView()
        } else {
            ProductDetails()
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage().environmentObject(Data_Model())
    }
}
