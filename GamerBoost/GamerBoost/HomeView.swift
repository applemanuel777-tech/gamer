import SwiftUI

struct HomeView: View {
    @State private var batteryLevel: Float = 0.0
    @State private var isOptimized: Bool = false
    @State private var showTip: Bool = false
    @State private var currentTipIndex: Int = 0

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
                // Fondo oscuro
                LinearGradient(
                    colors: [Color.black, Color(red: 0.05, green: 0.1, blue: 0.05)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {

                        // Header
                        VStack(spacing: 8) {
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
                        }
                        .padding(.top, 20)

                        // Estado del dispositivo
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Estado del Dispositivo")
                                .font(.headline)
                                .foregroundColor(.green)

                            HStack {
                                Image(systemName: "battery.75")
                                    .foregroundColor(batteryColor)
                                Text("Batería: \(Int(batteryLevel * 100))%")
                                    .foregroundColor(.white)
                                Spacer()
                                Circle()
                                    .fill(batteryColor)
                                    .frame(width: 10, height: 10)
                            }

                            HStack {
                                Image(systemName: "memorychip")
                                    .foregroundColor(.blue)
                                Text("Modelo: \(UIDevice.current.model)")
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
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.green.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal)

                        // Estado de optimización
                        VStack(spacing: 12) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(isOptimized ? "✅ Optimizado" : "⚠️ Sin Optimizar")
                                        .font(.headline)
                                        .foregroundColor(isOptimized ? .green : .orange)
                                    Text(isOptimized ? "Listo para jugar Free Fire" : "Ve a la pestaña Optimizar")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Image(systemName: isOptimized ? "checkmark.shield.fill" : "exclamationmark.shield.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(isOptimized ? .green : .orange)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke((isOptimized ? Color.green : Color.orange).opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal)

                        // Tip del día
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("💡 Tip del día")
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
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                        .background(Color.yellow.opacity(0.08))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.yellow.opacity(0.3), lineWidth: 1)
                        )
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
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("OptimizationChanged"))) { _ in
            isOptimized = UserDefaults.standard.bool(forKey: "isOptimized")
        }
    }
}

#Preview {
    HomeView()
}
