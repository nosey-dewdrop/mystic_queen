import SwiftUI
import StoreKit

struct CoffeeShopView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var creditManager = CreditManager.shared

    var body: some View {
        NavigationStack {
            ZStack {
                MQTheme.backgroundDark.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: MQTheme.paddingLarge) {
                        // Current balance
                        balanceHeader

                        // Coffee packages
                        packagesSection

                        // Watch ads section
                        adsSection

                        // Refer a friend
                        referralSection

                        // Restore purchases
                        Button {
                            Task { await creditManager.restorePurchases() }
                        } label: {
                            Text("Satinalmalari Geri Yukle")
                                .font(MQTheme.caption())
                                .foregroundStyle(MQTheme.textMuted)
                        }
                        .padding(.top, 8)
                    }
                    .padding(MQTheme.paddingMedium)
                }
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Kahve Dukani")
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
            .task {
                await creditManager.loadProducts()
            }
            .alert("Hata", isPresented: .init(
                get: { creditManager.purchaseError != nil },
                set: { if !$0 { creditManager.purchaseError = nil } }
            )) {
                Button("Tamam", role: .cancel) {}
            } message: {
                Text(creditManager.purchaseError ?? "")
            }
        }
    }

    // MARK: - Balance Header

    private var balanceHeader: some View {
        VStack(spacing: 8) {
            Text("☕")
                .font(.system(size: 48))

            Text("\(creditManager.coffeeBalance)")
                .font(MQTheme.title(36))
                .foregroundStyle(MQTheme.coffee)

            Text("kahven var")
                .font(MQTheme.body())
                .foregroundStyle(MQTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(MQTheme.paddingLarge)
        .background(MQTheme.backgroundCard)
        .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
    }

    // MARK: - Packages

    private var packagesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Kahve Paketleri")
                .font(MQTheme.heading())
                .foregroundStyle(MQTheme.textPrimary)

            if creditManager.products.isEmpty {
                // Fallback UI
                ForEach(CreditManager.fallbackPackages) { pkg in
                    packageRow(coffees: pkg.coffees, price: pkg.price, action: {})
                }
            } else {
                ForEach(creditManager.products) { product in
                    let coffees = CreditManager.coffeesForProduct(product.id)
                    packageRow(
                        coffees: coffees,
                        price: product.displayPrice,
                        action: {
                            Task { await creditManager.purchase(product) }
                        }
                    )
                }
            }
        }
    }

    private func packageRow(coffees: Int, price: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                HStack(spacing: 4) {
                    Text("☕")
                        .font(.system(size: 20))
                    Text("\(coffees) Kahve")
                        .font(MQTheme.heading())
                        .foregroundStyle(MQTheme.textPrimary)
                }

                Spacer()

                Text(price)
                    .font(MQTheme.button())
                    .foregroundStyle(MQTheme.backgroundDark)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(MQTheme.gold)
                    .clipShape(Capsule())
            }
            .padding(MQTheme.paddingMedium)
            .background(MQTheme.backgroundCard)
            .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
        }
        .disabled(creditManager.purchaseInProgress)
        .opacity(creditManager.purchaseInProgress ? 0.6 : 1)
    }

    // MARK: - Ads

    private var adsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Reklam Izle")
                .font(MQTheme.heading())
                .foregroundStyle(MQTheme.textPrimary)

            VStack(spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("15 reklam izle = 1 ☕")
                            .font(MQTheme.body())
                            .foregroundStyle(MQTheme.textPrimary)

                        Text("\(creditManager.adsRemainingForCoffee) reklam kaldi")
                            .font(MQTheme.caption())
                            .foregroundStyle(MQTheme.textSecondary)
                    }

                    Spacer()

                    Button {
                        // TODO: Show rewarded ad via AdMob
                        creditManager.recordAdWatched()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "play.circle.fill")
                            Text("Izle")
                                .font(MQTheme.button())
                        }
                        .foregroundStyle(MQTheme.backgroundDark)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(MQTheme.coffee)
                        .clipShape(Capsule())
                    }
                }

                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(MQTheme.backgroundElevated)
                            .frame(height: 8)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(MQTheme.coffee)
                            .frame(
                                width: geo.size.width * CGFloat(creditManager.adsWatchedTowardCoffee) / 15.0,
                                height: 8
                            )
                            .animation(.easeInOut, value: creditManager.adsWatchedTowardCoffee)
                    }
                }
                .frame(height: 8)
            }
            .padding(MQTheme.paddingMedium)
            .background(MQTheme.backgroundCard)
            .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
        }
    }

    // MARK: - Referral

    private var referralSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Arkadasina Oner")
                .font(MQTheme.heading())
                .foregroundStyle(MQTheme.textPrimary)

            Button {
                shareApp()
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("1 ☕ kazan")
                            .font(MQTheme.body())
                            .foregroundStyle(MQTheme.textPrimary)
                        Text("Arkadasin indirince ikimize de kahve")
                            .font(MQTheme.caption())
                            .foregroundStyle(MQTheme.textSecondary)
                    }

                    Spacer()

                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 20))
                        .foregroundStyle(MQTheme.gold)
                }
                .padding(MQTheme.paddingMedium)
                .background(MQTheme.backgroundCard)
                .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
            }
        }
    }

    private func shareApp() {
        let text = "Mystic Queen'de fal baktir! Gercek falcilar, gercek sohbetler ☕"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let root = scene.windows.first?.rootViewController {
            root.present(activityVC, animated: true)
        }
    }
}

#Preview {
    CoffeeShopView()
        .preferredColorScheme(.dark)
}
