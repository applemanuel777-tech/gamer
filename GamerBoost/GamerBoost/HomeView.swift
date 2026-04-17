import SwiftUI

struct HomeView: View {
    @State private var batteryLevel: Float = 0.0
    @State private var isOptimized: Bool = false
    @State private var currentTipIndex: Int = 0
    @State private var showShortcutAlert: Bool = false

    let tips = [
        "Activa el modo No Molestar antes de jugar",
        "Conectate a WiFi 5GHz para menor latencia",
        "Manten tu iPhone fresco para evitar throttling",
        "Carga al 80% antes de jugar",
        "Cierra todas las apps en segundo plano",
        "Baja el brillo al 50% para ahorrar bateria",
        "Usa auriculares para mejor audio",
        "Desactiva Bluetooth si no lo usas"
    ]

    var batteryColor: Color {
        if batteryLevel > 0.5 { return .green }
        else if batteryLevel > 0.2 { return .yellow }
        else { return .red }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {

                        // Header
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
                            Text("Creado por \u{2020}\u{1D36}\u{1D39}\u{30E1}\u{FF2D}\u{028F}\u{0078}\u{1D52}\u{0052}\u{2087}\u{2077}\u{2087}")
                                .font(.caption)
                                .foregroundColor(.green)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)
                        }
                        .padding(.top, 20)

                        // Estado
                        HStack {
                            Image(systemName: isOptimized ? "checkmark.shield.fill" : "exclamationmark.shield.fill")
                                .foregroundColor(isOptimized ? .green : .orange)
                                .font(.title2)
                            VStack(alignment: .leading) {
                                Text(isOptimized ? "Modo Gamer Activo" : "Sin Optimizar")
                                    .fontWeight(.bold)
                                    .foregroundColor(isOptimized ? .green : .orange)
                                Text(isOptimized ? "Listo para jugar Free Fire" : "Toca Activar Modo Gamer")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                        .padding(.horizontal)

                        // Boton ACTIVAR
                        Button(action: { runShortcut(name: "Modo Gamer Free Fire", activate: true) }) {
                            HStack(spacing: 12) {
                                Image(systemName: "bolt.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.black)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("ACTIVAR MODO GAMER")
                                        .font(.headline)
                                        .fontWeight(.black)
                                        .foregroundColor(.black)
                                    Text("Optimiza iPhone y abre Free Fire")
                                        .font(.caption)
                                        .foregroundColor(.black.opacity(0.7))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black.opacity(0.5))
                            }
                            .padding()
                            .background(Color.green)
                            .cornerRadius(16)
                            .shadow(color: .green.opacity(0.5), radius: 10, x: 0, y: 4)
                        }
                        .padding(.horizontal)

                        // Boton DESACTIVAR
                        Button(action: { runShortcut(name: "Desactivar Modo Gamer FF", activate: false) }) {
                            HStack(spacing: 12) {
                                Image(systemName: "stop.circle.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.white)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("DESACTIVAR MODO GAMER")
                                        .font(.headline)
                                        .fontWeight(.black)
                                        .foregroundColor(.white)
                                    Text("Regresa a configuracion normal")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.7))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(16)
                            .shadow(color: .red.opacity(0.4), radius: 10, x: 0, y: 4)
                        }
                        .padding(.horizontal)
                        .alert("Atajo no encontrado", isPresented: $showShortcutAlert) {
                            Button("OK", role: .cancel) {}
                        } message: {
                            Text("Asegurate de tener los atajos instalados en la app Atajos de tu iPhone.")
                        }

                        // Estado del dispositivo
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Estado del Dispositivo")
                                .font(.headline)
                                .foregroundColor(.green)
                            HStack {
                                Image(systemName: "battery.75")
                                    .foregroundColor(batteryColor)
                                Text("Bateria: \(Int(batteryLevel * 100))%")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "iphone")
                                    .foregroundColor(.purple)
                                Text("iOS \(UIDevice.current.systemVersion)")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            HStack {
                                Image(systemName: "memorychip")
                                    .foregroundColor(.blue)
                                Text("Modelo: \(UIDevice.current.model)")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                        .padding(.horizontal)

                        // Tip del dia
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Tip del dia")
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

    func runShortcut(name: String, activate: Bool) {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
        if let url = URL(string: "shortcuts://run-shortcut?name=\(encoded)") {
            UIApplication.shared.open(url)
            isOptimized = activate
            UserDefaults.standard.set(activate, forKey: "isOptimized")
        } else {
            showShortcutAlert = true
        }
    }
}

#Preview {
    HomeView()
}
