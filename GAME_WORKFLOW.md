# Nenil — Clinical Game Architecture & Engineering Blueprint

> **Version:** 1.0.0 · **Status:** Active · **Lead Architect:** Senior Cognitive Researcher & Game Director
>
> This document is the single source of truth for clinical game mechanics, stage adaptation rules, spaced retrieval protocols, errorless learning guidelines, and the Reddit-style adaptive personalization feed engine in **Nenil**.

---

## 1. Clinical Game Philosophy

Nenil is designed specifically for neurodegenerative dementia care. Traditional "brain-training" apps rely on high scores, speed timers, performance leaderboards, and failure feedback — all of which cause confusion, anxiety, and distress in individuals with cognitive decline.

Nenil shifts the paradigm:

1. **One Real-Life Skill at a Time** — Train practical daily survival and identity skills ("Where do my glasses go?", "Who do I call for help?", "What do I use before walking?").
2. **Spaced Retrieval** — Practice key facts/actions at expanding time intervals (1 min, 5 min, 15 min, 1 hr, 1 day).
3. **Errorless Learning** — Prevent repeated incorrect responses. Immediately show and gently guide the patient to the correct choice.
4. **Reminiscence & Regional Identity** — Utilize preserved long-term memories through familiar North East Region (NER) cultural music, local landmark imagery, and caregiver voice recordings.
5. **Zero Failure Feedback** — No error buzzers, red crosses, or time limits. Every attempt is greeted with positive visual and auditory encouragement.

---

## 2. Dementia Stage Adaptation Matrix

| Stage | Session Length | Answer Choices | Cueing & Guidance Level | Core Game Modules |
|---|---|---|---|---|
| **Mild (Starting)** | 20–30 min | 2–4 cards | Visual & voice prompts on request | Multi-step routines, object-location, category sorting, safe home choices, local memory walk |
| **Moderate (Middle)** | 15–25 min | 1–2 cards | Immediate automatic voice & visual guidance | Short routines, 1-step task, family photos, music memory, picture recipe, emotion match |
| **Severe (Final)** | 5–15 min | 1–2 large cards | Continuous caregiver co-play & sensory audio | Music memory journey, comfort choices, emotion cards, sensory relaxation |

---

## 3. Reddit-Style Adaptive Personalization Engine

The **Adaptive Feed Engine** computes dynamic priority scores for all game modules after every session, rendering a customized home feed similar to social media content discovery:

$$\text{PriorityScore} = \text{BaseStageWeight} + \text{InterestMatchBonus} + \text{TimeOfDayBonus} + \text{EngagementHistoryScore} - \text{SkippingPenalty}$$

### Feed Recommendation Rules:
- **Morning Feed (06:00 - 12:00)**: Prioritizes prospective memory routines (`My Daily Routine`, `Virtual Garden`, `Call for Help Practice`).
- **Afternoon Feed (12:00 - 17:00)**: Prioritizes active cognitive stimulation (`Find My Things`, `Picture Recipe Steps`, `Category Sorting`).
- **Evening Feed (17:00 - 22:00)**: Prioritizes calming reminiscence (`Music Memory Journey`, `Family Faces & Stories`, `Comfort Choice Game`).

---

## 4. Master 15 Game Module Specifications

### Module 1: My Daily Routine
- **Clinical Target:** Prospective memory and daily functional habits.
- **Mechanics:** Arrange 3–5 sequential visual cards (e.g., Morning tea → Brush teeth → Breakfast → Walk).
- **Voice Guidance:** Spoken description of each routine step in selected NER language.

### Module 2: Find My Things
- **Clinical Target:** Object-location memory association.
- **Mechanics:** Show personal item (reading glasses, walker, keys) and ask patient to tap fixed home location.

### Module 3: Family Faces & Stories
- **Clinical Target:** Long-term identity and social recognition.
- **Mechanics:** Match caregiver-uploaded family photos with names/relations; plays caregiver voice caption.

### Module 4: Music Memory Journey
- **Clinical Target:** Emotional memory, comfort, and nostalgia.
- **Mechanics:** Play curated NER folk tunes or caregiver audio tracks with gentle play/pause controls.

### Module 5: Emotion Match
- **Clinical Target:** Non-verbal communication and emotional expression.
- **Mechanics:** Match facial expression illustrations (happy, calm, tired, hungry) with context cues.

### Module 6: Safe Home Choices
- **Clinical Target:** Executive function and safety awareness (Mild stage only).
- **Mechanics:** Select safer option between 2 scenarios (e.g. use walker vs walk without support, turn off stove).

### Module 7: Picture Recipe Steps
- **Clinical Target:** Procedural memory and step sequencing.
- **Mechanics:** Order 3–4 visual cards for tea making, watering plants, or folding clothes.

### Module 8: Sort by Category
- **Clinical Target:** Semantic categorization and fine motor interaction.
- **Mechanics:** Drag or tap images into categories (Fruits, Kitchen Items, Tools, Temple/Church/Mosque Items).

### Module 9: Virtual Garden / Home Care
- **Clinical Target:** Purposeful daily engagement and calm routine.
- **Mechanics:** Single-tap actions to water plants, arrange flowers, or feed virtual garden birds.

### Module 10: Move With Music
- **Clinical Target:** Seated physical activity and rhythmic motor coordination.
- **Mechanics:** Seated arm raises, rhythmic marching, and clapping along with NER regional folk music.

### Module 11: Memory Walk / Local Places
- **Clinical Target:** Spatial orientation, local reminiscence, and conversation.
- **Mechanics:** Explore photos of NER landmarks (Guwahati, Shillong peak, Loktak lake, local markets, regional festivals).

### Module 12: Comfort Choice Game
- **Clinical Target:** Preserving personal autonomy for Moderate & Severe stages.
- **Mechanics:** Choose between 2 large comfort cards (Warm tea vs Water, Soft shawl vs Blanket, Music vs Quiet).

### Module 13: Call for Help Practice
- **Clinical Target:** Spaced-retrieval safety training.
- **Mechanics:** Repeatedly practice tapping the red emergency SOS button to reinforce emergency habits.

### Module 14: Voice-Guided Object Hunt
- **Clinical Target:** Supervised indoor attention and mobility (Mild stage only).
- **Mechanics:** Audio prompt guides patient to find physical object in room with caregiver confirmation.

### Module 15: Caregiver Insights & Feed Adaptation
- **Clinical Target:** Caregiver analytics and behavioral trend tracking.
- **Mechanics:** Logs completion rate, mood ratings, cueing counts, and automatically adapts feed recommendations.

---

## 5. Clinical Safety & Ethical Mandate

- **Non-Diagnostic** — Platform is a cognitive support and wellbeing tool, not a medical or diagnostic device.
- **No Safety Guarantee** — Game success must never be used as clinical proof of real-world unsupervised safety (e.g. cooking, driving, walking outside alone).
- **Caregiver Control** — Caregivers retain absolute authority to pause, customize, or disable any activity that causes distress.
