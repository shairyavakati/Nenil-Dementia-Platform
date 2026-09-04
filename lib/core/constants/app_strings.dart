/// AppStrings — Text strings and localization key placeholders.
abstract class AppStrings {
  static const String appName = 'Nenil';
  static const String tagline = 'Multilingual cognitive gaming and memory assistance platform';

  // Screen Titles
  static const String titleLanguage = 'Choose Language';
  static const String titleCaregiverAuth = 'Caregiver Login';
  static const String titlePatientProfile = 'Patient Profile';
  static const String titleStageSelection = 'Dementia Stage';
  static const String titleHome = "Today's Cognitive Journey";
  static const String titleDashboard = 'Caregiver Companion';
  static const String titleEmergency = 'Emergency Assistance';

  // Game Names
  static const String gameDailyRoutine = 'My Daily Routine';
  static const String gameFindThings = 'Find My Things';
  static const String gameFamilyFaces = 'Family Faces & Stories';
  static const String gameMusicMemory = 'Music Memory Journey';
  static const String gameEmotionMatch = 'Emotion Match';

  // Common UI Actions
  static const String btnContinue = 'Continue';
  static const String btnBack = 'Back';
  static const String btnListen = 'Listen Prompt';
  static const String btnEmergency = 'SOS Emergency';
  static const String btnComplete = 'Complete Activity';

  // Languages Supported
  static const List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'as', 'name': 'অসমীয়া (Assamese)'},
    {'code': 'bn', 'name': 'বাংলা (Bengali)'},
    {'code': 'hi', 'name': 'हिंदी (Hindi)'},
    {'code': 'mni', 'name': 'মৈতৈলোন্ (Meitei)'},
  ];
}
