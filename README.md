<div align="center">

<h1>Nenil</h1>

<p><em>Offline-first multilingual cognitive gaming and memory assistance platform for elderly dementia patients in India's North East Region.</em></p>

<br/>

![Status](https://img.shields.io/badge/Status-Sprints%200--6%20Complete-brightgreen?style=for-the-badge&logo=github)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Database-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Offline First](https://img.shields.io/badge/Offline-First-FF6B35?style=for-the-badge&logo=databricks&logoColor=white)
![Android](https://img.shields.io/badge/Android-Platform-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![SIH 2026](https://img.shields.io/badge/SIH-2026-0F62FE?style=for-the-badge&logo=gov.uk&logoColor=white)

<br/>

</div>

Nenil is a culturally rooted mobile application designed to support elderly people living with dementia through stage-based cognitive games, caregiver personalization, familiar routines, voice guidance, and emergency care features. It is built for India's North East Region (NER) — a linguistically diverse, geographically remote area with limited access to specialist dementia care.

**Nenil is not a medical diagnosis tool.** It is a cognitive support and wellbeing platform — purpose-built to reduce cognitive decline through meaningful, familiar, and joyful daily engagement.

For detailed engineering standards, setup guides, and sprint execution rules, see the [DEVELOPMENT_WORKFLOW.md](./DEVELOPMENT_WORKFLOW.md).

---

## Product Vision

Nenil is built as a **cognitive gaming platform** rather than a utility or clinical form-filling app. For elderly dementia patients, traditional apps are intimidating, confusing, and frustrating. Nenil shifts the paradigm by presenting cognitive support through calm, joyful, and culturally resonant gaming experiences.

By tapping into preserved long-term memories — familiar melodies, household objects, personal family stories, and daily cultural routines — Nenil helps patients maintain neural pathways while giving caregivers a meaningful tool to connect with their loved ones every day.

---

## Core Gameplay

Unlike standard brain-training apps that emphasize high scores, speed, or competitive leaderboards, Nenil reimagines cognitive gaming specifically for neurodegenerative care:

- **Daily Cognitive Journey** — Patients experience a calm, guided daily routine of activities tailored to their time of day and energy level.
- **No Scores or Timers** — Games progress at the patient's natural pace. Urgency cues and clock pressure are strictly eliminated.
- **Positive Reinforcement Only** — There are no wrong answers, error sounds, or failure screens. Every attempt is greeted with gentle, encouraging feedback and celebration overlays.
- **Familiar Contexts** — Exercises use real family photos, caregiver voice recordings, and regional NER music rather than abstract puzzles.

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

- **Offline-first** — Full gameplay and routine support without an internet connection. Synchronization happens in the background via `SyncService` when connectivity is restored.
- **Multilingual** — Supports regional NER languages alongside Assamese, Hindi, and English, with caregiver-recorded audio for deeply personal guidance.
- **Stage-based** — Content and interaction complexity adapt to early, mid, and late-stage dementia, ensuring appropriateness and reducing frustration.
- **Caregiver-powered** — Family members and caregivers are active participants. They configure routines, record voices, link accounts, set emergency contacts, and monitor progress.
- **Culturally rooted** — Games, music, and imagery draw from familiar NER cultural contexts — not generic Western dementia toolkits.

---

## User Journey

```text
Caregiver
   │
   ▼
Creates Patient Profile ──► Selects Language & Dementia Stage
   │
   ▼
Personalized Home ───────► Audio Greeting & Daily Routine Overview
   │
   ▼
Today's Cognitive Journey─► Stage-Appropriate Activity Recommendation
   │
   ▼
Game Session ────────────► Calm Gameplay with Celebration Overlay & Audio Guidance
   │
   ▼
Caregiver Progress ──────► Session Analytics & Engagement Metrics Saved in SQLite
   │
   ▼
Safety Support ──────────► 5s Countdown SOS, Direct Call & GPS Location Sharing
```

---

## Feature Categories

### Cognitive Gaming

| Game | Description | Status |
|---|---|---|
| **My Daily Routine** | Guides patients through familiar morning-to-evening routines using audio prompts and visual imagery | `Complete` |
| **Find My Things** | Object-location memory exercises using personally meaningful household items | `Complete` |
| **Family Faces & Stories** | Photo-based recognition games using the patient's own family photos and caregiver audio captions | `Complete` |
| **Music Memory Journey** | Familiar regional and personal music prompts emotional memory, nostalgia, and engagement | `Complete` |
| **Emotion Match** | Gentle emotion recognition exercises using illustrated familiar faces and voice cues | `Complete` |

### Caregiver Companion

- **Patient–caregiver linking** — Secure QR code or numerical code account pairing
- **Permission-based access** — PIN-protected Caregiver Dashboard locking settings and configuration
- **Caregiver dashboard** — Central hub for managing patient profiles, games, routines, voice recordings, and offline sync
- **Session history** — Comprehensive logs of completed sessions, duration, and engagement levels
- **Caregiver insights** — Behavioral trends and actionable engagement guidance for families

### Safety Layer

- **Emergency support** — Floating SOS trigger with a 5-second safety countdown to prevent accidental triggers
- **Direct calling** — Instant voice call connection to registered primary caregivers
- **Voice-activated calling** — Spoken-word emergency call initiation for hands-free assistance
- **Real-time location sharing** — Automatic GPS location coordinate broadcasting to linked caregivers during emergency triggers

### Accessibility & Polish

- **Large touch targets** — Minimum 56dp interaction areas optimized for aging motor control
- **Voice-first interaction** — Spoken audio guidance / TTS for every screen, menu, and interactive prompt
- **High-Contrast & Large Text Modes** — Built-in `AccessibilityProvider` with visual accessibility toggles
- **Celebration Overlay** — Star particle effects and warm congratulatory speech on game completion
- **Offline-first gameplay** — Zero internet connection required for core gaming, routines, and emergency fallback

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
| **Animations** | Custom Particle Canvas + Lottie |
| **UI/UX Design** | Figma |
| **Version Control** | Git & GitHub |

---

## Architecture

```text
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
│          Caregiver Companion            │
│  Session History · Insights · Sync     │
└────────────────────┬────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────┐
│             Safety Layer                │
│   SOS 5s Countdown · Direct Call · GPS │
└─────────────────────────────────────────┘
```

> [!IMPORTANT]
> All game modules operate fully offline via SQLite. Background Supabase synchronization occurs seamlessly when internet connectivity is detected.

---

## Project Structure

```text
nenil/
├── lib/
│   ├── core/                  # Theme, accessibility, constants, routing config
│   ├── features/
│   │   ├── onboarding/        # Patient & caregiver registration flows
│   │   ├── caregiver/         # Dashboard, linking, session history, emergency config
│   │   ├── home/              # Patient home feed, journey feed, greeting header
│   │   ├── games/             # All five cognitive game modules
│   │   └── emergency/         # SOS, 5s countdown timer, call & GPS location
│   ├── services/              # Sync, TTS, audio, voice recording, location, calling
│   ├── storage/               # SQLite & Hive adapters
│   ├── models/                # Patient, Caregiver, Session, Routine models
│   └── shared/                # Celebration overlay, Nenil buttons, cards, audio prompt
├── android/                   # Native Android setup & key.properties template
├── assets/                    # Image assets, audio prompts, and animations
└── DEVELOPMENT_WORKFLOW.md    # Master engineering blueprint
```

---

## Development Roadmap & Status

| Sprint | Focus | Gameplay / Engineering Outcome | Status |
|---|---|---|---|
| **Sprint 0 — Foundation** | Project setup, navigation, design system, local DB schema | App shell, theme tokens, router stubs, SQLite tables initialized | `Complete` |
| **Sprint 1 — Caregiver World** | Patient & caregiver registration, PIN auth, profile setup, voice recording | Onboarding flow, PIN security, caregiver voice capture service | `Complete` |
| **Sprint 2 — Home Experience** | Personalized patient home screen, routine overview, daily journey feed | Functional home feed, audio greeting, stage-based activity selector | `Complete` |
| **Sprint 3 — Core Game Pack** | All 5 MVP games (Routine, Things, Faces, Music, Emotions) | Complete offline game pack playable with voice guidance | `Complete` |
| **Sprint 4 — Caregiver Companion** | Dashboard, patient-caregiver linking, session history, analytics | Caregiver dashboard live with session metrics & configuration tools | `Complete` |
| **Sprint 5 — Safety Layer** | Emergency SOS, 5s countdown, direct caregiver calling, location sharing | One-tap SOS, 5s safety countdown timer, direct call & GPS functional | `Complete` |
| **Sprint 6 — Production Polish** | Background offline sync engine, celebration overlay, accessibility audit | Signed release configuration, celebration animations & sync engine | `Complete` |

---

## Design Principles

Nenil's interface is governed by a strict set of design principles that prioritize dignity, calm, and clarity above all else:

1. **One task per screen** — No cognitive overload. Each screen has one clear purpose and one clear action.
2. **No timers in games** — Patients are never rushed. There are no countdown clocks or urgency cues in gameplay.
3. **No failure screens** — Activities do not produce error states or correction prompts. Every response is accepted with encouragement and celebratory star particles.
4. **Calm interactions** — Gentle animations, soft transitions, and no sudden visual changes.
5. **Voice-first guidance** — Every screen can be fully navigated through audio instructions / TTS.
6. **Large touch targets** — All interactive elements meet or exceed 56dp minimum touch area.
7. **Offline-first** — The app is 100% functional without connectivity. The network is never a blocker.

---

## Security & Privacy

Patient data, family media, and caregiver information are handled with clinical-grade care.

- **Encrypted local storage** — All SQLite and Hive data is encrypted at rest using device-level encryption
- **Permission-based caregiver access** — Caregivers can only access data and controls explicitly protected by PIN verification
- **Protected family media** — Photos, audio recordings, and personal assets are stored securely with offline fallbacks
- **Privacy-first data handling** — No personally identifiable data is shared with third parties. Analytics are aggregate and anonymized.

---

<div align="center">

Built with care for the people of India's North East Region.

**Nenil** · Smart India Hackathon 2026

</div>
