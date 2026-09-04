/// CaregiverModel — Represents a caregiver linked to a patient profile.
class CaregiverModel {
  final String id;
  final String name;
  final String phone;
  final String relationship;
  final String pinHash;
  final String? patientId;
  final String createdAt;

  const CaregiverModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.relationship,
    required this.pinHash,
    this.patientId,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'relationship': relationship,
      'pin_hash': pinHash,
      'patient_id': patientId,
      'created_at': createdAt,
    };
  }

  factory CaregiverModel.fromMap(Map<String, dynamic> map) {
    return CaregiverModel(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      relationship: map['relationship'] as String,
      pinHash: map['pin_hash'] as String,
      patientId: map['patient_id'] as String?,
      createdAt: map['created_at'] as String,
    );
  }
}
