import SwiftUI

struct OptimizationStep: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let color: Color
    var isCompleted: Bool = false
}

struct OptimizeView: View {
    @State private var steps: [OptimizationStep] = [
        OptimizationStep(
            icon: "moon.fill",
            title: "Activar No Molestar",
            description: "Evita interrupciones durante la partida",
            color: .purple
        ),
        OptimizationStep(
            icon: "wifi",
            title: "Verificar conexión WiFi",
            description: "Asegúrate de estar en WiFi, no datos móviles",
            color: .blue
        ),
        OptimizationStep(
            icon: "square.stack.3d.up.slash",
            title: "Cerrar apps en segundo plano",
            description: "Libera RAM para Free Fire",
            color: .orange
        ),
        OptimizationStep(
            icon: "sun.min.fill",
            title: "Reducir brillo",
            description: "Baja el brillo al 40-50% para ahorrar batería",
            color: .yellow
        ),
        OptimizationStep(
            icon: "speaker.slash.fill",
            title: "Desactivar sonidos del sistema",
            description: "Silencia notificaciones y teclado",
            color: .red
        ),
        OptimizationStep(
            icon: "location.slash.fill",
            title: "Desactivar GPS innecesario",
            description: "Ahorra batería y CPU desactivando ubicación",
            color: .green
        ),
        OptimizationStep(
            icon: "bolt.fill",
            title: "Desactivar Modo Bajo Consumo",
            description: "El modo bajo consumo limita el rendimiento",
            color: .yellow
        ),
        OptimizationStep(
            icon: "checkmark.seal.fill",
            title: "¡Listo para jugar!",
            description: "Tu iPhone está optimizado para Free Fire",
            color: .green
        )
    ]

    @State private var isRunning: Bool = false
    @State private var currentStep: Int = 0
    @State private var isFinished: Bool = false
    @State private var showInstructions: Bool = false
    @State private var selectedStep: OptimizationStep? = nil

    var completedCount: Int {
        steps.filter { $0.isCompleted }.count
    }

    var progress: Double {
        Double(completedCount) / Double(steps.count)
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.black, Color(red: 0.05, green: 0.05, blue: 0.12)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {

                        // Título
                        VStack(spacing: 6) {
                            Text("⚡ Optimización")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundColor(.white)
                            Text("Sigue los pasos para máximo rendimiento")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 20)

                        // Barra de progreso
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Progreso")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(completedCount)/\(steps.count)")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            }
                            ProgressView(value: progress)
                                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                                .scaleEffect(x: 1, y: 2, anchor: .center)
                        }
                        .padding()
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(12)
                        .padding(.horizontal)

                        // Botón de optimización automática
                        if !isFinished {
                            Button(action: startAutoOptimization) {
                                HStack {
                                    Image(systemName: isRunning ? "stop.circle.fill" : "play.circle.fill")
                                        .font(.title2)
                                    Text(isRunning ? "Optimizando..." : "🚀 Optimización Automática")
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isRunning ? Color.orange : Color.green)
                                .cornerRadius(14)
                                .shadow(color: isRunning ? .orange : .green, radius: 8)
                            }
                            .padding(.horizontal)
                            .disabled(isRunning)
                        } else {
                            // Botón de reinicio
                            Button(action: resetOptimization) {
                                HStack {
                                    Image(systemName: "arrow.clockwise.circle.fill")
                                        .font(.title2)
                                    Text("Reiniciar Optimización")
                                        .fontWeight(.bold)
                                }
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(14)
                            }
                            .padding(.horizontal)
                        }

                        // Lista de pasos
                        VStack(spacing: 10) {
                            ForEach(Array(steps.enumerated()), id: \.element.id) { index, step in
                                StepCard(
                                    step: step,
                                    isActive: isRunning && currentStep == index,
                                    onTap: {
                                        selectedStep = step
                                        showInstructions = true
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)

                        if isFinished {
                            VStack(spacing: 10) {
                                Text("🎮 ¡iPhone Optimizado!")
                                    .font(.title2)
                                    .fontWeight(.black)
                                    .foregroundColor(.green)
                                Text("Abre Free Fire y disfruta del máximo rendimiento")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)

                                // Botón para abrir Free Fire
                                Button(action: openFreeFire) {
                                    HStack {
                                        Image(systemName: "flame.fill")
                                        Text("Abrir Free Fire")
                                            .fontWeight(.bold)
                                    }
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red.opacity(0.8))
                                    .cornerRadius(14)
                                }
                            }
                            .padding()
                            .background(Color.green.opacity(0.08))
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.green.opacity(0.4), lineWidth: 1)
                            )
                            .padding(.horizontal)
                        }

                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showInstructions) {
            if let step = selectedStep {
                InstructionSheet(step: step)
            }
        }
    }

    func startAutoOptimization() {
        isRunning = true
        currentStep = 0
        animateSteps()
    }

    func animateSteps() {
        guard currentStep < steps.count else {
            isRunning = false
            isFinished = true
            UserDefaults.standard.set(true, forKey: "isOptimized")
            NotificationCenter.default.post(name: NSNotification.Name("OptimizationChanged"), object: nil)
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            steps[currentStep].isCompleted = true
            currentStep += 1
            animateSteps()
        }
    }

    func resetOptimization() {
        isFinished = false
        isRunning = false
        currentStep = 0
        for i in 0..<steps.count {
            steps[i].isCompleted = false
        }
        UserDefaults.standard.set(false, forKey: "isOptimized")
        NotificationCenter.default.post(name: NSNotification.Name("OptimizationChanged"), object: nil)
    }

    func openFreeFire() {
        // Intenta abrir Free Fire por su URL scheme
        if let url = URL(string: "freefire://") {
            UIApplication.shared.open(url, options: [:]) { success in
                if !success {
                    // Si no está instalado, abre la App Store
                    if let appStoreURL = URL(string: "https://apps.apple.com/app/free-fire/id1300146617") {
                        UIApplication.shared.open(appStoreURL)
                    }
                }
            }
        }
    }
}

struct StepCard: View {
    let step: OptimizationStep
    let isActive: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .fill(step.isCompleted ? step.color : Color.white.opacity(0.1))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Circle()
                                .stroke(isActive ? step.color : Color.clear, lineWidth: 2)
                                .scaleEffect(isActive ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.5).repeatForever(), value: isActive)
                        )

                    Image(systemName: step.isCompleted ? "checkmark" : step.icon)
                        .foregroundColor(step.isCompleted ? .black : step.color)
                        .font(.system(size: 18, weight: .bold))
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(step.title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(step.isCompleted ? .green : .white)
                    Text(step.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.opacity(isActive ? 0.1 : 0.04))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isActive ? step.color.opacity(0.6) : Color.white.opacity(0.08), lineWidth: 1)
            )
        }
    }
}

struct InstructionSheet: View {
    let step: OptimizationStep
    @Environment(\.dismiss) var dismiss

    var instructions: String {
        switch step.title {
        case "Activar No Molestar":
            return "1. Abre Ajustes\n2. Toca 'Enfoque'\n3. Selecciona 'No Molestar'\n4. Actívalo\n\nO desliza desde arriba a la derecha y toca el icono de luna 🌙"
        case "Verificar conexión WiFi":
            return "1. Abre Ajustes\n2. Toca 'WiFi'\n3. Conéctate a tu red WiFi\n4. Preferiblemente usa la banda 5GHz si tu router la tiene\n\nEvita jugar con datos móviles, la latencia es mayor."
        case "Cerrar apps en segundo plano":
            return "1. Desliza hacia arriba desde la parte inferior de la pantalla\n2. Mantén presionado hasta que aparezcan las apps\n3. Desliza cada app hacia arriba para cerrarla\n4. Cierra TODAS excepto GamerBoost"
        case "Reducir brillo":
            return "1. Desliza desde arriba a la derecha\n2. Baja el control de brillo al 40-50%\n\nO ve a Ajustes → Pantalla y Brillo"
        case "Silenciar notificaciones":
            return "1. Abre Ajustes\n2. Ve a 'Sonidos y Hápticos'\n3. Baja el volumen del timbre\n4. Desactiva 'Teclado Clics'"
        case "Desactivar GPS innecesario":
            return "1. Abre Ajustes\n2. Ve a 'Privacidad y Seguridad'\n3. Toca 'Localización'\n4. Desactiva las apps que no necesiten GPS"
        case "Desactivar Modo Bajo Consumo":
            return "1. Abre Ajustes\n2. Toca 'Batería'\n3. Desactiva 'Modo de bajo consumo'\n\n⚠️ Este modo limita el rendimiento del procesador. Desactívalo para jugar."
        default:
            return "¡Tu iPhone está listo para Free Fire! Abre el juego y disfruta del máximo rendimiento."
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Button("Cerrar") { dismiss() }
                        .foregroundColor(.green)
                        .padding()
                }

                Image(systemName: step.icon)
                    .font(.system(size: 60))
                    .foregroundColor(step.color)
                    .shadow(color: step.color, radius: 10)

                Text(step.title)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.white)

                Text(step.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Divider()
                    .background(Color.white.opacity(0.2))
                    .padding(.horizontal)

                ScrollView {
                    Text(instructions)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    OptimizeView()
}
