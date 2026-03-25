import SwiftUI

struct MainView: View {
    @State private var selectedIndex: Int = 0
    @State private var showProfile = false
    @AppStorage("coffeeBalance") private var coffeeBalance: Int = 0

    private let characters = FortuneTeller.all

    var body: some View {
        ZStack {
            // Ambient background that changes with character
            characters[selectedIndex].ambianceColor
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.6), value: selectedIndex)

            // Subtle star particles
            StarsBackgroundView()

            VStack(spacing: 0) {
                // Top bar
                topBar

                Spacer()

                // Character carousel
                TabView(selection: $selectedIndex) {
                    ForEach(Array(characters.enumerated()), id: \.element.id) { index, character in
                        CharacterCardView(character: character)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(maxHeight: .infinity)

                Spacer()
            }
        }
        .sheet(isPresented: $showProfile) {
            ProfileView()
        }
    }

    private var topBar: some View {
        HStack {
            // App logo/name
            Text("Mystic Queen")
                .font(MQTheme.pixelLogo(10))
                .foregroundStyle(MQTheme.gold)

            Spacer()

            // Coffee balance
            HStack(spacing: 4) {
                Text("☕")
                    .font(.system(size: 16))
                Text("\(coffeeBalance)")
                    .font(MQTheme.button())
                    .foregroundStyle(MQTheme.coffee)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(MQTheme.backgroundCard.opacity(0.8))
            .clipShape(Capsule())

            // Profile button
            Button {
                showProfile = true
            } label: {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(MQTheme.gold)
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
