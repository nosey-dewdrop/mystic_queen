import SwiftUI

struct StarData {
    let relativeX: CGFloat  // 0...1 normalized
    let relativeY: CGFloat  // 0...1 normalized
    let size: CGFloat
    let baseOpacity: Double
}

struct StarsBackgroundView: View {
    @State private var twinklePhase = false
    @State private var stars: [StarData] = []

    private static let starCount = 80

    var body: some View {
        Canvas { context, size in
            for star in stars {
                let x = star.relativeX * size.width
                let y = star.relativeY * size.height

                let rect = CGRect(
                    x: x - star.size / 2,
                    y: y - star.size / 2,
                    width: star.size,
                    height: star.size
                )

                context.opacity = twinklePhase ? star.baseOpacity : star.baseOpacity * 0.5
                context.fill(
                    Path(ellipseIn: rect),
                    with: .color(MQTheme.goldLight)
                )
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
        .onAppear {
            if stars.isEmpty {
                var rng = SeededRandomNumberGenerator(seed: 42)
                stars = (0..<Self.starCount).map { _ in
                    StarData(
                        relativeX: CGFloat.random(in: 0...1, using: &rng),
                        relativeY: CGFloat.random(in: 0...1, using: &rng),
                        size: CGFloat.random(in: 1...3, using: &rng),
                        baseOpacity: Double.random(in: 0.2...0.7, using: &rng)
                    )
                }
            }
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                twinklePhase = true
            }
        }
    }
}

/// Deterministic random number generator for consistent star positions
struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        state = seed
    }

    mutating func next() -> UInt64 {
        state = state &* 6364136223846793005 &+ 1442695040888963407
        return state
    }
}
