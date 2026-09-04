/// PatientModel — Represents an elderly dementia patient profile.
class PatientModel {
  final String id;
  final String name;
  final String stage; // 'mild', 'moderate', 'severe'
  final String preferredLanguage;
  final String? avatarUrl;
  final String createdAt;

  const PatientModel({
    required this.id,
    required this.name,
    required this.stage,
    required this.preferredLanguage,
    this.avatarUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'stage': stage,
      'preferred_language': preferredLanguage,
      'avatar_url': avatarUrl,
      'created_at': createdAt,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as String,
      name: map['name'] as String,
      stage: map['stage'] as String? ?? 'mild',
      preferredLanguage: map['preferred_language'] as String? ?? 'en',
      avatarUrl: map['avatar_url'] as String?,
      createdAt: map['created_at'] as String,
    );
  }
}
