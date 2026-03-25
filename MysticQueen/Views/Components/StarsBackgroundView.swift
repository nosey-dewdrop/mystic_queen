import SwiftUI

struct StarsBackgroundView: View {
    @State private var twinklePhase = false

    var body: some View {
        Canvas { context, size in
            // Deterministic star positions
            var rng = SeededRandomNumberGenerator(seed: 42)

            for _ in 0..<80 {
                let x = CGFloat.random(in: 0...size.width, using: &rng)
                let y = CGFloat.random(in: 0...size.height, using: &rng)
                let starSize = CGFloat.random(in: 1...3, using: &rng)
                let opacity = Double.random(in: 0.2...0.7, using: &rng)

                let rect = CGRect(
                    x: x - starSize / 2,
                    y: y - starSize / 2,
                    width: starSize,
                    height: starSize
                )

                context.opacity = twinklePhase ? opacity : opacity * 0.5
                context.fill(
                    Path(ellipseIn: rect),
                    with: .color(MQTheme.goldLight)
                )
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
        .onAppear {
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
