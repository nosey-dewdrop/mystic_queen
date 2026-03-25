import SwiftUI

struct MainView: View {
    @State private var selectedIndex: Int = 0
    @State private var showProfile = false
    @ObservedObject private var creditManager = CreditManager.shared

    private let characters = FortuneTeller.all

    var body: some View {
        ZStack {
            // Base dark background
            Color.black.ignoresSafeArea()

            // Character carousel — full screen, immersive
            TabView(selection: $selectedIndex) {
                ForEach(Array(characters.enumerated()), id: \.element.id) { index, character in
                    CharacterCardView(character: character)
                        .tag(index)
                        .ignoresSafeArea()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .ignoresSafeArea()

            // Top bar overlay — always on top
            VStack {
                topBar
                Spacer()
            }
        }
        .sheet(isPresented: $showProfile) {
            ProfileView()
        }
    }

    private var topBar: some View {
        HStack {
            // App logo
            Text("Mystic Queen")
                .font(MQTheme.pixelLogo(9))
                .foregroundStyle(MQTheme.gold)
                .shadow(color: .black.opacity(0.8), radius: 4)

            Spacer()

            // Coffee balance
            HStack(spacing: 4) {
                Text("☕")
                    .font(.system(size: 14))
                Text("\(creditManager.coffeeBalance)")
                    .font(MQTheme.button())
                    .foregroundStyle(MQTheme.coffee)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.ultraThinMaterial.opacity(0.6))
            .clipShape(Capsule())

            // Profile button
            Button {
                showProfile = true
            } label: {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(MQTheme.gold)
                    .shadow(color: .black.opacity(0.5), radius: 3)
            }
        }
        .padding(.horizontal, MQTheme.paddingMedium)
        .padding(.top, 8)
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
}
