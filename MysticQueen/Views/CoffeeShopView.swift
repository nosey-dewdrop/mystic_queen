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
                        balanceHeader
                        packagesSection

                        Button {
                            Task { await creditManager.restorePurchases() }
                        } label: {
                            Text("Satın Almaları Geri Yükle")
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
                    Text("Kahve Dükkanı")
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

    private var packagesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Kahve Paketleri")
                .font(MQTheme.heading())
                .foregroundStyle(MQTheme.textPrimary)

            if creditManager.products.isEmpty {
                ForEach(CreditManager.fallbackPackages) { pkg in
                    packageRow(coffees: pkg.coffees, price: pkg.price, action: {
                        creditManager.purchaseError = "Mağazaya bağlanılamadı. İnternet bağlantını kontrol edip tekrar dene."
                    })
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
}

#Preview {
    CoffeeShopView()
        .preferredColorScheme(.dark)
}
