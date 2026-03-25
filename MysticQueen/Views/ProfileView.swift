import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userBirthDate") private var userBirthDate: Double = Date().timeIntervalSince1970
    @ObservedObject private var creditManager = CreditManager.shared
    @State private var showCoffeeShop = false

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
                        profileHeader
                        coffeeCard
                        pastReadingsSection
                    }
                    .padding(MQTheme.paddingMedium)
                }
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Profilim")
                        .font(MQTheme.title())
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
            .sheet(isPresented: $showCoffeeShop) {
                CoffeeShopView()
            }
        }
    }

    private var profileHeader: some View {
        VStack(spacing: 12) {
            Text(zodiac.emoji)
                .font(.system(size: 48))

            Text(userName)
                .font(MQTheme.heading(18))
                .foregroundStyle(MQTheme.textPrimary)

            HStack(spacing: 4) {
                Text(zodiac.displayName)
                    .font(MQTheme.caption())
                    .foregroundStyle(MQTheme.gold)

                Text("•")
                    .foregroundStyle(MQTheme.textMuted)

                Text(birthDate, format: .dateTime.day().month(.wide).year())
                    .font(MQTheme.caption())
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
                    .font(MQTheme.caption())
                    .foregroundStyle(MQTheme.textSecondary)

                Spacer()

                Text("\(creditManager.coffeeBalance)")
                    .font(MQTheme.title(28))
                    .foregroundStyle(MQTheme.coffee)
            }

            Divider()
                .overlay(MQTheme.textMuted.opacity(0.3))

            Button {
                showCoffeeShop = true
            } label: {
                Text("Kahve Satın Al")
                    .font(MQTheme.button())
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
            Text("Geçmiş Fallar")
                .font(MQTheme.heading())
                .foregroundStyle(MQTheme.textSecondary)

            VStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 32))
                    .foregroundStyle(MQTheme.textMuted)
                Text("Henüz fal baktırmadınız")
                    .font(MQTheme.body())
                    .foregroundStyle(MQTheme.textMuted)
                Text("İlk falınızı baktırmak için bir falcı seçin")
                    .font(MQTheme.caption())
                    .foregroundStyle(MQTheme.textMuted.opacity(0.7))
            }
            .frame(maxWidth: .infinity, minHeight: 80)
        }
        .padding(MQTheme.paddingMedium)
        .background(MQTheme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}
