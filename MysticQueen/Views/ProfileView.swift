import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userBirthDate") private var userBirthDate: Double = Date().timeIntervalSince1970
    @AppStorage("coffeeBalance") private var coffeeBalance: Int = 0

    private var birthDate: Date {
        Date(timeIntervalSince1970: userBirthDate)
    }

    private var zodiac: ZodiacSign {
        UserProfile.zodiac(from: birthDate)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                MQTheme.backgroundDark.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: MQTheme.paddingLarge) {
                        // Profile header
                        profileHeader

                        // Coffee balance card
                        coffeeCard

                        // Past readings placeholder
                        pastReadingsSection

                        // Settings
                        settingsSection
                    }
                    .padding(MQTheme.paddingMedium)
                }
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Profilim")
                        .font(MQTheme.pixelTitle(12))
                        .foregroundStyle(MQTheme.gold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(MQTheme.textMuted)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 12) {
            Text(zodiac.emoji)
                .font(.system(size: 48))

            Text(userName)
                .font(MQTheme.pixelBody(16))
                .foregroundStyle(MQTheme.textPrimary)

            HStack(spacing: 4) {
                Text(zodiac.displayName)
                    .font(MQTheme.pixelBody(12))
                    .foregroundStyle(MQTheme.gold)

                Text("•")
                    .foregroundStyle(MQTheme.textMuted)

                Text(birthDate, format: .dateTime.day().month(.wide).year())
                    .font(MQTheme.body(13))
                    .foregroundStyle(MQTheme.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(MQTheme.paddingLarge)
        .background(MQTheme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
    }

    private var coffeeCard: some View {
        VStack(spacing: 12) {
            HStack {
                Text("☕ Kahve Bakiyen")
                    .font(MQTheme.pixelBody(12))
                    .foregroundStyle(MQTheme.textSecondary)

                Spacer()

                Text("\(coffeeBalance)")
                    .font(MQTheme.pixelTitle(18))
                    .foregroundStyle(MQTheme.coffee)
            }

            Divider()
                .overlay(MQTheme.textMuted.opacity(0.3))

            Button {
                // TODO: Open coffee shop
            } label: {
                Text("Kahve Satin Al")
                    .font(MQTheme.pixelBody(12))
                    .foregroundStyle(MQTheme.backgroundDark)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(MQTheme.coffee)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(MQTheme.paddingMedium)
        .background(MQTheme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
    }

    private var pastReadingsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Gecmis Fallar")
                .font(MQTheme.pixelBody(12))
                .foregroundStyle(MQTheme.textSecondary)

            Text("Henuz fal baktirmadiniz")
                .font(MQTheme.body(14))
                .foregroundStyle(MQTheme.textMuted)
                .frame(maxWidth: .infinity, minHeight: 60)
        }
        .padding(MQTheme.paddingMedium)
        .background(MQTheme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
    }

    private var settingsSection: some View {
        VStack(spacing: 1) {
            settingsRow(icon: "person.fill", title: "Profil Duzenle")
            settingsRow(icon: "bell.fill", title: "Bildirimler")
            settingsRow(icon: "lock.shield.fill", title: "Gizlilik Politikasi")
            settingsRow(icon: "doc.text.fill", title: "Kullanim Kosullari")
        }
        .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
    }

    private func settingsRow(icon: String, title: String) -> some View {
        Button {
            // TODO: Navigation
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(MQTheme.gold)
                    .frame(width: 24)

                Text(title)
                    .font(MQTheme.body(15))
                    .foregroundStyle(MQTheme.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundStyle(MQTheme.textMuted)
            }
            .padding(MQTheme.paddingMedium)
            .background(MQTheme.backgroundCard)
        }
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
