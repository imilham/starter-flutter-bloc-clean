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
  /// 
  /// API Response Fields (from backend):
  /// - `id` → userId
  /// - `access_token` → accessToken
  /// - `created_at` → createdAt
  /// - `is_verified` → isEmailVerified
  /// - `profile_completed` → isProfileCompleted
  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      userId: (json['id'] ?? json['user_id'] ?? '') as String,
      accessToken: (json['access_token'] ?? '') as String,
      createdAt: DateTime.tryParse((json['created_at'] ?? '') as String) ?? DateTime.now(),
      isEmailVerified: (json['is_verified'] ?? json['is_email_verified'] ?? false) as bool,
      isProfileCompleted: (json['profile_completed'] ?? json['is_profile_completed'] ?? false) as bool,
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
  /// Uses the same field names as the API for consistency.
  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'access_token': accessToken,
      'created_at': createdAt.toIso8601String(),
      'is_verified': isEmailVerified,
      'profile_completed': isProfileCompleted,
    };
  }
}
