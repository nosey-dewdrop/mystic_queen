import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @ObservedObject private var creditManager = CreditManager.shared
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("userBirthDate") private var userBirthDate: Double = Date().timeIntervalSince1970

    @State private var step: OnboardingStep = .name
    @State private var nameInput: String = ""
    @State private var birthDateInput: Date = Calendar.current.date(
        from: DateComponents(year: 2000, month: 1, day: 1)
    ) ?? Date()
    @State private var computedZodiac: ZodiacSign = .capricorn
    @State private var showBonusAnimation = false

    enum OnboardingStep {
        case name
        case birthDate
        case bonus
    }

    private var stepIndex: Int {
        switch step {
        case .name: return 0
        case .birthDate: return 1
        case .bonus: return 2
        }
    }

    var body: some View {
        ZStack {
            MQTheme.backgroundDark.ignoresSafeArea()
            StarsBackgroundView()

            VStack(spacing: MQTheme.paddingLarge) {
                // Step indicator
                HStack(spacing: 8) {
                    ForEach(0..<3) { i in
                        Circle()
                            .fill(stepIndex >= i ? MQTheme.gold : MQTheme.textMuted.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .animation(.easeInOut, value: stepIndex)
                    }
                }
                .padding(.top, 20)

                Spacer()

                switch step {
                case .name:
                    nameStep
                case .birthDate:
                    birthDateStep
                case .bonus:
                    bonusStep
                }

                Spacer()
            }
            .padding(.horizontal, MQTheme.paddingLarge)
        }
    }

    // MARK: - Name Step
    private var trimmedName: String {
        nameInput.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var nameStep: some View {
        let isNameEmpty = trimmedName.isEmpty
        return VStack(spacing: MQTheme.paddingLarge) {
            Text("Kozmik yolculuğun başlıyor...")
                .font(MQTheme.pixelLogo(10))
                .foregroundStyle(MQTheme.gold)
                .multilineTextAlignment(.center)

            Text("Adın ne?")
                .font(MQTheme.title())
                .foregroundStyle(MQTheme.textPrimary)

            TextField("", text: $nameInput, prompt: Text("Adını yaz...").foregroundStyle(MQTheme.textMuted))
                .font(MQTheme.body(18))
                .foregroundStyle(MQTheme.textPrimary)
                .multilineTextAlignment(.center)
                .padding()
                .background(MQTheme.backgroundCard)
                .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
                .autocorrectionDisabled()

            Button {
                guard !isNameEmpty else { return }
                userName = trimmedName
                withAnimation(.easeInOut) {
                    step = .birthDate
                }
            } label: {
                Text("Devam")
                    .font(MQTheme.button())
                    .foregroundStyle(MQTheme.backgroundDark)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(isNameEmpty ? MQTheme.goldDim : MQTheme.gold)
                    .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
            }
            .disabled(isNameEmpty)
        }
    }

    // MARK: - Birth Date Step
    private var birthDateStep: some View {
        VStack(spacing: MQTheme.paddingLarge) {
            // Back button
            HStack {
                Button {
                    withAnimation(.easeInOut) {
                        step = .name
                    }
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Geri")
                    }
                    .font(MQTheme.body())
                    .foregroundStyle(MQTheme.textSecondary)
                }
                Spacer()
            }

            Text("Doğum tarihin?")
                .font(MQTheme.title())
                .foregroundStyle(MQTheme.textPrimary)

            Text("Burcunu otomatik hesaplayalım")
                .font(MQTheme.body(14))
                .foregroundStyle(MQTheme.textSecondary)

            DatePicker(
                "",
                selection: $birthDateInput,
                in: ...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .colorScheme(.dark)
            .onChange(of: birthDateInput) { _, newValue in
                computedZodiac = UserProfile.zodiac(from: newValue)
            }

            HStack(spacing: 8) {
                Text(computedZodiac.emoji)
                    .font(.system(size: 28))
                Text(computedZodiac.displayName)
                    .font(MQTheme.heading())
                    .foregroundStyle(MQTheme.gold)
            }
            .padding()
            .background(MQTheme.backgroundCard)
            .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))

            Button {
                userBirthDate = birthDateInput.timeIntervalSince1970
                withAnimation(.easeInOut) {
                    step = .bonus
                }
                Task {
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    creditManager.giveWelcomeBonusIfNeeded()
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                        showBonusAnimation = true
                    }
                }
            } label: {
                Text("Devam")
                    .font(MQTheme.button())
                    .foregroundStyle(MQTheme.backgroundDark)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(MQTheme.gold)
                    .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
            }
        }
    }

    // MARK: - Bonus Step
    private var bonusStep: some View {
        VStack(spacing: MQTheme.paddingLarge) {
            Text("☕☕☕")
                .font(.system(size: 48))
                .scaleEffect(showBonusAnimation ? 1.2 : 0.5)
                .opacity(showBonusAnimation ? 1 : 0)

            Text("3 kahve hediye!")
                .font(MQTheme.title())
                .foregroundStyle(MQTheme.gold)
                .opacity(showBonusAnimation ? 1 : 0)

            Text("İlk falını baktırmak için hazırsın, \(userName)")
                .font(MQTheme.body(16))
                .foregroundStyle(MQTheme.textPrimary)
                .multilineTextAlignment(.center)
                .opacity(showBonusAnimation ? 1 : 0)

            if showBonusAnimation {
                Button {
                    hasCompletedOnboarding = true
                } label: {
                    Text("Falcıları Gör")
                        .font(MQTheme.button())
                        .foregroundStyle(MQTheme.backgroundDark)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(MQTheme.gold)
                        .clipShape(RoundedRectangle(cornerRadius: MQTheme.cornerRadius))
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

#Preview {
    OnboardingView()
        .preferredColorScheme(.dark)
}
