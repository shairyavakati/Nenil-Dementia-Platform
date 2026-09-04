# Nenil — SIH 2026 Hackathon Master Demo Script & Presentation Blueprint

> **Problem Statement:** AI-Based Cognitive Gaming and Memory Assistance Platform for Elderly Dementia Patients in North Eastern Region (NER)
> **Status:** 100% Hackathon Demo Ready · **PIN Code:** `1234` · **Demo Profile:** Aideo Boro (Assam, Mild Stage)

---

## ⏱️ 5-Minute Live Judge Presentation Walkthrough

### Minute 0:00 – 1:00 | Problem & Regional Challenge
- **Opening Pitch:** *"Judges, in North East India, over 800,000 elderly individuals live with cognitive decline across 200+ distinct languages. Standard brain-training apps rely on English, high scores, and speed timers — which cause severe confusion and anxiety in dementia patients."*
- **The Solution:** **Nenil** — A voice-first, multilingual, offline-capable cognitive gaming platform designed specifically for neurodegenerative care.

---

### Minute 1:00 – 2:15 | Reddit-Style Adaptive Feed & Stage Customization
- **Action:** Open App to **[PatientHomeScreen](file:///d:/Nenil-Dementia-Platform/lib/features/home/screens/patient_home_screen.dart)**.
- **Showcase:**
  1. Spoken audio greeting in Assamese/English (*"Good morning, Aideo Boro"*).
  2. **Reddit-Style Activity Feed**: Point out how activities are dynamically ranked for Morning/Afternoon/Evening based on the patient's stage and past mood.
  3. **Stage Adaptation**: Show how switching profile from *Mild* to *Severe* simplifies the UI from 4 choice cards to 1–2 large visual comfort cards.

---

### Minute 2:15 – 3:30 | Cognitive Gameplay & Bio-Behavioral Telemetry
- **Action:** Launch **[FindMyThingsGameScreen](file:///d:/Nenil-Dementia-Platform/lib/features/games/screens/find_my_things_game_screen.dart)** or **[WordMatchGameScreen](file:///d:/Nenil-Dementia-Platform/lib/features/games/screens/word_match_game_screen.dart)**.
- **Showcase:**
  1. **Spaced Retrieval**: Practicing fixed object locations (glasses, keys, walker).
  2. **Errorless Learning**: Demonstrate tapping a non-target card — show how the app highlights the correct choice with gentle spoken guidance, with **zero error buzzers or failure screens**.
  3. **Celebration Overlay**: Finish activity -> Show elastic star particles and congratulatory spoken feedback (*"Wonderful Job!"*).
  4. **Bio-Behavioral Telemetry**: Explain how `BehavioralDistressMonitor` tracks tap latency and eye-rubbing gesture cues to automatically transition fatigue into calming regional music.

---

### Minute 3:30 – 4:15 | Safety Layer & Emergency SOS
- **Action:** Tap floating **[SOS Button](file:///d:/Nenil-Dementia-Platform/lib/features/emergency/screens/emergency_screen.dart)** on Home Screen.
- **Showcase:**
  1. **5-Second Safety Countdown Timer**: Prevents accidental false triggers. Tap "Cancel SOS" to show return to home.
  2. **Active Emergency Mode**: Let timer expire -> Shows direct caregiver call button, spoken reassurance, and live GPS location coordinates (`26.1445° N, 91.7362° E`).

---

### Minute 4:15 – 5:00 | Caregiver Companion Hub & Offline Cloud Sync
- **Action:** Open **[CaregiverDashboardScreen](file:///d:/Nenil-Dementia-Platform/lib/features/caregiver/screens/caregiver_dashboard_screen.dart)** using PIN `1234`.
- **Showcase:**
  1. **PIN Security**: Protects configuration and patient settings.
  2. **Analytics Panel**: Real-time weekly session totals and favorite game metrics.
  3. **Voice Recording Service**: Caregiver records custom audio captions.
  4. **Offline Cloud Sync**: Tap "Sync Pending Data" -> Demonstrates pushing offline SQLite logs to remote Supabase DB.

---

## 🛠️ SIH 2026 Hackathon Demo Checklist

- [x] **Zero Internet Needed** — App works 100% in Airplane Mode.
- [x] **Pre-Seeded Data** — Patient profile, sample sessions, and routines pre-loaded.
- [x] **Caregiver PIN** — Set to `1234` for rapid judge demonstration.
- [x] **Clean Analyzer** — Zero warnings or syntax errors.
- [x] **Emergency SOS** — 5s safety countdown timer & GPS coordinates functional.
