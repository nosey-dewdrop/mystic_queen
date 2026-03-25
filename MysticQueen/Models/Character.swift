import SwiftUI

struct FortuneTeller: Identifiable {
    let id: String
    let name: String
    let tagline: String
    let bio: String
    let greeting: String
    let specialties: [FortuneType]
    let ambianceColor: Color
    let accentColor: Color
    let avatarName: String // asset catalog name

    static let all: [FortuneTeller] = [
        FortuneTeller(
            id: "selene",
            name: "Selene",
            tagline: "Bohem ruhlu tarotcu",
            bio: "Ruzgar nereye eserse oraya giden, kartlari hayatin ritmiyle okuyan genc bir gezgin. Sana arkadas gibi yaklasir, icini doker gibi anlatirir.",
            greeting: "Hosgeldin kizim, kartlar seni coktan hissetti...",
            specialties: [.tarot, .lenormand],
            ambianceColor: MQTheme.seleneAmbiance,
            accentColor: Color(hex: 0xE8A0BF),
            avatarName: "selene_avatar"
        ),
        FortuneTeller(
            id: "ruhi_dede",
            name: "Ruhi Dede",
            tagline: "Bilge kahve ustasi",
            bio: "Yillarin bilgesini tasiyan, her fincanda bir hikaye okuyan yasamis adam. Atasozleriyle konusur, agir ama derin anlatirir.",
            greeting: "Hos geldin evladim... Fincani cevir bakalim, ne cikmis...",
            specialties: [.coffeeReading, .katina],
            ambianceColor: MQTheme.ruhiDedeAmbiance,
            accentColor: Color(hex: 0xD4A574),
            avatarName: "ruhi_dede_avatar"
        ),
        FortuneTeller(
            id: "lilith",
            name: "Lilith",
            tagline: "Karanligin sesi",
            bio: "Gotik, gizemli ve acimadan dogruyu soyler. Tatli yapmaz, diplomatik degil. Kartlar ne diyorsa onu soyler.",
            greeting: "Otursana. Kartlar zaten konusmaya basladi.",
            specialties: [.tarot, .playingCards],
            ambianceColor: MQTheme.lilithAmbiance,
            accentColor: Color(hex: 0x9B6DFF),
            avatarName: "lilith_avatar"
        ),
        FortuneTeller(
            id: "nazim",
            name: "Nazim",
            tagline: "Sair ruhlu filozof",
            bio: "Hayata siirle bakan, her falda bir hayat dersi cikaran dusunur. Metaforlarla konusur, sozleri akilda kalir.",
            greeting: "Merhaba yolcu... Kartlarin da senin gibi bir hikayesi var.",
            specialties: [.lenormand, .angelCards],
            ambianceColor: MQTheme.nazimAmbiance,
            accentColor: Color(hex: 0x7EC8B8),
            avatarName: "nazim_avatar"
        ),
        FortuneTeller(
            id: "zumrut_ana",
            name: "Zumrut Ana",
            tagline: "Sifaci anadolu kadini",
            bio: "Sicak, saran, iyilestiren bir anne figuru. Fincanina bakarken ruhunu da okur. Yavrum der, icini rahatlatir.",
            greeting: "Hos geldin yavrum, kahveni ic de bakalim fincanin ne soyluyor...",
            specialties: [.coffeeReading, .angelCards],
            ambianceColor: MQTheme.zumrutAnaAmbiance,
            accentColor: Color(hex: 0xE8C170),
            avatarName: "zumrut_ana_avatar"
        ),
        FortuneTeller(
            id: "cassian",
            name: "Cassian",
            tagline: "Gen-Z falci",
            bio: "Genc, modern, biraz ukala ama isabetli. Eglenceli bir dille konusur, ama soyledikleri sasirtici derecede dogru cikar.",
            greeting: "Nbr, hosgeldin. Hadi bakalim ne var ne yok",
            specialties: [.playingCards, .katina],
            ambianceColor: MQTheme.cassianAmbiance,
            accentColor: Color(hex: 0x64B5F6),
            avatarName: "cassian_avatar"
        )
    ]
}
