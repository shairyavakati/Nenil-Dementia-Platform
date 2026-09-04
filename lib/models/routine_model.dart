/// RoutineModel — Represents a daily activity routine item.
class RoutineModel {
  final String id;
  final String patientId;
  final String title;
  final String timeOfDay; // 'morning', 'afternoon', 'evening'
  final String? audioPromptPath;
  final String? iconName;
  final bool isCompleted;

  const RoutineModel({
    required this.id,
    required this.patientId,
    required this.title,
    required this.timeOfDay,
    this.audioPromptPath,
    this.iconName,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_id': patientId,
      'title': title,
      'time_of_day': timeOfDay,
      'audio_prompt_path': audioPromptPath,
      'icon_name': iconName,
      'is_completed': isCompleted ? 1 : 0,
    };
  }

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
      id: map['id'] as String,
      patientId: map['patient_id'] as String,
      title: map['title'] as String,
      timeOfDay: map['time_of_day'] as String,
      audioPromptPath: map['audio_prompt_path'] as String?,
      iconName: map['icon_name'] as String?,
      isCompleted: (map['is_completed'] as int? ?? 0) == 1,
    );
  }
}
