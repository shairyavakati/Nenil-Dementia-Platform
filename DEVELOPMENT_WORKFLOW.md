# Nenil — Development Workflow & Engineering Blueprint

> **Version:** 2.0.0 · **Status:** Active · **Maintainer:** Lead Mobile Architect
>
> This document is the single source of truth for engineering, designing, testing, and releasing Nenil.
> All contributors must follow this blueprint from Day 1 through production deployment.
> For the product overview and architectural summary, refer to [README.md](./README.md).

---

## Table of Contents

1. [Development Philosophy](#1-development-philosophy)
2. [Core Gameplay Vision](#2-core-gameplay-vision)
3. [Gameplay Loop](#3-gameplay-loop)
4. [Stage-Based Progression](#4-stage-based-progression)
5. [Game Design Standards](#5-game-design-standards)
6. [Screen Build Order](#6-screen-build-order)
7. [Game-First Development Sprints](#7-game-first-development-sprints)
8. [Git Workflow](#8-git-workflow)
9. [Project Setup Workflow](#9-project-setup-workflow)
10. [Folder Architecture](#10-folder-architecture)
11. [Feature Development Rules](#11-feature-development-rules)
12. [Testing Workflow](#12-testing-workflow)
13. [Debugging Workflow](#13-debugging-workflow)
14. [Code Quality Rules](#14-code-quality-rules)
15. [Definition of Done](#15-definition-of-done)
16. [Release Workflow](#16-release-workflow)

---

## 1. Development Philosophy

Nenil is a production-grade application serving a vulnerable population. Every engineering decision must reflect that responsibility.

### Offline-First Development

The application must be fully functional without an internet connection. This is not a feature — it is a constraint that governs every architectural decision.

- **Local data is the source of truth.** All reads and writes happen against SQLite first.
- **Supabase sync is background-only.** Network operations never block the UI thread or the user experience.
- **Assume connectivity will fail.** Design every feature to degrade gracefully when offline.

### One Feature Per Branch

No feature is developed on `main` or `develop` directly. Every piece of work — no matter how small — lives on its own branch until it is reviewed, tested, and merged.

### One Responsibility Per File

Every Dart file has a single, clearly named responsibility. A screen file contains only the screen widget. A provider file contains only its provider logic. A model file contains only its data model. This is non-negotiable.

### Modular Architecture

The project is organized by feature, not by type. All files for a given feature — its UI, providers, models, and services — live together under `lib/features/<feature>/`. Shared utilities live in `lib/shared/` and `lib/core/`.

---

## 2. Core Gameplay Vision

Nenil is designed to deliver a specific **emotional experience** for elderly patients living with dementia:

```text
  ┌──────────────┐      ┌──────────────┐      ┌──────────────┐      ┌─────────────────────────┐
  │     CALM     │ ───► │   FAMILIAR   │ ───► │  SUPPORTIVE  │ ───► │ NO COMPETITIVE PRESSURE │
  └──────────────┘      └──────────────┘      └──────────────┘      └─────────────────────────┘
```

- **Calm** — Soothing visual palettes, gentle transitions, zero abrupt alarms or flashing elements.
- **Familiar** — Real family photos, familiar regional melodies, localized objects, and caregiver voice prompts.
- **Supportive** — Encouraging feedback on every interaction. No error sounds, red cross icons, or failure states.
- **No Competitive Pressure** — No countdown clocks, no high-score tables, no performance grading.

The objective of every game module is cognitive stimulation, emotional comfort, and dignity preservation — never skill evaluation.

---

## 3. Gameplay Loop

Every interactive session follows a predictable, soothing gameplay loop:

```text
Open App ──► Audio Greeting ──► Suggested Activity ──► Play Game Module ──► Completion Celebration ──► Return Home ──► Save Progress
```

### Detailed Loop Steps

1. **Open App** — Patient launches app or is handed the device by a caregiver.
2. **Audio Greeting** — App plays spoken greeting in the patient's chosen language or caregiver's recorded voice.
3. **Suggested Activity** — Home screen presents "Today's Cognitive Journey" with one prominent, recommended activity card.
4. **Play Game Module** — Patient engages in a calm, audio-guided game session.
5. **Completion Celebration** — Gentle Lottie animation (e.g., soft blooming flowers, warm applause) accompanied by an encouraging audio prompt.
6. **Return Home** — Smooth transition back to the home feed.
7. **Save Progress** — Session metrics (duration, activities attempted, engagement indicator) are silently persisted to local SQLite for caregiver review.

---

## 4. Stage-Based Progression

Nenil dynamically adapts content and interface complexity based on the patient's dementia stage configured in their profile.

| Parameter | Mild (Early Stage) | Moderate (Mid Stage) | Severe (Late Stage) |
|---|---|---|---|
| **Choice Density** | 3 to 4 options per prompt | 2 simple options per prompt | 1 focal interactive prompt |
| **Visual Style** | Detailed photos & illustrations | High contrast, simplified shapes | Bold, large single visual element |
| **Audio Dependence** | Audio supports visual cues | Audio-first with spoken choices | Continuous comforting audio guidance |
| **Session Target** | 10 – 15 minutes | 5 – 10 minutes | 2 – 5 minutes |
| **Caregiver Controls** | Can adjust difficulty & modules | Locks module selection to favorites | Restricts interface to music & photos |

Caregivers can override or fine-tune these progression parameters at any time via the PIN-protected Caregiver Dashboard.

---

## 5. Game Design Standards

Every game module must strictly satisfy these seven design rules. A screen that violates any standard will fail code review.

1. **One task per screen** — Never combine multiple decisions or interactions on a single screen.
2. **No timers** — Never display a countdown clock, speed bonus, or time limit.
3. **No failure screens** — Never show "Wrong", "Failed", red error badges, or play negative sound effects.
4. **Large touch targets** — All interactive buttons and cards must be at least **56dp × 56dp**.
5. **Calm animations** — Use smooth, slow Lottie or Flutter transitions (minimum 400ms duration).
6. **Voice-first guidance** — Every prompt must be readable visually AND spoken aloud via TTS or caregiver audio.
7. **One primary action per screen** — The main interaction button must be visually distinct and centered.

---

## 6. Screen Build Order

To ensure clean navigation routing and dependency management, screens must be implemented in this exact sequence:

```text
 1. Splash Screen ──────────────► App initialization & database check
 2. Language Selection ────────► Initial language setup
 3. Caregiver Login / Auth ────► Account authentication & PIN creation
 4. Patient Profile ───────────► Patient details, stage selection & photo
 5. Stage Selection ───────────► Early / Mid / Late stage preference
 6. Patient Home ──────────────► Personalized daily journey feed
 7. Game Module Screen ────────► Active game play wrapper & interaction
 8. Game Completion Screen ────► Celebration animation & return option
 9. Caregiver Dashboard ───────► Session analytics, config & voice recorder
10. Emergency / SOS Screen ────► Direct call trigger & location status
```

---

## 7. Game-First Development Sprints

Development is organized into seven sequential sprints. Each sprint produces a functional, demonstrable milestone.

### Sprint 0 — Foundation

**Objective:** Establish the Flutter project scaffold, Material 3 design system, local database schema, and navigation stubs.

- **Deliverables:**
  - Project scaffold with `pubspec.yaml` dependencies (`riverpod`, `gorouter`, `sqflite`, `hive`, `just_audio`, `record`, `supabase_flutter`, `lottie`)
  - Material Design 3 theme tokens (`AppColors`, `AppTypography`, `AppDimensions`)
  - GoRouter configuration covering all 10 screens
  - SQLite database initializer with full table schema
  - Shared widgets: `NenilButton`, `NenilCard`, `GameWrapper`, `AudioPromptWidget`
- **Files:** `pubspec.yaml`, `lib/main.dart`, `lib/core/`, `lib/storage/`, `lib/shared/`
- **Outcome:** App compiles and launches on Android emulator with zero analyzer errors.

---

### Sprint 1 — Caregiver World

**Objective:** Build the onboarding, patient profile setup, PIN authentication, and caregiver voice recording pipeline.

- **Deliverables:**
  - Language selection screen with regional NER support
  - Caregiver registration & Supabase Auth integration
  - Patient profile setup (name, photo, dementia stage selection)
  - PIN setup for Caregiver Mode entry
  - Caregiver voice recording service using `record` and `just_audio`
- **Files:** `lib/features/onboarding/`, `lib/features/auth/`, `lib/features/caregiver/`, `lib/services/audio_service.dart`
- **Outcome:** Complete onboarding flow playable offline with local persistence.

---

### Sprint 2 — Home Experience

**Objective:** Deliver the personalized patient home interface with the daily cognitive journey feed and voice greeting.

- **Deliverables:**
  - Patient home screen with large visual activity cards
  - Spoken audio greeting using Native TTS or caregiver voice
  - Dynamic routine feed filtering by time of day (Morning / Afternoon / Evening)
  - One-tap SOS floating button overlay
- **Files:** `lib/features/home/`, `lib/services/tts_service.dart`
- **Outcome:** Patient home feed renders personalized activities and responds to touch/voice.

---

### Sprint 3 — Core Game Pack

**Objective:** Implement all five core MVP cognitive games with stage adaptation and offline SQLite persistence.

#### 1. My Daily Routine
- **Purpose:** Reinforce temporal orientation and familiar habit sequences.
- **Gameplay:** Patient views sequential routine cards (e.g., morning tea, watering plants, evening bath).
- **User Interaction:** Large single-tap "Next Step" or card selection.
- **Voice Behavior:** Plays caregiver audio or TTS describing the routine activity.
- **Completion Behavior:** Displays gentle completion card with positive audio reinforcement.

#### 2. Find My Things
- **Purpose:** Exercise object-location memory using familiar personal items.
- **Gameplay:** Displays a personal object (e.g., spectacles, keys) and asks patient to tap its location.
- **User Interaction:** Touch matching object image on a 2-card or 4-card grid (based on stage).
- **Voice Behavior:** "Where do we keep your reading glasses, grandmother?"
- **Completion Behavior:** Object animates into place with warm visual feedback.

#### 3. Family Faces & Stories
- **Purpose:** Stimulate long-term memory and identity retention using family photos.
- **Gameplay:** Shows a caregiver-uploaded photo of a family member.
- **User Interaction:** Tap the matching name or relation card.
- **Voice Behavior:** Plays caregiver-recorded voice caption: "This is your son Rahul at the festival."
- **Completion Behavior:** Photo expands with a heart animation and audio story playback.

#### 4. Music Memory Journey
- **Purpose:** Evoke emotional memory and comfort through familiar regional music.
- **Gameplay:** Patient listens to curated NER folk tunes or favorite songs uploaded by caregiver.
- **User Interaction:** Large play/pause button with simple "I remember this" indicator.
- **Voice Behavior:** Spoken track introduction in selected regional language.
- **Completion Behavior:** Smooth music fade-out with gentle gratitude prompt.

#### 5. Emotion Match
- **Purpose:** Gentle emotional recognition and empathetic engagement.
- **Gameplay:** Matches illustrated facial expressions (happy, calm, reflective) with audio context cues.
- **User Interaction:** Single-tap selection between 2 high-contrast emotion illustration cards.
- **Voice Behavior:** "Which picture shows a happy smile?"
- **Completion Behavior:** Illustration brightens with positive audio response.

- **Files:** `lib/features/games/`, `assets/audio/`, `assets/images/`, `lib/storage/database/`
- **Outcome:** All 5 games playable offline with complete stage-appropriate scaling.

---

### Sprint 4 — Caregiver Companion

**Objective:** Build the caregiver management layer — patient linking, dashboard, session history logs, and engagement insights.

- **Deliverables:**
  - PIN-protected Caregiver Dashboard screen
  - Patient–caregiver account linking via QR code or numeric code
  - Session history list with game type, date, duration, and engagement level
  - Caregiver Insights panel summarizing weekly activity trends
  - Configuration editor for games, custom photos, audio prompts, and routines
- **Files:** `lib/features/caregiver/`, `lib/models/session_model.dart`, `supabase/migrations/`
- **Outcome:** Caregiver can lock/unlock settings, customize content, and review session history.

---

### Sprint 5 — Safety Layer

**Objective:** Implement emergency SOS support, direct caregiver calling, voice activation, and real-time location sharing.

- **Deliverables:**
  - One-tap SOS trigger on patient home interface
  - Direct call integration using native telephony services
  - Voice-activated emergency call trigger
  - Real-time GPS location sharing to linked caregiver
  - Non-intrusive safety overlay that does not disrupt calm game play
- **Files:** `lib/features/emergency/`, `lib/services/call_service.dart`, `lib/services/location_service.dart`
- **Outcome:** Emergency features accessible within 1 tap or voice prompt at all times.

---

### Sprint 6 — Production Polish

**Objective:** Implement background Supabase sync, Lottie animations, accessibility verification, and release APK building.

- **Deliverables:**
  - Background `SyncService` — syncs SQLite sessions and profiles to Supabase when online
  - Conflict-free offline sync strategy (local ID mapping & timestamp ordering)
  - Lottie celebration animations for all game completions
  - Accessibility audit (56dp touch targets, WCAG AA contrast, TalkBack semantics)
  - Release build signing configuration (`key.properties`)
  - Standalone release APK generation and verification
- **Files:** `lib/services/sync_service.dart`, `assets/animations/`, `android/key.properties`
- **Outcome:** Signed production APK ready for SIH 2026 judging and distribution.

---

## 8. Git Workflow

### Branch Structure

```text
origin/main          ← Production-only. Protected. Releases tagged here.
origin/develop       ← Integration branch. All features merge here first.
origin/feature/*     ← Individual feature branches. One branch per feature.
origin/fix/*         ← Bug fix branches.
origin/hotfix/*      ← Critical production fixes only.
```

### Flow Diagram

```text
feature/onboarding ──┐
feature/home        ──┤──► develop ──► main (tagged release)
feature/caregiver   ──┘
```

### Branch Naming Convention

| Type | Pattern | Example |
|---|---|---|
| Feature | `feature/<scope>` | `feature/onboarding` |
| Game module | `feature/<game-name>` | `feature/find-my-things` |
| Caregiver flow | `feature/caregiver-<scope>` | `feature/caregiver-dashboard` |
| Bug fix | `fix/<short-description>` | `fix/audio-playback-null` |
| Hotfix | `hotfix/<short-description>` | `hotfix/sos-crash-android13` |
| Documentation | `docs/<scope>` | `docs/readme-update` |

### Commit Message Convention

All commits must follow the Conventional Commits specification: `<type>(<scope>): <description>`

```text
feat(onboarding): add patient name and language selection screen
fix(audio): resolve null exception on TTS init in offline mode
refactor(games): extract shared game wrapper into reusable widget
docs(workflow): update sprint plan and game design standards
test(caregiver): add unit tests for linking provider
chore(deps): upgrade just_audio to 0.9.38
a11y(home): increase touch target size to 56dp minimum
```

---

## 9. Project Setup Workflow

Complete this checklist in order before writing feature code:

### Environment Setup
- [ ] Install Flutter SDK (stable channel)
  ```bash
  flutter channel stable && flutter upgrade && flutter doctor
  ```
- [ ] Install Android Studio with Android API Level 34 target SDK
- [ ] Install VS Code with Flutter, Dart, Riverpod Snippets, and Error Lens extensions
- [ ] Launch Android Emulator (Pixel 6a or equivalent, API 34)

### Repository Setup
- [ ] Clone repository: `git clone https://github.com/shairyavakati/Nenil-Dementia-Platform.git`
- [ ] Checkout integration branch: `git checkout develop`
- [ ] Fetch dependencies: `flutter pub get`

### Supabase Setup
- [ ] Create project at [supabase.com](https://supabase.com)
- [ ] Add `.env` file at project root (never commit):
  ```env
  SUPABASE_URL=https://your-project.supabase.co
  SUPABASE_ANON_KEY=your-anon-key
  ```
- [ ] Initialize Supabase client in `lib/core/config/supabase_config.dart`

### First Build Verification
- [ ] Run application: `flutter run`
- [ ] Analyze codebase: `flutter analyze` (zero issues required)

---

## 10. Folder Architecture

```text
nenil/
├── lib/
│   ├── core/                  # Theme, constants, router, Supabase config
│   │   ├── constants/         # Colors, typography, spacing, assets
│   │   ├── theme/             # Material Design 3 theme
│   │   ├── router/            # GoRouter configuration
│   │   └── config/            # Supabase & app configuration
│   ├── features/              # Feature modules (UI, providers, models)
│   │   ├── onboarding/        # Language & patient/caregiver registration
│   │   ├── auth/              # Supabase Auth & PIN authentication
│   │   ├── home/              # Patient home feed & daily journey
│   │   ├── caregiver/         # Dashboard, linking, history & insights
│   │   ├── games/             # Game modules
│   │   │   ├── daily_routine/
│   │   │   ├── find_my_things/
│   │   │   ├── family_faces/
│   │   │   ├── music_memory/
│   │   │   └── emotion_match/
│   │   └── emergency/         # SOS, calling & location sharing
│   ├── services/              # Audio, TTS, location, calling, sync
│   ├── storage/               # SQLite database & Hive cache
│   ├── models/                # Data models (Patient, Caregiver, Session)
│   └── shared/                # Reusable widgets & extensions
├── assets/                    # Images, audio prompts, Lottie animations
├── supabase/                  # Database migrations & Edge functions
├── test/                      # Unit, widget, and integration tests
├── .env                       # Environment variables (ignored)
├── README.md                  # Product overview
└── DEVELOPMENT_WORKFLOW.md   # Engineering blueprint
```

---

## 11. Feature Development Rules

Every feature must follow this strict 7-step process:

```text
Step 1 — Create Feature Branch
  git checkout develop && git pull origin develop
  git checkout -b feature/<feature-name>

Step 2 — Build UI
  Create screen under lib/features/<feature>/screens/
  Use only Material 3 tokens and shared widgets from lib/shared/
  Integrate AudioPromptWidget on interactive screens

Step 3 — Connect Local Storage
  Write SQLite queries in lib/storage/database/app_database.dart
  Verify offline read/write persistence

Step 4 — Connect Backend
  Implement background Supabase operations in relevant service
  Wrap in try-catch blocks with graceful offline fallback

Step 5 — Test
  Verify feature manually on emulator with Airplane Mode ON and OFF
  Execute testing checklist

Step 6 — Commit
  flutter analyze (zero issues)
  git add . && git commit -m "feat(<scope>): <description>"

Step 7 — Merge
  Push to origin feature/<feature-name>
  Open PR targeting develop → Review → Squash and merge
```

> [!IMPORTANT]
> Step 3 (Local Storage) must ALWAYS precede Step 4 (Backend). Local SQLite is the primary source of truth.

---

## 12. Testing Workflow

Before opening a PR, complete this mandatory verification checklist:

### Functional & UI
- [ ] All screens render without layout overflow
- [ ] Navigation follows defined GoRouter routes
- [ ] Touch targets meet or exceed 56dp

### Offline & Database
- [ ] Feature works 100% in Airplane Mode
- [ ] Data persists across cold app restarts
- [ ] SQLite tables reflect updated session data

### Audio & Accessibility
- [ ] Audio prompts play on screen launch
- [ ] TTS accurately speaks all screen titles and options
- [ ] TalkBack semantics verified on key interactions

### Code Quality
- [ ] `flutter analyze` returns zero warnings or errors
- [ ] All new code conforms to code quality standards

---

## 13. Debugging Workflow

Follow this diagnostic order when an issue arises:

```text
1. Run Flutter Analyze ──► Fix all lints and syntax errors immediately
2. Inspect Console ──────► Identify exact line, stack trace, and exception type
3. Isolate Behavior ─────► Test with Hot Restart (R) vs Cold Start
4. Check SQLite DB ──────► Inspect local sqlite file via DevTools / DB Browser
5. Check Supabase DB ────► Inspect table schema, RLS rules, and API logs
6. Inspect Providers ────► Verify Riverpod state changes via DevTools inspector
```

---

## 14. Code Quality Rules

- **One Widget Per File** — Maintain single-widget focus per file.
- **No Hardcoded Strings** — All user text must use `AppStrings` or localization keys.
- **No Hardcoded Colors** — Use `AppColors` Material 3 palette tokens.
- **Explicit Disposal** — Dispose all `AudioPlayer`, `TextEditingController`, and `AnimationController` instances.
- **Null Safety** — Avoid `!` force-unwrap; use explicit null checks or default fallbacks.

---

## 15. Definition of Done

A feature is complete only when every box is checked:

- [ ] **Gameplay Works** — Interaction flow is smooth, calm, and correct.
- [ ] **Offline Works** — Feature is fully functional without internet connection.
- [ ] **Voice Works** — Audio guidance / TTS prompts execute cleanly on screen load.
- [ ] **Caregiver Customization Works** — Caregiver settings correctly alter gameplay behavior.
- [ ] **Accessibility Passes** — Minimum 56dp touch targets and high-contrast text verified.
- [ ] **No Analyzer Errors** — `flutter analyze` reports zero issues.
- [ ] **Tested** — Manual offline and functional testing checklist passed.
- [ ] **Documented** — Code comments and sprint tracking updated.
- [ ] **Committed** — Staged and committed using Conventional Commits.

---

## 16. Release Workflow

### Versioning Scheme
Format: `MAJOR.MINOR.PATCH+BUILD` (e.g., `1.0.0+1` in `pubspec.yaml`)

### Production Build Steps
```bash
# 1. Ensure clean git state on main
git checkout main && git merge develop

# 2. Run final verification
flutter analyze && flutter test

# 3. Generate signed release APK
flutter build apk --release

# 4. Output location
# build/app/outputs/flutter-apk/app-release.apk
```

> [!CAUTION]
> Never build production artifacts from the `develop` branch. Release builds must originate from tagged commits on `main`.

---

<div align="center">

**Nenil Engineering Team** · Smart India Hackathon 2026

*This blueprint is version-controlled. All updates must be committed to the repository and reviewed by the Lead Mobile Architect.*

</div>
