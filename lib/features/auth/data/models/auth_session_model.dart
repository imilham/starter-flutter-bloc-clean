import 'package:starter/features/auth/domain/entities/entities.dart';

/// Data model for AuthSession with JSON serialization.
///
/// This extends the domain entity and adds serialization logic.
class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.userId,
    required super.accessToken,
    required super.createdAt,
    super.isEmailVerified,
    super.isProfileCompleted,
  });

  /// Creates an AuthSessionModel from JSON.
  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      userId: (json['id'] ?? '') as String,
      accessToken: (json['access_token'] ?? '') as String,
      createdAt: DateTime.tryParse((json['created_at'] ?? '') as String) ?? DateTime.now(),
      isEmailVerified: (json['is_email_verified'] ?? false) as bool,
      isProfileCompleted: (json['is_profile_completed'] ?? false) as bool,
    );
  }

  /// Creates a model from a domain entity.
  factory AuthSessionModel.fromEntity(AuthSession entity) {
    return AuthSessionModel(
      userId: entity.userId,
      accessToken: entity.accessToken,
      createdAt: entity.createdAt,
      isEmailVerified: entity.isEmailVerified,
      isProfileCompleted: entity.isProfileCompleted,
    );
  }

  /// Converts the model to JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'access_token': accessToken,
      'created_at': createdAt.toIso8601String(),
      'is_email_verified': isEmailVerified,
      'is_profile_completed': isProfileCompleted,
    };
  }
}
