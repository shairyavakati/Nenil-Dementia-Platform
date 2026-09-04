# Nenil — Development Workflow

> **Version:** 1.0.0 · **Status:** Active · **Maintainer:** Engineering Lead
>
> This document is the single source of truth for building, testing, and releasing Nenil.
> All contributors must read and follow this workflow before writing a single line of code.

---

## Table of Contents

1. [Development Philosophy](#1-development-philosophy)
2. [Git Workflow](#2-git-workflow)
3. [Project Setup Workflow](#3-project-setup-workflow)
4. [Folder Architecture](#4-folder-architecture)
5. [Development Phases](#5-development-phases)
6. [Feature Development Workflow](#6-feature-development-workflow)
7. [Testing Workflow](#7-testing-workflow)
8. [Debugging Workflow](#8-debugging-workflow)
9. [Code Quality Rules](#9-code-quality-rules)
10. [Definition of Done](#10-definition-of-done)
11. [Release Workflow](#11-release-workflow)

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

### Production-Quality Standards

This is not a prototype. The codebase must be maintainable, readable, and extendable by any contributor. Code that works but is unreadable will be rejected. Code that is readable but untested will be rejected. Both conditions must be met.

---

## 2. Git Workflow

### Branch Structure

```
origin/main          ← Production-only. Protected. Releases tagged here.
origin/develop       ← Integration branch. All features merge here first.
origin/feature/*     ← Individual feature branches. One branch per feature.
origin/fix/*         ← Bug fix branches.
origin/hotfix/*      ← Critical production fixes only.
```

### Flow Diagram

```
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

### Feature Branch Examples

```
feature/onboarding
feature/find-my-things
feature/family-faces
feature/music-memory
feature/emotion-match
feature/daily-routine
feature/caregiver-dashboard
feature/caregiver-linking
feature/session-history
feature/emergency-sos
feature/location-sharing
feature/voice-call
feature/offline-sync
feature/accessibility-audit
```

### Commit Message Convention

All commits must follow the Conventional Commits specification.

```
<type>(<scope>): <short description>
```

| Type | When to Use |
|---|---|
| `feat` | New feature or screen |
| `fix` | Bug fix |
| `refactor` | Code restructuring without behavior change |
| `docs` | Documentation changes only |
| `style` | Formatting, spacing, no logic change |
| `test` | Adding or updating tests |
| `chore` | Build config, dependency updates, CI changes |
| `perf` | Performance improvements |
| `a11y` | Accessibility improvements |

**Examples:**

```
feat(onboarding): add patient name and language selection screen
fix(audio): resolve null exception on TTS init in offline mode
refactor(games): extract shared game wrapper into reusable widget
docs(workflow): add sprint 2 acceptance criteria
test(caregiver): add unit tests for linking provider
chore(deps): upgrade just_audio to 0.9.38
a11y(home): increase touch target size to 56dp minimum
```

### Pull Request Rules

- Every PR targets `develop`, never `main`.
- PRs require at least one reviewer approval before merging.
- All Definition of Done criteria must be satisfied before opening a PR.
- PR title must match the commit convention.
- Squash and merge is the default merge strategy.

---

## 3. Project Setup Workflow

Complete this checklist in order before writing any feature code.

### Environment Setup

- [ ] Install Flutter SDK (stable channel, latest stable version)
  ```bash
  flutter channel stable
  flutter upgrade
  flutter doctor
  ```
- [ ] Resolve all `flutter doctor` warnings before proceeding
- [ ] Install Android Studio (latest stable)
- [ ] Install Android SDK via Android Studio SDK Manager
  - Android API Level 33 minimum
  - Android API Level 34 target
- [ ] Install VS Code
- [ ] Install VS Code extensions:
  - Flutter
  - Dart
  - Riverpod Snippets
  - Error Lens
  - GitLens
  - Pubspec Assist
- [ ] Create and start Android Emulator
  - Device: Pixel 6a or equivalent mid-range device
  - API Level: 34
  - RAM: 2048 MB minimum

### Repository Setup

- [ ] Clone the repository
  ```bash
  git clone https://github.com/shairyavakati/Nenil-Dementia-Platform.git
  cd Nenil-Dementia-Platform
  ```
- [ ] Checkout `develop` branch
  ```bash
  git checkout develop
  ```
- [ ] Install all Flutter dependencies
  ```bash
  flutter pub get
  ```
- [ ] Verify no dependency conflicts
  ```bash
  flutter pub outdated
  ```

### Supabase Setup

- [ ] Create a Supabase project at [supabase.com](https://supabase.com)
- [ ] Copy the project URL and anon key from the Supabase dashboard
- [ ] Create a `.env` file at the project root (never commit this file)
  ```
  SUPABASE_URL=https://your-project.supabase.co
  SUPABASE_ANON_KEY=your-anon-key
  ```
- [ ] Verify `.env` is listed in `.gitignore`
- [ ] Initialize Supabase client in `lib/core/supabase_config.dart`
- [ ] Run database migrations from `supabase/migrations/`

### First Build Verification

- [ ] Run the application on the emulator
  ```bash
  flutter run
  ```
- [ ] Verify the app launches without errors
- [ ] Run the analyzer
  ```bash
  flutter analyze
  ```
- [ ] Confirm zero analyzer errors before proceeding

> [!IMPORTANT]
> Do not begin feature development until `flutter doctor`, `flutter analyze`, and `flutter run` all pass without errors.

---

## 4. Folder Architecture

### Full Structure

```text
nenil/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_strings.dart
│   │   │   ├── app_dimensions.dart
│   │   │   └── app_assets.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   ├── router/
│   │   │   └── app_router.dart
│   │   ├── config/
│   │   │   └── supabase_config.dart
│   │   └── utils/
│   │       ├── date_utils.dart
│   │       └── tts_utils.dart
│   │
│   ├── features/
│   │   ├── onboarding/
│   │   │   ├── screens/
│   │   │   ├── providers/
│   │   │   ├── models/
│   │   │   └── widgets/
│   │   ├── auth/
│   │   │   ├── screens/
│   │   │   ├── providers/
│   │   │   └── widgets/
│   │   ├── home/
│   │   │   ├── screens/
│   │   │   ├── providers/
│   │   │   └── widgets/
│   │   ├── caregiver/
│   │   │   ├── screens/
│   │   │   ├── providers/
│   │   │   ├── models/
│   │   │   └── widgets/
│   │   ├── games/
│   │   │   ├── daily_routine/
│   │   │   │   ├── screens/
│   │   │   │   ├── providers/
│   │   │   │   ├── models/
│   │   │   │   └── widgets/
│   │   │   ├── find_my_things/
│   │   │   │   ├── screens/
│   │   │   │   ├── providers/
│   │   │   │   ├── models/
│   │   │   │   └── widgets/
│   │   │   ├── family_faces/
│   │   │   │   ├── screens/
│   │   │   │   ├── providers/
│   │   │   │   ├── models/
│   │   │   │   └── widgets/
│   │   │   ├── music_memory/
│   │   │   │   ├── screens/
│   │   │   │   ├── providers/
│   │   │   │   ├── models/
│   │   │   │   └── widgets/
│   │   │   └── emotion_match/
│   │   │       ├── screens/
│   │   │       ├── providers/
│   │   │       ├── models/
│   │   │       └── widgets/
│   │   ├── emergency/
│   │   │   ├── screens/
│   │   │   ├── providers/
│   │   │   └── widgets/
│   │   └── settings/
│   │       ├── screens/
│   │       ├── providers/
│   │       └── widgets/
│   │
│   ├── services/
│   │   ├── audio_service.dart
│   │   ├── tts_service.dart
│   │   ├── location_service.dart
│   │   ├── call_service.dart
│   │   ├── sync_service.dart
│   │   └── permission_service.dart
│   │
│   ├── storage/
│   │   ├── database/
│   │   │   ├── app_database.dart
│   │   │   └── migrations/
│   │   └── cache/
│   │       └── hive_config.dart
│   │
│   ├── models/
│   │   ├── patient_model.dart
│   │   ├── caregiver_model.dart
│   │   ├── session_model.dart
│   │   └── game_progress_model.dart
│   │
│   └── shared/
│       ├── widgets/
│       │   ├── nenil_button.dart
│       │   ├── nenil_card.dart
│       │   ├── audio_prompt_widget.dart
│       │   └── game_wrapper.dart
│       └── extensions/
│           ├── context_extensions.dart
│           └── string_extensions.dart
│
├── assets/
│   ├── images/
│   ├── audio/
│   │   ├── prompts/
│   │   └── music/
│   └── animations/
│
├── supabase/
│   ├── migrations/
│   └── functions/
│
├── test/
│   ├── unit/
│   ├── widget/
│   └── integration/
│
├── .env                    ← Never committed
├── .gitignore
├── pubspec.yaml
├── README.md
└── DEVELOPMENT_WORKFLOW.md
```

### Folder Responsibilities

| Folder | Responsibility |
|---|---|
| `lib/core/` | App-wide constants, theme tokens, router config, Supabase client |
| `lib/features/` | Self-contained feature modules — UI, state, and models colocated |
| `lib/features/games/` | One subfolder per game, each independently developed and testable |
| `lib/services/` | Platform services — audio, TTS, location, calling, sync |
| `lib/storage/` | SQLite database setup, migrations, Hive cache configuration |
| `lib/models/` | Shared cross-feature data models |
| `lib/shared/` | Reusable widgets and Dart extensions used across features |
| `assets/` | All static assets — images, audio, Lottie animations |
| `supabase/` | Database migrations and Supabase Edge Functions |
| `test/` | Unit, widget, and integration tests mirroring `lib/` structure |

---

## 5. Development Phases

### Sprint 0 — Foundation

**Objective:** Establish the complete project scaffold, design system, and core infrastructure before any feature work begins.

**Deliverables:**

| # | Deliverable |
|---|---|
| 1 | Flutter project initialized with all dependencies in `pubspec.yaml` |
| 2 | Material Design 3 theme configured in `app_theme.dart` |
| 3 | Color palette, typography, and spacing tokens in `core/constants/` |
| 4 | GoRouter configured with all named routes as stubs |
| 5 | SQLite database initialized with full schema |
| 6 | Hive adapters registered |
| 7 | Supabase client initialized and environment variables configured |
| 8 | Riverpod `ProviderScope` wrapping the app root |
| 9 | Shared widgets: `NenilButton`, `NenilCard`, `GameWrapper`, `AudioPromptWidget` |
| 10 | `SyncService` stub with connectivity detection |
| 11 | Base app running on emulator with zero analyzer errors |

**Files Affected:**
`pubspec.yaml`, `lib/main.dart`, `lib/core/`, `lib/storage/`, `lib/shared/`, `supabase/migrations/`

**Acceptance Criteria:**
- [ ] `flutter analyze` returns zero issues
- [ ] App launches to a placeholder home screen
- [ ] SQLite tables are created on first launch
- [ ] Theme tokens are applied across all stub screens
- [ ] GoRouter navigates between all stub routes

---

### Sprint 1 — Caregiver Onboarding

**Objective:** Build the complete patient and caregiver registration and profile setup flows.

**Deliverables:**

| # | Deliverable |
|---|---|
| 1 | Welcome screen with language selection |
| 2 | Patient profile creation (name, photo, dementia stage) |
| 3 | Caregiver registration (name, phone, relationship) |
| 4 | Supabase Auth integration for caregiver accounts |
| 5 | Patient–caregiver linking flow |
| 6 | PIN setup screen for caregiver mode |
| 7 | Caregiver voice recording per game module |
| 8 | Daily routine configuration screen |
| 9 | Onboarding data persisted to SQLite |
| 10 | Onboarding completion navigates to home screen |

**Files Affected:**
`lib/features/onboarding/`, `lib/features/auth/`, `lib/features/caregiver/`, `lib/storage/database/`, `lib/services/audio_service.dart`

**Acceptance Criteria:**
- [ ] Patient profile is saved locally and to Supabase when online
- [ ] Language selection persists across app restarts
- [ ] Caregiver PIN is stored encrypted
- [ ] Voice recordings are saved locally and uploadable when online
- [ ] Onboarding can be completed entirely offline

---

### Sprint 2 — Core Games

**Objective:** Build all five cognitive game modules with full offline support and stage-based content delivery.

#### My Daily Routine

**Deliverables:**
- Routine activity list screen (morning, afternoon, evening)
- Activity detail screen with image, audio prompt, and completion action
- Routine data configurable by caregiver
- Completion state persisted per session

#### Find My Things

**Deliverables:**
- Item selection screen (personal objects)
- Location matching interaction (image-based)
- Caregiver-uploadable item photos
- Progress tracking per session

#### Family Faces & Stories

**Deliverables:**
- Family member gallery from caregiver-uploaded photos
- Name recognition prompt with audio
- Caregiver-recorded caption audio per photo
- Session engagement metrics saved

#### Music Memory Journey

**Deliverables:**
- Music track list from local audio assets
- Audio playback with just_audio
- Simple interaction (tap to listen, confirm recognition)
- Engagement state saved per session

#### Emotion Match

**Deliverables:**
- Illustrated emotion cards
- Matching interaction
- Encouraging completion feedback (no failure states)
- Session engagement saved

**Files Affected:**
`lib/features/games/`, `lib/services/audio_service.dart`, `lib/services/tts_service.dart`, `lib/storage/database/`, `assets/`

**Acceptance Criteria:**
- [ ] All five games are fully playable without internet
- [ ] Every game screen has an audio instruction prompt
- [ ] No game produces a failure or error screen
- [ ] Session engagement data is written to SQLite on completion
- [ ] Stage-based content loads correctly for Early, Mid, and Late stage profiles

---

### Sprint 3 — Caregiver Features

**Objective:** Build the complete caregiver management layer — linking, access control, dashboard, and session history.

**Deliverables:**

| # | Deliverable |
|---|---|
| 1 | Caregiver dashboard screen (linked patient overview) |
| 2 | Patient–caregiver account linking via code or QR |
| 3 | Permission model: caregiver can only access granted data |
| 4 | PIN-protected caregiver mode entry |
| 5 | Session history list (per patient, per game, per date) |
| 6 | Session detail view (duration, activity, engagement) |
| 7 | Caregiver insights panel (engagement trends) |
| 8 | Caregiver configuration edit (routine, voice, language) |

**Files Affected:**
`lib/features/caregiver/`, `lib/models/session_model.dart`, `lib/models/caregiver_model.dart`, `supabase/migrations/`

**Acceptance Criteria:**
- [ ] Caregiver can only access the dashboard via correct PIN
- [ ] Session history displays accurately from local SQLite
- [ ] Caregiver configuration changes are reflected immediately in patient UI
- [ ] Unlinking a caregiver removes all access permissions

---

### Sprint 4 — Safety Features

**Objective:** Build all emergency and safety features, including SOS, direct calling, voice activation, and location sharing.

**Deliverables:**

| # | Deliverable |
|---|---|
| 1 | Emergency SOS button on home screen (single tap) |
| 2 | SOS confirmation screen with countdown cancel |
| 3 | Direct call to primary caregiver |
| 4 | Voice-activated emergency call trigger |
| 5 | Real-time location sharing to linked caregiver |
| 6 | Location permission request and management |
| 7 | Emergency contact configuration in caregiver settings |

**Files Affected:**
`lib/features/emergency/`, `lib/services/call_service.dart`, `lib/services/location_service.dart`, `lib/services/permission_service.dart`

**Acceptance Criteria:**
- [ ] SOS button is reachable within one tap from home screen
- [ ] Emergency call connects to the correct primary caregiver
- [ ] Location sharing activates when SOS is triggered
- [ ] All permissions are requested with a clear, accessible explanation
- [ ] Safety features function when offline (calling does not require data)

---

### Sprint 5 — Production Polish

**Objective:** Finalize the application for release — sync, animations, accessibility, performance, and APK generation.

**Deliverables:**

| # | Deliverable |
|---|---|
| 1 | Background Supabase sync — all local data synced when online |
| 2 | Conflict resolution strategy for offline-first sync |
| 3 | Lottie animations on game completions and transitions |
| 4 | Full accessibility audit (touch targets, contrast, audio) |
| 5 | Multilingual content pack integration |
| 6 | Performance profiling and frame-rate optimization |
| 7 | Release build configuration (signing, minification) |
| 8 | Internal APK distribution and testing |
| 9 | Final `flutter analyze` and `flutter test` passing |

**Files Affected:**
`lib/services/sync_service.dart`, `assets/animations/`, all feature screens, `android/`

**Acceptance Criteria:**
- [ ] All screens maintain 60fps on a mid-range test device
- [ ] Sync completes without data loss after extended offline use
- [ ] All text strings use localization keys, no hardcoded strings
- [ ] Every interactive element meets 56dp minimum touch target
- [ ] Release APK builds and installs without errors

---

## 6. Feature Development Workflow

Every feature, without exception, follows this process.

```
Step 1 — Branch
  git checkout develop
  git pull origin develop
  git checkout -b feature/<feature-name>

Step 2 — Build UI
  Create screen file in lib/features/<feature>/screens/
  Use only shared widgets from lib/shared/
  Apply theme tokens — no hardcoded colors or sizes
  Add audio prompt widget to every interactive screen

Step 3 — Connect State
  Create Riverpod provider in lib/features/<feature>/providers/
  Define the state model
  Wire provider to the screen

Step 4 — Connect Local Storage
  Write SQLite queries in lib/storage/database/app_database.dart
  Verify data persists after hot restart

Step 5 — Connect Backend
  Add Supabase operations to the relevant service
  Wrap all network calls in try-catch
  Ensure offline fallback exists for every network call

Step 6 — Test
  Run through the feature manually on the emulator
  Test with airplane mode enabled
  Complete the Testing Workflow checklist

Step 7 — Analyze
  flutter analyze
  Resolve all issues before proceeding

Step 8 — Commit
  git add .
  git commit -m "feat(<scope>): <description>"

Step 9 — Push and Open PR
  git push origin feature/<feature-name>
  Open Pull Request targeting develop
  Complete the Definition of Done checklist in the PR description

Step 10 — Merge
  Receive reviewer approval
  Squash and merge into develop
  Delete the feature branch
```

> [!IMPORTANT]
> Steps 3 through 5 must always be implemented in this order. UI → Local State → Local Storage → Backend. Never wire up the backend before local storage is working.

---

## 7. Testing Workflow

Every feature must pass this checklist before a Pull Request is opened.

### Functional Testing

- [ ] All screens render without overflow or layout errors
- [ ] All buttons and touch targets respond correctly
- [ ] Navigation between screens follows the defined GoRouter routes
- [ ] Back navigation returns to the correct previous screen

### Offline Testing

- [ ] Enable airplane mode on the emulator
- [ ] Relaunch the app in airplane mode
- [ ] Verify the feature is fully usable without connectivity
- [ ] Disable airplane mode and verify background sync triggers

### Database Testing

- [ ] Data written in the feature is readable after a hot restart
- [ ] Data written in the feature is readable after a cold restart (app killed)
- [ ] No duplicate records are created on repeated actions
- [ ] Deleting a record removes it cleanly from SQLite

### Audio Testing

- [ ] Audio prompt plays on screen load
- [ ] Audio does not play in silent mode unless explicitly expected
- [ ] just_audio player is disposed correctly when leaving the screen
- [ ] TTS reads out all required UI labels

### Accessibility Testing

- [ ] All interactive elements have semantic labels
- [ ] Touch targets are a minimum of 56dp
- [ ] Text contrast ratio meets WCAG AA standards
- [ ] Screen navigates correctly with TalkBack enabled

### Regression Testing

- [ ] Previously passing features still work after this change
- [ ] `flutter analyze` returns zero issues
- [ ] No new warnings introduced

---

## 8. Debugging Workflow

Follow this process in order when encountering an issue.

```
Step 1 — Run Flutter Analyze
  flutter analyze
  Fix every issue listed. Do not skip warnings.

Step 2 — Read the Console
  Read the full error message in the debug console.
  Identify: file name, line number, exception type.

Step 3 — Use Hot Reload / Hot Restart
  Hot Reload (r): UI changes, widget rebuilds.
  Hot Restart (R): State resets, provider re-initialization.
  Full Stop + Run: For platform-level issues or plugin init errors.

Step 4 — Isolate the Crash
  Comment out the suspected block.
  Re-run. If crash disappears, the block is the cause.
  Re-enable line by line to pinpoint.

Step 5 — Verify Local Database State
  Use a SQLite browser to inspect the local database file.
  Confirm expected records exist.
  Check for null values, missing columns, or wrong types.

Step 6 — Verify Supabase State
  Open the Supabase dashboard.
  Inspect the relevant table for the expected record.
  Check Row Level Security policies if data is missing.

Step 7 — Check Provider State
  Add print() or use Flutter DevTools Riverpod inspector.
  Verify the provider is building and exposing the expected state.

Step 8 — Search Closed Issues
  Check if this is a known issue in the repository's GitHub Issues.

Step 9 — Escalate
  If unresolved after all steps, open a GitHub Issue with:
  - Reproduction steps
  - Expected behaviour
  - Actual behaviour
  - Relevant stack trace
```

---

## 9. Code Quality Rules

These rules are enforced at code review. PRs that violate them will be returned.

### Architecture Rules

| Rule | Detail |
|---|---|
| One widget per file | A file named `patient_card.dart` contains only `PatientCard` |
| One responsibility per provider | A provider manages one piece of state |
| Feature isolation | A feature must not import directly from another feature |
| No business logic in widgets | Logic belongs in providers or services |

### Dart & Flutter Rules

| Rule | Detail |
|---|---|
| No hardcoded strings | All user-visible text lives in `app_strings.dart` or localization files |
| No hardcoded colors | All colors reference `AppColors` constants |
| No hardcoded dimensions | All spacing references `AppDimensions` constants |
| No magic numbers | Named constants for all numeric values |
| Prefer `const` constructors | Use `const` wherever the widget is compile-time constant |
| Dispose controllers | All `TextEditingController`, `AnimationController`, and `AudioPlayer` instances must be disposed in `dispose()` |
| Handle nulls explicitly | No `!` force-unwrap without a documented justification comment |

### Naming Rules

| Construct | Convention | Example |
|---|---|---|
| Files | `snake_case.dart` | `patient_card.dart` |
| Classes | `PascalCase` | `PatientCard` |
| Variables & functions | `camelCase` | `patientName` |
| Constants | `camelCase` in a class | `AppColors.primary` |
| Providers | `camelCase` ending in `Provider` | `patientProfileProvider` |

### Import Rules

- Order: Dart SDK → Flutter → Third-party packages → Project imports
- No relative imports outside the same feature folder
- Use package imports (`package:nenil/...`) for cross-folder references

---

## 10. Definition of Done

A feature is considered complete only when every item in this checklist is checked.

### UI & Design

- [ ] All screens match the Figma design specification
- [ ] Material Design 3 tokens applied throughout
- [ ] No hardcoded colors, strings, or dimensions
- [ ] Large touch targets (56dp minimum) on all interactive elements
- [ ] High contrast UI verified on the emulator

### Functionality

- [ ] Feature works as specified in the sprint deliverables
- [ ] All user interactions produce the correct outcomes
- [ ] No unhandled exceptions occur during normal use

### Offline & Data

- [ ] Feature is fully functional in airplane mode
- [ ] All data persists after app restart
- [ ] Supabase sync operates correctly when back online
- [ ] No data loss occurs during offline-to-online transition

### Audio & Accessibility

- [ ] Audio prompt is present on every interactive screen
- [ ] TTS reads all required labels
- [ ] Semantic labels applied to all interactive widgets
- [ ] Feature navigates correctly with TalkBack enabled

### Code Quality

- [ ] `flutter analyze` returns zero issues
- [ ] No `TODO` or `FIXME` comments left in production code
- [ ] No commented-out code blocks
- [ ] All new files follow naming conventions
- [ ] No duplicate code — shared logic extracted to services or shared widgets

### Testing & Review

- [ ] Testing Workflow checklist completed and passed
- [ ] Committed with a correctly formatted commit message
- [ ] Pull Request opened against `develop`
- [ ] PR reviewed and approved by at least one team member

---

## 11. Release Workflow

### Versioning

Nenil follows Semantic Versioning: `MAJOR.MINOR.PATCH+BUILD`

| Segment | When to increment |
|---|---|
| `MAJOR` | Breaking change or major product milestone |
| `MINOR` | New feature shipped to production |
| `PATCH` | Bug fix or minor update |
| `BUILD` | Auto-incremented on every release build |

Version is defined in `pubspec.yaml`:
```yaml
version: 1.0.0+1
```

### Release Process

```
Step 1 — Freeze develop
  No new feature branches merged to develop during release freeze.
  Only bug fixes targeting the release are allowed.

Step 2 — Final Quality Pass
  flutter analyze          (zero issues required)
  flutter test             (all tests must pass)
  Accessibility audit      (manual, on physical device)
  Offline testing          (full feature regression in airplane mode)

Step 3 — Bump Version
  Update version in pubspec.yaml
  Commit: chore(release): bump version to 1.0.0+1

Step 4 — Merge develop to main
  git checkout main
  git merge develop
  git tag v1.0.0
  git push origin main --tags

Step 5 — Generate Release APK
  flutter build apk --release
  Output: build/app/outputs/flutter-apk/app-release.apk

Step 6 — Internal Testing
  Distribute APK via Firebase App Distribution or direct install
  Test on minimum two physical Android devices
  Document any issues found

Step 7 — GitHub Release
  Create a GitHub Release from the tag
  Attach the signed APK
  Write release notes documenting all changes since previous release

Step 8 — Post-Release
  Checkout develop
  Continue next sprint
```

> [!CAUTION]
> Never build or publish from the `develop` branch. All release builds come from `main` only.

### APK Signing

Before generating a release build, ensure the keystore is configured in `android/key.properties`. This file must never be committed to the repository.

```properties
storePassword=<password>
keyPassword=<password>
keyAlias=nenil
storeFile=../nenil-release-key.jks
```

---

<div align="center">

**Nenil Engineering Team** · Smart India Hackathon 2026

*This document is version-controlled. All updates must be committed to the repository and reviewed by the Engineering Lead.*

</div>
