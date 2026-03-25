import SwiftUI

struct CharacterCardView: View {
    let character: FortuneTeller
    @State private var glowPulse = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(character.roomName)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .overlay(
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

                VStack(spacing: 0) {
                    Spacer()

                    Image(character.avatarName)
                        .resizable()
                        .interpolation(.none)
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .shadow(color: character.accentColor.opacity(glowPulse ? 0.5 : 0.2), radius: glowPulse ? 25 : 15)

                    Spacer()
                        .frame(height: 16)

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

                    // Fal Baktır button — disabled until Phase 4 is built
                    VStack(spacing: 10) {
                        Button {} label: {
                            HStack(spacing: 6) {
                                Text("☕")
                                Text("Fal Baktır")
                                    .font(MQTheme.button())
                            }
                            .foregroundStyle(MQTheme.backgroundDark)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(MQTheme.goldDim)
                            .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
                        }
                        .disabled(true)
                        .opacity(0.5)

                        Button {} label: {
                            HStack(spacing: 6) {
                                Image(systemName: "calendar.badge.clock")
                                Text("Randevu Al")
                                    .font(MQTheme.button())
                            }
                            .foregroundStyle(character.accentColor.opacity(0.4))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(character.accentColor.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
                        }
                        .disabled(true)
                        .opacity(0.5)

                        Text("Çok yakında")
                            .font(MQTheme.caption(11))
                            .foregroundStyle(MQTheme.textMuted)
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
