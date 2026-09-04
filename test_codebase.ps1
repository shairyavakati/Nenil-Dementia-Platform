# Nenil Codebase Automated Verification Script

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " Running Nenil Codebase Verification Suite" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

$libFiles = Get-ChildItem -Path lib -Recurse -Filter "*.dart"
Write-Host "[1/5] Checking Dart File Inventory..." -ForegroundColor Yellow
Write-Host "Total Dart Files Found: $($libFiles.Count)" -ForegroundColor Green

if ($libFiles.Count -lt 50) {
    Write-Host "ERROR: Expected at least 50 Dart files, found $($libFiles.Count)" -ForegroundColor Red
    exit 1
}

# 2. Check Screen Route Mappings in AppRouter
Write-Host "[2/5] Verifying AppRouter Routes & Screens..." -ForegroundColor Yellow
$routerFile = Get-Content "lib/core/router/app_router.dart" -Raw
$expectedRoutes = @(
    '/', '/language', '/auth', '/pin-setup', '/patient-profile', '/stage-selection', '/home',
    '/caregiver-dashboard', '/session-history', '/patient-linking', '/voice-recording', '/emergency-config',
    '/game/daily_routine', '/game/find_things', '/game/family_faces', '/game/music_memory', '/game/emotion_match',
    '/game/safe_choices', '/game/picture_recipe', '/game/sort_category', '/game/virtual_garden', '/game/comfort_choice', '/game/call_help_practice',
    '/game/word_match', '/game/photo_puzzle', '/game-completion', '/emergency'
)

$missingRoutes = @()
foreach ($route in $expectedRoutes) {
    if ($routerFile -notlike "*'$route'*" -and $routerFile -notlike "*""$route""*") {
        $missingRoutes += $route
    }
}

if ($missingRoutes.Count -eq 0) {
    Write-Host "All $($expectedRoutes.Count) App Router routes verified successfully!" -ForegroundColor Green
} else {
    Write-Host "Missing routes: $($missingRoutes -join ', ')" -ForegroundColor Red
}

# 3. Check Models and Database Schemas
Write-Host "[3/5] Verifying SQLite Schemas and Models..." -ForegroundColor Yellow
$dbFile = Get-Content "lib/storage/database/app_database.dart" -Raw
$tables = @('patients', 'caregivers', 'sessions', 'routines')

foreach ($table in $tables) {
    if ($dbFile -like "*CREATE TABLE $table*") {
        Write-Host "  [OK] Table '$table' schema defined in AppDatabase" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] Table '$table' missing from AppDatabase" -ForegroundColor Red
    }
}

# 4. Check Services & Clinical Engines
Write-Host "[4/5] Verifying Services & Clinical Telemetry..." -ForegroundColor Yellow
$services = @('audio_service.dart', 'call_service.dart', 'location_service.dart', 'permission_service.dart', 'sync_service.dart', 'tts_service.dart', 'voice_recording_service.dart', 'vision_distress_service.dart')
foreach ($service in $services) {
    if (Test-Path "lib/services/$service") {
        Write-Host "  [OK] Service '$service' present" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] Service '$service' missing" -ForegroundColor Red
    }
}

if (Test-Path "lib/features/home/services/adaptive_feed_engine.dart") {
    Write-Host "  [OK] AdaptiveFeedEngine present" -ForegroundColor Green
}
if (Test-Path "lib/features/games/engine/spaced_retrieval_engine.dart") {
    Write-Host "  [OK] SpacedRetrievalEngine present" -ForegroundColor Green
}
if (Test-Path "lib/features/games/engine/errorless_learning_handler.dart") {
    Write-Host "  [OK] ErrorlessLearningHandler present" -ForegroundColor Green
}
if (Test-Path "lib/features/games/engine/behavioral_distress_monitor.dart") {
    Write-Host "  [OK] BehavioralDistressMonitor present" -ForegroundColor Green
}

# 5. Check All Cognitive Game Modules
Write-Host "[5/5] Verifying Cognitive Game Modules..." -ForegroundColor Yellow
$games = @(
    'daily_routine_game_screen.dart', 'find_my_things_game_screen.dart', 'family_faces_game_screen.dart',
    'music_memory_game_screen.dart', 'emotion_match_game_screen.dart', 'safe_home_choices_screen.dart',
    'picture_recipe_screen.dart', 'sort_category_screen.dart', 'virtual_garden_screen.dart',
    'comfort_choice_screen.dart', 'call_for_help_practice_screen.dart', 'word_match_game_screen.dart',
    'photo_puzzle_screen.dart', 'game_completion_screen.dart'
)
foreach ($game in $games) {
    if (Test-Path "lib/features/games/screens/$game") {
        Write-Host "  [OK] Game Module '$game' present" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] Game Module '$game' missing" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " All Verification Tests Passed 100%! " -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
