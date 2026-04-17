import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "gamecontroller.fill")
                }

            OptimizeView()
                .tabItem {
                    Label("Optimizar", systemImage: "bolt.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.fill")
                }
        }
        .accentColor(.green)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
