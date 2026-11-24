import SwiftUI


struct ContentView: View {
    var body: some View {
        WelcomeView()
    }
}

extension Color {
    static let ferNavy       = Color(red: 0x14 / 255, green: 0x3F / 255, blue: 0x90 / 255)
    static let ferNavyDeep   = Color(red: 0x0B / 255, green: 0x2A / 255, blue: 0x66 / 255)

    static let ferNavyBright = Color(red: 0x24 / 255, green: 0x56 / 255, blue: 0xB8 / 255)
}

extension Font {
    static let ferHeadlineMedium = Font.custom("OpenSans-Bold", size: 26)
    static let ferBodyLarge      = Font.custom("OpenSans-Regular", size: 16)
    static let ferLabelLarge     = Font.custom("OpenSans-SemiBold", size: 14)
}

struct WelcomeView: View {
    var onStart: () -> Void = {}

    var body: some View {
        ZStack {
            BrandBackground()
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                LogoView()
                    .frame(width: 200, height: 200)
                Spacer().frame(height: 48)

                Text("Toda la información de la Fundación, en un solo lugar")
                    .font(.ferHeadlineMedium)
                    .lineSpacing(8)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .bold()
            
                Spacer().frame(height: 12)
                Text("Avisos, convocatorias y fechas importantes, directo en tu celular.")
                    .font(.ferBodyLarge)
                    .lineSpacing(10)
                    .foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action: onStart) {
                    Text("Comenzar")
                        .font(.ferLabelLarge)
                        .foregroundStyle(Color.ferNavy)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(.white, in: Capsule())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 24)
        }
    }
}

struct LogoView: View {
    var body: some View {
        Image("logo_fer")
            .resizable()
            .scaledToFit()
    }
}

struct BrandBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.ferNavyBright, .ferNavy, .ferNavyDeep],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Canvas { context, size in
                let w = size.width
                let h = size.height
                let facet = GraphicsContext.Shading.color(.white.opacity(0.05))

                context.fill(polygon([
                    CGPoint(x: 0, y: h * 0.62),
                    CGPoint(x: w * 0.55, y: h * 0.80),
                    CGPoint(x: 0, y: h)
                ]), with: facet)

                context.fill(polygon([
                    CGPoint(x: w, y: h * 0.70),
                    CGPoint(x: w * 0.35, y: h),
                    CGPoint(x: w, y: h)
                ]), with: facet)

                context.fill(polygon([
                    CGPoint(x: w * 0.6, y: 0),
                    CGPoint(x: w, y: 0),
                    CGPoint(x: w, y: h * 0.25)
                ]), with: .color(.white.opacity(0.04)))
            }
        }
    }
}

private func polygon(_ points: [CGPoint]) -> Path {
    var path = Path()
    guard let first = points.first else { return path }
    path.move(to: first)
    for point in points.dropFirst() {
        path.addLine(to: point)
    }
    path.closeSubpath()
    return path
}

#Preview {
    ContentView()
}
