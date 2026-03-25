# Roadmap

## Phase 1: Foundation
- [x] xcode project setup (swiftui, xcodegen, bundle id, fonts)
- [x] data models (character, fortune type, reading, user profile, slot, appointment)
- [x] color palette and pixel art style constants
- [x] basic app structure (no tab bar, carousel-based navigation)

## Phase 2: Characters & Carousel
- [x] character data (6 characters with personalities, specialties, greetings)
- [x] carousel view (full screen, swipe between characters)
- [x] per-character ambiance (room backgrounds + gradient overlay)
- [x] character greeting text (changes per character)
- [x] character detail page (pixel art, bio, fortune types, two buttons)
- [x] pixel art character avatars via pixellab
- [x] pixel art room backgrounds via pixellab (6 unique rooms)

## Phase 3: Credit System
- [x] coffee credit model and manager
- [x] storekit 2 integration (4 credit packages)
- [x] first registration bonus (3 coffees)
- [x] refer a friend reward (1 coffee)
- [x] rewarded ads tracking (15 ads = 1 coffee, admob integration pending)
- [x] credit badge always visible on screen
- [x] coffee shop view (packages, ads progress, referral, restore purchases)

## Phase 4: Fal Baktir (Quick Reading)
- [ ] fortune type selection (character's specialties)
- [ ] question input or "general reading" option
- [ ] card/fortune animation per type (tarot flip, coffee cup, etc)
- [ ] claude sonnet integration with character personality prompts
- [ ] reading result as chat bubble in character's voice
- [ ] reading history saved to firestore

## Phase 5: Randevu (Appointment System)
- [ ] slot system (30min slots, 10:00-02:00, 32 slots per character per day)
- [ ] daily seed for fake occupancy (consistent within day, varies between days)
- [ ] date and time picker with slot availability
- [ ] 149 tl payment via in-app purchase
- [ ] appointment confirmation and storage in firestore
- [ ] push notification 5min before appointment
- [ ] 15min chat session with claude sonnet (character personality)
- [ ] organic session ending (~13min character wraps up)
- [ ] extend button after session ends (+10min for 1 coffee, one time only)
- [ ] chat history saved to firestore

## Phase 6: User Memory & Personalization
- [ ] user profile (name, birth date, auto zodiac)
- [ ] onboarding flow (name → birth date → 3 coffee bonus → carousel)
- [ ] character remembers past readings and conversations
- [ ] context from previous sessions sent to claude for continuity
- [ ] profile page (past readings, birth info, settings, credit balance)

## Phase 7: Backend
- [ ] fastapi backend setup
- [ ] firebase auth integration
- [ ] firestore schema (users, readings, appointments, credits)
- [ ] claude api proxy (protect api key)
- [ ] rate limiting
- [ ] deploy to railway or render

## Phase 8: Polish & App Store
- [ ] app icon 1024x1024
- [ ] launch screen (dark, no white flash)
- [ ] privacyinfo.xcprivacy
- [ ] privacy policy and terms of service
- [ ] app store screenshots and metadata
- [ ] remove all debug/print statements
- [ ] final audit and edge case testing
