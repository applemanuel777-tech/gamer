import SwiftUI

struct GameProfile: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    let tips: [String]
}

struct ProfileView: View {
    let games: [GameProfile] = [
        GameProfile(
            name: "Free Fire",
            icon: "flame.fill",
            color: .orange,
            tips: [
                "Usa resolución Media para mejor FPS",
                "Desactiva sombras en configuración gráfica",
                "Activa 'Modo Ultra' en ajustes del juego",
                "Usa auriculares para escuchar pasos",
                "Juega con WiFi 5GHz para menor ping"
            ]
        ),
        GameProfile(
            name: "PUBG Mobile",
            icon: "scope",
            color: .yellow,
            tips: [
                "Configura gráficos en Suave + Alta velocidad",
                "Desactiva efectos de estilo",
                "Usa sensibilidad personalizada",
                "Activa el modo de 60fps si tu iPhone lo soporta",
                "Cierra apps antes de entrar a la partida"
            ]
        ),
        GameProfile(
            name: "Call of Duty Mobile",
            icon: "target",
            color: .red,
            tips: [
                "Configura gráficos en Bajo para más FPS",
                "Desactiva sombras y efectos de agua",
                "Usa el modo de 60fps",
                "Activa el modo de alto rendimiento",
                "Mantén el iPhone cargado al 50%+"
            ]
        ),
        GameProfile(
            name: "Clash Royale",
            icon: "crown.fill",
            color: .purple,
            tips: [
                "Juego ligero, cualquier configuración funciona",
                "Asegura buena conexión para evitar desconexiones",
                "Juega en modo horizontal para mejor visión",
                "Activa notificaciones de cofres",
                "Usa WiFi para partidas clasificatorias"
            ]
        )
    ]

    @State private var selectedGame: GameProfile? = nil

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.black, Color(red: 0.08, green: 0.05, blue: 0.12)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {

                        VStack(spacing: 6) {
                            Text("🎮 Perfiles de Juego")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            Text("Tips específicos por juego")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 20)

                        // Tarjetas de juegos
                        ForEach(games) { game in
                            GameCard(game: game) {
                                selectedGame = game
                            }
                        }
                        .padding(.horizontal)

                        // Sección de configuración recomendada
                        VStack(alignment: .leading, spacing: 12) {
                            Text("⚙️ Configuración iOS Recomendada")
                                .font(.headline)
                                .foregroundColor(.cyan)

                            SettingRow(icon: "display", text: "Resolución nativa activada", color: .blue)
                            SettingRow(icon: "bolt.fill", text: "Modo bajo consumo: DESACTIVADO", color: .yellow)
                            SettingRow(icon: "wifi", text: "WiFi 5GHz preferido", color: .green)
                            SettingRow(icon: "moon.fill", text: "No Molestar: ACTIVADO al jugar", color: .purple)
                            SettingRow(icon: "thermometer.medium", text: "Temperatura: mantener fresco", color: .red)
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.cyan.opacity(0.3), lineWidth: 1)
                        )
                        .padding(.horizontal)

                        // Info sobre la app
                        VStack(spacing: 8) {
                            Text("GamerBoost v1.0")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("Optimizador para gamers de iPhone")
                                .font(.caption2)
                                .foregroundColor(.gray.opacity(0.6))
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: Binding(
            get: { selectedGame != nil },
            set: { if !$0 { selectedGame = nil } }
        )) {
            if let game = selectedGame {
                GameTipsSheet(game: game)
            }
        }
    }
}

struct GameCard: View {
    let game: GameProfile
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(game.color.opacity(0.2))
                        .frame(width: 56, height: 56)
                    Image(systemName: game.icon)
                        .font(.system(size: 24))
                        .foregroundColor(game.color)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(game.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("\(game.tips.count) tips de optimización")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.opacity(0.05))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(game.color.opacity(0.25), lineWidth: 1)
            )
        }
    }
}

struct SettingRow: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 20)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
        }
    }
}

struct GameTipsSheet: View {
    let game: GameProfile
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button("Cerrar") { dismiss() }
                        .foregroundColor(.green)
                        .padding()
                }

                VStack(spacing: 12) {
                    Image(systemName: game.icon)
                        .font(.system(size: 60))
                        .foregroundColor(game.color)
                        .shadow(color: game.color, radius: 10)

                    Text(game.name)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.white)

                    Text("Tips de optimización")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()

                Divider()
                    .background(Color.white.opacity(0.2))
                    .padding(.horizontal)

                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        ForEach(Array(game.tips.enumerated()), id: \.offset) { index, tip in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(index + 1)")
                                    .font(.caption)
                                    .fontWeight(.black)
                                    .foregroundColor(.black)
                                    .frame(width: 22, height: 22)
                                    .background(game.color)
                                    .clipShape(Circle())

                                Text(tip)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    ProfileView()
}
