# Roadmap

## Phase 1: Foundation
- [ ] xcode project setup (swiftui, xcodegen, bundle id, fonts)
- [ ] data models (character, fortune type, reading, user profile, slot, appointment)
- [ ] color palette and pixel art style constants
- [ ] basic app structure (no tab bar, carousel-based navigation)

## Phase 2: Characters & Carousel
- [ ] character data (6 characters with personalities, specialties, greetings)
- [ ] carousel view (full screen, swipe between characters)
- [ ] per-character ambiance (background color/mood shift on swipe)
- [ ] character greeting text (changes per character)
- [ ] character detail page (pixel art, bio, fortune types, two buttons)
- [ ] pixel art character avatars via pixellab

## Phase 3: Credit System
- [ ] coffee credit model and manager
- [ ] storekit 2 integration (4 credit packages)
- [ ] first registration bonus (3 coffees)
- [ ] refer a friend reward (1 coffee)
- [ ] rewarded ads integration via admob (15 ads = 1 coffee)
- [ ] credit badge always visible on screen

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
