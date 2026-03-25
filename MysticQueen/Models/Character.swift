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
    let avatarName: String
    let roomName: String

    static let all: [FortuneTeller] = [
        FortuneTeller(
            id: "selene",
            name: "Selene",
            tagline: "Bohem ruhlu tarotçu",
            bio: "Rüzgar nereye eserse oraya giden, kartları hayatın ritmiyle okuyan genç bir gezgin. Sana arkadaş gibi yaklaşır, içini döker gibi anlatır.",
            greeting: "Hoş geldin kızım, kartlar seni çoktan hissetti...",
            specialties: [.tarot, .lenormand],
            ambianceColor: MQTheme.seleneAmbiance,
            accentColor: Color(hex: 0xE8A0BF),
            avatarName: "selene_avatar",
            roomName: "selene_room"
        ),
        FortuneTeller(
            id: "ruhi_dede",
            name: "Ruhi Dede",
            tagline: "Bilge kahve ustası",
            bio: "Yılların bilgesini taşıyan, her fincanda bir hikaye okuyan yaşamış adam. Atasözleriyle konuşur, ağır ama derin anlatır.",
            greeting: "Hoş geldin evladım... Fincanı çevir bakalım, ne çıkmış...",
            specialties: [.coffeeReading, .katina],
            ambianceColor: MQTheme.ruhiDedeAmbiance,
            accentColor: Color(hex: 0xD4A574),
            avatarName: "ruhi_dede_avatar",
            roomName: "ruhi_dede_room"
        ),
        FortuneTeller(
            id: "lilith",
            name: "Lilith",
            tagline: "Karanlığın sesi",
            bio: "Gotik, gizemli ve acımadan doğruyu söyler. Tatlı yapmaz, diplomatik değil. Kartlar ne diyorsa onu söyler.",
            greeting: "Otursana. Kartlar zaten konuşmaya başladı.",
            specialties: [.tarot, .playingCards],
            ambianceColor: MQTheme.lilithAmbiance,
            accentColor: Color(hex: 0x9B6DFF),
            avatarName: "lilith_avatar",
            roomName: "lilith_room"
        ),
        FortuneTeller(
            id: "nazim",
            name: "Nâzım",
            tagline: "Şair ruhlu filozof",
            bio: "Hayata şiirle bakan, her falda bir hayat dersi çıkaran düşünür. Metaforlarla konuşur, sözleri akılda kalır.",
            greeting: "Merhaba yolcu... Kartların da senin gibi bir hikayesi var.",
            specialties: [.lenormand, .angelCards],
            ambianceColor: MQTheme.nazimAmbiance,
            accentColor: Color(hex: 0x7EC8B8),
            avatarName: "nazim_avatar",
            roomName: "nazim_room"
        ),
        FortuneTeller(
            id: "zumrut_ana",
            name: "Zümrüt Ana",
            tagline: "Şifacı Anadolu kadını",
            bio: "Sıcak, saran, iyileştiren bir anne figürü. Fincanına bakarken ruhunu da okur. Yavrum der, içini rahatlatır.",
            greeting: "Hoş geldin yavrum, kahveni iç de bakalım fincanın ne söylüyor...",
            specialties: [.coffeeReading, .angelCards],
            ambianceColor: MQTheme.zumrutAnaAmbiance,
            accentColor: Color(hex: 0xE8C170),
            avatarName: "zumrut_ana_avatar",
            roomName: "zumrut_ana_room"
        ),
        FortuneTeller(
            id: "cassian",
            name: "Cassian",
            tagline: "Gen-Z falcı",
            bio: "Genç, modern, biraz ukala ama isabetli. Eğlenceli bir dille konuşur, ama söyledikleri şaşırtıcı derecede doğru çıkar.",
            greeting: "Nbr, hoş geldin. Hadi bakalım ne var ne yok",
            specialties: [.playingCards, .katina],
            ambianceColor: MQTheme.cassianAmbiance,
            accentColor: Color(hex: 0x64B5F6),
            avatarName: "cassian_avatar",
            roomName: "cassian_room"
        )
    ]
}
