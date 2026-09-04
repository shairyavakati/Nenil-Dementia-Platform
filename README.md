<div align="center">

<h1>Nenil</h1>

<p><em>Offline-first multilingual cognitive gaming and memory assistance platform for elderly dementia patients in India's North East Region.</em></p>

<br/>

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Offline First](https://img.shields.io/badge/Offline-First-FF6B35?style=for-the-badge&logo=databricks&logoColor=white)
![Android](https://img.shields.io/badge/Android-Platform-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![SIH 2026](https://img.shields.io/badge/SIH-2026-0F62FE?style=for-the-badge&logo=gov.uk&logoColor=white)

<br/>

</div>

Nenil is a culturally rooted mobile application designed to support elderly people living with dementia through stage-based cognitive games, caregiver personalization, familiar routines, voice guidance, and emergency care features. It is built for India's North East Region — a linguistically diverse, geographically remote area with limited access to specialist dementia care.

**Nenil is not a medical diagnosis tool.** It is a cognitive support and wellbeing platform — purpose-built to reduce cognitive decline through meaningful, familiar, and joyful daily engagement.

---

## The Problem

India's North East Region faces a disproportionate gap in dementia care access.

- **Rising prevalence** — Dementia cases across Assam, Meghalaya, Nagaland, Manipur, and neighbouring states are increasing, with aging populations and limited formal tracking systems.
- **No specialist access** — Neurologists and geriatricians are concentrated in metro areas. Rural and semi-urban NER communities often have no reachable specialist within 100 km.
- **Language diversity** — The NER is home to over 200 distinct languages and dialects. Existing tools are English-only or Hindi-only, making them unusable for most of the target population.
- **No localized support tools** — There is no clinically informed, culturally familiar, multilingual cognitive support application built for this population.

Families and caregivers are left to manage a progressive, demanding condition with no structured digital support.

---

## The Solution

Nenil bridges the gap between clinical best practices and the lived reality of NER families.

The platform delivers structured cognitive engagement through familiar, culturally resonant activities — tailored to the patient's stage of dementia, preferred language, and personal history. Every interaction is designed around the patient's comfort and dignity, never their deficits.

Key pillars of the solution:

- **Offline-first** — Full gameplay and routine support without an internet connection. Synchronization happens in the background when connectivity is restored.
- **Multilingual** — Supports regional NER languages alongside Assamese, Hindi, and English, with caregiver-recorded audio for deeply personal guidance.
- **Stage-based** — Content and interaction complexity adapt to early, mid, and late-stage dementia, ensuring appropriateness and reducing frustration.
- **Caregiver-powered** — Family members and caregivers are active participants. They configure routines, record voices, link accounts, and monitor progress.
- **Culturally rooted** — Games, music, and imagery draw from familiar NER cultural contexts — not generic Western dementia toolkits.

---

## Key Features

### Cognitive Gaming

| Game | Description |
|---|---|
| **My Daily Routine** | Guides patients through familiar morning-to-evening routines using audio and imagery |
| **Find My Things** | Object-location memory exercises using personally meaningful household items |
| **Family Faces & Stories** | Photo-based recognition games using the patient's own family photos and recorded captions |
| **Music Memory Journey** | Familiar regional and personal music prompts emotional memory and engagement |
| **Emotion Match** | Gentle emotion recognition exercises using illustrated familiar faces |

### Personalization

- Stage-appropriate experience mapping (Early / Mid / Late)
- Language and dialect selection at onboarding
- Caregiver-recorded voice instructions for each game module
- Daily routine customization by time of day and activity type
- Personalized activity feed based on engagement history

### Caregiver Features

- Secure patient–caregiver account linking
- Permission-based access control with PIN protection
- Caregiver dashboard with session overview and trends
- Full session history with engagement metrics
- Caregiver insights and guidance notes

### Safety Features

- Emergency support with one-tap SOS
- Direct calling to registered caregivers
- Voice-activated emergency calling
- Real-time location sharing with linked caregivers
- Secure caregiver controls with audit trail

### Accessibility

- Large, high-contrast touch targets throughout
- High contrast, glare-reduced UI optimized for aging vision
- Audio-first guidance — every action has a spoken instruction
- Full offline gameplay — no dependency on connectivity during use
- PIN-protected caregiver mode to prevent accidental reconfiguration

---

## MVP Scope

The initial production build for SIH 2026 focuses on delivering a complete, stable, and demonstrable experience:

- **Five core game modules** — My Daily Routine, Find My Things, Family Faces & Stories, Music Memory Journey, and Emotion Match
- **Caregiver onboarding** — Account creation, patient linking, profile configuration, and voice recording
- **Multilingual support** — Language selection with regional language content packs
- **Offline functionality** — All gameplay fully functional without internet access
- **Secure synchronization** — Background sync to Supabase when connectivity is available

> [!NOTE]
> The MVP is scoped to demonstrate clinical viability and technical excellence. Subsequent phases will expand language coverage, game depth, and reporting.

---

## Technology Stack

| Layer | Technology |
|---|---|
| **Frontend** | Flutter (Dart) |
| **UI Framework** | Material Design 3 |
| **State Management** | Riverpod |
| **Navigation** | GoRouter |
| **Local Database** | SQLite |
| **Local Cache** | Hive |
| **Backend** | Supabase |
| **Cloud Database** | PostgreSQL |
| **Media Storage** | Supabase Storage |
| **Audio** | just\_audio + record |
| **Text-to-Speech** | Android Native TTS |
| **Animations** | Lottie |
| **UI/UX Design** | Figma |
| **Version Control** | Git & GitHub |

---

## Architecture

```
┌─────────────────────────────────────────┐
│              Flutter App                │
│         (Dart · Material 3)             │
└────────────────────┬────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────┐
│               Riverpod                  │
│      (State · Providers · DI)           │
└──────────┬──────────────────┬───────────┘
           │                  │
           ▼                  ▼
┌──────────────┐    ┌─────────────────────┐
│    SQLite    │◄──►│      Supabase        │
│ (Local Data) │    │ (PostgreSQL · Auth   │
│    + Hive    │    │  Storage · Realtime) │
│  (Cache)     │    └─────────────────────┘
└──────────────┘
           │
           ▼
┌─────────────────────────────────────────┐
│            Game Modules                 │
│  Routine · Objects · Faces · Music ·   │
│              Emotions                   │
└────────────────────┬────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────┐
│          Caregiver Dashboard            │
│    Session History · Insights · Config  │
└────────────────────┬────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────┐
│          Emergency Services             │
│     SOS · Direct Call · Location        │
└─────────────────────────────────────────┘
```

> [!IMPORTANT]
> All game modules operate fully offline via SQLite. Supabase sync occurs only when connectivity is available, never blocking user experience.

---

## Project Structure

```text
nenil/
├── lib/
│   ├── core/                  # App-wide constants, theme, routing config
│   ├── features/
│   │   ├── onboarding/        # Patient & caregiver registration flows
│   │   ├── caregiver/         # Dashboard, linking, session history
│   │   ├── home/              # Activity feed, routine overview
│   │   └── games/             # All five game modules
│   ├── services/              # Sync, TTS, audio, location, emergency
│   ├── storage/               # SQLite & Hive adapters
│   ├── models/                # Data models and serialization
│   └── shared/                # Reusable widgets, utilities, extensions
├── assets/
│   ├── images/                # Illustrated UI assets, activity imagery
│   ├── audio/                 # Default audio prompts and music packs
│   └── animations/            # Lottie animation files
└── supabase/
    ├── migrations/            # Database schema migrations
    └── functions/             # Edge functions for sync and notifications
```

---

## Development Roadmap

| Sprint | Focus | Status |
|---|---|---|
| **Sprint 1 — Foundation** | Project setup, navigation, design system, onboarding flows, local database schema | `Complete` |
| **Sprint 2 — Caregiver Setup** | Patient–caregiver linking, PIN auth, profile configuration, voice recording | `In Progress` |
| **Sprint 3 — Core Games** | All five game modules with offline support and stage-based content | `Planned` |
| **Sprint 4 — Safety Features** | Emergency SOS, caregiver calling, location sharing, caregiver controls | `Planned` |
| **Sprint 5 — Production Polish** | Multilingual content packs, Supabase sync, accessibility audit, performance tuning | `Planned` |

---

## Design Principles

Nenil's interface is governed by a strict set of design principles that prioritize dignity, calm, and clarity above all else.

1. **One task per screen** — No cognitive overload. Each screen has one clear purpose and one clear action.
2. **No timers** — Patients are never rushed. There are no countdown clocks or urgency cues.
3. **No failure screens** — Activities do not produce error states or correction prompts. Every response is accepted with encouragement.
4. **Calm interactions** — Gentle animations, soft transitions, and no sudden visual changes.
5. **Voice-first guidance** — Every screen can be fully navigated through audio instructions alone.
6. **Large touch targets** — All interactive elements meet or exceed 56dp minimum touch area.
7. **Offline-first** — The app is fully functional without connectivity. The network is never a blocker.

> [!TIP]
> These principles are enforced at the design review stage. Any new screen or feature must satisfy all seven before it enters development.

---

## Security & Privacy

Patient data, family media, and caregiver information are handled with clinical-grade care.

- **Encrypted local storage** — All SQLite and Hive data is encrypted at rest using device-level encryption
- **Permission-based caregiver access** — Caregivers can only access data and controls explicitly granted by the primary account holder
- **Secure authentication** — Supabase Auth with JWT session management and refresh token rotation
- **Protected family media** — Photos, audio recordings, and personal assets are stored in private Supabase Storage buckets with signed URL access
- **Privacy-first data handling** — No personally identifiable data is shared with third parties. Analytics are aggregate and anonymized.

> [!CAUTION]
> Patient profile data, family photos, and recorded audio are never stored in public cloud buckets. All media access is authenticated and session-scoped.

---

## Future Expansion

The following capabilities are planned beyond the SIH 2026 MVP, aligned with the product's long-term vision:

- **Additional NER languages** — Expanding the language pack library to cover more of the region's 200+ dialects, prioritized by community need
- **Expanded game modules** — New culturally grounded activities (traditional games, storytelling formats, regional craft-based exercises)
- **Clinical pilot programs** — Structured pilots with geriatric care facilities and community health workers in NER states
- **Improved caregiver reporting** — Longitudinal engagement analytics and caregiver-facing trend summaries to support informed care decisions

---

## Contributors

| Name | Role |
|---|---|
| — | — |

> We welcome contributors who are passionate about accessibility, regional language technology, and inclusive healthcare. See [CONTRIBUTING.md](./CONTRIBUTING.md) to get started.

---

<div align="center">

Built with care for the people of India's North East Region.

**Nenil** · Smart India Hackathon 2026

</div>
