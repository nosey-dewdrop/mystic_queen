import SwiftUI

struct CharacterCardView: View {
    let character: FortuneTeller
    @State private var showDetail = false
    @State private var glowPulse = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Room background — fills the entire card
                Image(character.roomName)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .overlay(
                        // Gradient overlay for readability on top/bottom
                        VStack(spacing: 0) {
                            LinearGradient(
                                colors: [character.ambianceColor, .clear],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: geo.size.height * 0.15)

                            Spacer()

                            LinearGradient(
                                colors: [.clear, character.ambianceColor.opacity(0.95)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .frame(height: geo.size.height * 0.45)
                        }
                    )

                // Content layered on top
                VStack(spacing: 0) {
                    Spacer()

                    // Character avatar with glow
                    Image(character.avatarName)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .shadow(color: character.accentColor.opacity(glowPulse ? 0.5 : 0.2), radius: glowPulse ? 25 : 15)

                    Spacer()
                        .frame(height: 16)

                    // Character info
                    VStack(spacing: 8) {
                        Text(character.name)
                            .font(MQTheme.title(24))
                            .foregroundStyle(character.accentColor)

                        Text(character.tagline)
                            .font(MQTheme.caption())
                            .foregroundStyle(MQTheme.textSecondary)

                        Text("\"\(character.greeting)\"")
                            .font(MQTheme.body(14))
                            .foregroundStyle(MQTheme.textPrimary.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, MQTheme.paddingLarge)
                            .italic()
                            .padding(.top, 4)

                        // Specialty icons
                        HStack(spacing: 16) {
                            ForEach(character.specialties) { specialty in
                                HStack(spacing: 4) {
                                    Image(systemName: specialty.icon)
                                        .font(.system(size: 14))
                                        .foregroundStyle(character.accentColor)
                                    Text(specialty.displayName)
                                        .font(MQTheme.caption(11))
                                        .foregroundStyle(MQTheme.textSecondary)
                                }
                            }
                        }
                        .padding(.top, 8)
                    }

                    Spacer()
                        .frame(height: 24)

                    // Action buttons
                    VStack(spacing: 10) {
                        Button {
                            showDetail = true
                        } label: {
                            HStack(spacing: 6) {
                                Text("☕")
                                Text("Fal Baktir")
                                    .font(MQTheme.button())
                            }
                            .foregroundStyle(MQTheme.backgroundDark)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(MQTheme.gold)
                            .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
                        }

                        Button {
                            // TODO: Navigate to appointment booking
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "calendar.badge.clock")
                                Text("Randevu Al")
                                    .font(MQTheme.button())
                            }
                            .foregroundStyle(character.accentColor)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(character.accentColor.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
                            .overlay(
                                RoundedRectangle(cornerRadius: MQTheme.cornerRadius)
                                    .stroke(character.accentColor.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, MQTheme.paddingLarge)
                    .padding(.bottom, MQTheme.paddingLarge + 20)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                glowPulse = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        CharacterCardView(character: FortuneTeller.all[0])
    }
    .preferredColorScheme(.dark)
}
