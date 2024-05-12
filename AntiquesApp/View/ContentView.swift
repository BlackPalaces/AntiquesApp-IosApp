import SwiftUI


struct ContentView: View {
    @EnvironmentObject var dataModel: Data_Model
    var body: some View {
       TabItem()
    }
}

struct TabItem: View {
var body: some View {
TabView {
    Home()
    .tabItem {
    Label("Home", systemImage: "square.grid.2x2.fill")
    }
    Cart()
    .tabItem {
    Label("Cart", systemImage: "cart")
    }
    Favorite()
    .tabItem {
    Label("Favorite", systemImage: "heart.fill")
    }
    Profile()
    .tabItem {
    Label("Profile", systemImage: "person")
    }
}
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Data_Model())
    }
}
