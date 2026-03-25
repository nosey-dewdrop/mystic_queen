import SwiftUI

struct CharacterCardView: View {
    let character: FortuneTeller
    @State private var showDetail = false

    var body: some View {
        VStack(spacing: MQTheme.paddingLarge) {
            Spacer()

            // Character avatar
            Image(character.avatarName)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 180, height: 180)
                .shadow(color: character.accentColor.opacity(0.4), radius: 20)

            // Character name
            Text(character.name)
                .font(MQTheme.title(24))
                .foregroundStyle(character.accentColor)

            // Tagline
            Text(character.tagline)
                .font(MQTheme.caption())
                .foregroundStyle(MQTheme.textSecondary)

            // Greeting
            Text("\"\(character.greeting)\"")
                .font(MQTheme.body())
                .foregroundStyle(MQTheme.textPrimary.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, MQTheme.paddingLarge)
                .italic()

            // Specialty icons
            HStack(spacing: 12) {
                ForEach(character.specialties) { specialty in
                    VStack(spacing: 4) {
                        Image(systemName: specialty.icon)
                            .font(.system(size: 20))
                            .foregroundStyle(character.accentColor)
                        Text(specialty.displayName)
                            .font(MQTheme.caption(11))
                            .foregroundStyle(MQTheme.textSecondary)
                    }
                }
            }

            Spacer()

            // Action buttons
            VStack(spacing: 12) {
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
            .padding(.bottom, MQTheme.paddingLarge)
        }
    }
}

#Preview {
    ZStack {
        MQTheme.seleneAmbiance.ignoresSafeArea()
        CharacterCardView(character: FortuneTeller.all[0])
    }
    .preferredColorScheme(.dark)
}
