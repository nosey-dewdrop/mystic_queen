import Foundation
import StoreKit

@MainActor
class CreditManager: ObservableObject {
    static let shared = CreditManager()

    @Published var coffeeBalance: Int {
        didSet {
            UserDefaults.standard.set(coffeeBalance, forKey: balanceKey)
        }
    }
    @Published var products: [Product] = []
    @Published var purchaseInProgress = false
    @Published var purchaseError: String?
    @Published var adsWatchedTowardCoffee: Int {
        didSet {
            UserDefaults.standard.set(adsWatchedTowardCoffee, forKey: adsWatchedKey)
        }
    }

    private let balanceKey = "com.damla.mysticqueen.coffeeBalance"
    private let welcomeKey = "com.damla.mysticqueen.welcomeBonusGiven"
    private let adsWatchedKey = "com.damla.mysticqueen.adsWatched"
    private let adsPerCoffee = 15

    private let productIds = [
        "com.damla.mysticqueen.coffee5",
        "com.damla.mysticqueen.coffee15",
        "com.damla.mysticqueen.coffee30",
        "com.damla.mysticqueen.coffee50",
    ]

    private var transactionTask: Task<Void, Never>?

    private init() {
        self.coffeeBalance = UserDefaults.standard.integer(forKey: balanceKey)
        self.adsWatchedTowardCoffee = UserDefaults.standard.integer(forKey: adsWatchedKey)
        listenForTransactions()
    }

    deinit {
        transactionTask?.cancel()
    }

    // MARK: - Welcome Bonus

    func giveWelcomeBonusIfNeeded() {
        guard !UserDefaults.standard.bool(forKey: welcomeKey) else { return }
        UserDefaults.standard.set(true, forKey: welcomeKey)
        coffeeBalance += 3
    }

    // MARK: - Credit Operations

    var hasCoffee: Bool {
        coffeeBalance > 0
    }

    func useCoffee() -> Bool {
        guard coffeeBalance > 0 else { return false }
        coffeeBalance -= 1
        return true
    }

    func useCoffees(_ amount: Int) -> Bool {
        guard coffeeBalance >= amount else { return false }
        coffeeBalance -= amount
        return true
    }

    func refundCoffee() {
        coffeeBalance += 1
    }

    func addCoffees(_ amount: Int) {
        coffeeBalance += amount
    }

    // MARK: - Rewarded Ads (15 ads = 1 coffee)

    func recordAdWatched() {
        adsWatchedTowardCoffee += 1
        if adsWatchedTowardCoffee >= adsPerCoffee {
            adsWatchedTowardCoffee = 0
            coffeeBalance += 1
        }
    }

    var adsRemainingForCoffee: Int {
        adsPerCoffee - adsWatchedTowardCoffee
    }

    // MARK: - Referral

    func applyReferralBonus() {
        coffeeBalance += 1
    }

    // MARK: - Transaction Listener

    private func listenForTransactions() {
        transactionTask = Task.detached { [weak self] in
            for await result in Transaction.updates {
                if let transaction = try? await self?.checkVerified(result) {
                    await self?.addCreditsForProduct(transaction.productID)
                    await transaction.finish()
                }
            }
        }
    }

    // MARK: - StoreKit 2

    func loadProducts() async {
        do {
            products = try await Product.products(for: productIds)
                .sorted { $0.price < $1.price }
        } catch {
            // Products will remain empty, UI shows fallback
        }
    }

    func purchase(_ product: Product) async {
        purchaseInProgress = true
        purchaseError = nil
        defer { purchaseInProgress = false }

        do {
            let result = try await product.purchase()

            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                addCreditsForProduct(product.id)
                await transaction.finish()

            case .userCancelled:
                break

            case .pending:
                purchaseError = "Satin alma beklemede. Apple ID odeme ayarlarini kontrol et."

            @unknown default:
                break
            }
        } catch {
            purchaseError = "Satin alma basarisiz. Tekrar dene."
        }
    }

    func restorePurchases() async {
        var processedIds = Set<UInt64>()
        let finishedKey = "com.damla.mysticqueen.finishedTransactions"
        let alreadyFinished = Set(UserDefaults.standard.array(forKey: finishedKey) as? [UInt64] ?? [])

        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                if !alreadyFinished.contains(transaction.id) && !processedIds.contains(transaction.id) {
                    addCreditsForProduct(transaction.productID)
                    processedIds.insert(transaction.id)
                }
                await transaction.finish()
            }
        }

        let allFinished = alreadyFinished.union(processedIds)
        UserDefaults.standard.set(Array(allFinished), forKey: finishedKey)
    }

    // MARK: - Helpers

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.verificationFailed
        case .verified(let safe):
            return safe
        }
    }

    private func addCreditsForProduct(_ productId: String) {
        let amount = Self.coffeesForProduct(productId)
        if amount > 0 {
            coffeeBalance += amount
        }
    }

    static func coffeesForProduct(_ productId: String) -> Int {
        switch productId {
        case "com.damla.mysticqueen.coffee5": return 5
        case "com.damla.mysticqueen.coffee15": return 15
        case "com.damla.mysticqueen.coffee30": return 30
        case "com.damla.mysticqueen.coffee50": return 50
        default: return 0
        }
    }

    // MARK: - Fallback Products

    struct CoffeePackage: Identifiable {
        let id: String
        let coffees: Int
        let price: String
    }

    static let fallbackPackages = [
        CoffeePackage(id: "coffee5", coffees: 5, price: "₺79,99"),
        CoffeePackage(id: "coffee15", coffees: 15, price: "₺199,99"),
        CoffeePackage(id: "coffee30", coffees: 30, price: "₺349,99"),
        CoffeePackage(id: "coffee50", coffees: 50, price: "₺499,99"),
    ]
}

enum StoreError: LocalizedError {
    case verificationFailed

    var errorDescription: String? {
        "Satin alma dogrulamasi basarisiz"
    }
}
