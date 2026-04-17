import SwiftUI

struct HomeView: View {
    @State private var batteryLevel: Float = 0.0
    @State private var isOptimized: Bool = false
    @State private var currentTipIndex: Int = 0
    @State private var showShortcutAlert: Bool = false

    let tips = [
        "🔇 Activa el modo No Molestar antes de jugar",
        "📶 Conéctate a WiFi 5GHz para menor latencia",
        "🌡️ Mantén tu iPhone fresco para evitar throttling",
        "🔋 Carga al 80% antes de jugar para mejor rendimiento",
        "📱 Cierra todas las apps en segundo plano",
        "🔆 Baja el brillo al 50% para ahorrar batería",
        "🎮 Usa auriculares para mejor experiencia de audio",
        "📡 Desactiva Bluetooth si no lo usas"
    ]

    var batteryColor: Color {
        if batteryLevel > 0.5 { return .green }
        else if batteryLevel > 0.2 { return .yellow }
        else { return .red }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.black, Color(red: 0.05, green: 0.1, blue: 0.05)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        VStack(spacing: 6) {
                            Image(systemName: "gamecontroller.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.green)
                                .shadow(color: .green, radius: 10)
                            Text("GamerBoost")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            Text("Optimizador para Free Fire")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Creado por †ᴶᴹメＭʏxᴏʀ₇⁷₇")
                                .font(.caption)
                                .foregroundColor(.green.opacity(0.8))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)
                        }
                        .padding(.top, 20)

                        Button(action: runGamerShortcut) {
                            HStack(spacing: 12) {
                                Image(systemName: "bolt.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(.black)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("⚡ ACTIVAR MODO GAMER")
                                        .font(.headline)
                                        .fontWeight(.black)
                                        .foregroundColor(.black)
                                    Text("Ejecuta optimización completa")
                                        .font(.caption)
                                        .foregroundColor(.black.opacity(0.7))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black.opacity(0.6))
                            }
                            .padding()
                            .background(LinearGradient(colors: [Color.green, Color(red: 0.0, green: 0.7, blue: 0.3)], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(16)
                            .shadow(color: .green, radius: 12, x: 0, y: 4)
                        }
                        .padding(.horizontal)
                        .alert("Atajo no encontrado", isPresented: $showShortcutAlert) {
                            Button("OK", role: .cancel) {}
                        } message: {
                            Text("Asegurate de tener el atajo 'Modo Gamer Free Fire' en la app Atajos.")
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Estado del Dispositivo")
                                .font(.headline)
                                .foregroundColor(.green)
                            HStack {
                                Image(systemName: "battery.75").foregroundColor(batteryColor)
                                Text("Bateria: \(Int(batteryLevel * 100))%").foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "memorychip").foregroundColor(.blue)
                                Text("Modelo: \(UIDevice.current.model)").foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "iphone").foregroundColor(.purple)
                                Text("iOS \(UIDevice.current.systemVersion)").foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                        .padding(.horizontal)

                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("💡 Tip del dia")
                                    .font(.headline)
                                    .foregroundColor(.yellow)
                                Spacer()
                                Button("Siguiente") {
                                    currentTipIndex = (currentTipIndex + 1) % tips.count
                                }
                                .font(.caption)
                                .foregroundColor(.green)
                            }
                            Text(tips[currentTipIndex])
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.yellow.opacity(0.08))
                        .cornerRadius(16)
                        .padding(.horizontal)

                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            UIDevice.current.isBatteryMonitoringEnabled = true
            batteryLevel = UIDevice.current.batteryLevel < 0 ? 0.8 : UIDevice.current.batteryLevel
            isOptimized = UserDefaults.standard.bool(forKey: "isOptimized")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification)) { _ in
            batteryLevel = UIDevice.current.batteryLevel < 0 ? 0.8 : UIDevice.current.batteryLevel
        }
    }

    func runGamerShortcut() {
        let shortcutName = "Modo Gamer Free Fire"
        let encoded = shortcutName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? shortcutName
        if let url = URL(string: "shortcuts://run-shortcut?name=\(encoded)") {
            UIApplication.shared.open(url)
            UserDefaults.standard.set(true, forKey: "isOptimized")
        } else {
            showShortcutAlert = true
        }
    }
}

#Preview {
    HomeView()
}
