import 'package:equatable/equatable.dart';

/// Represents an authenticated user session.
///
/// This is a domain entity - it contains only business data,
/// no serialization logic.
class AuthSession extends Equatable {
  const AuthSession({
    required this.userId,
    required this.accessToken,
    required this.createdAt,
    this.isEmailVerified = false,
    this.isProfileCompleted = false,
  });

  final String userId;
  final String accessToken;
  final DateTime createdAt;
  final bool isEmailVerified;
  final bool isProfileCompleted;

  /// Creates a copy with updated values.
  AuthSession copyWith({
    String? userId,
    String? accessToken,
    DateTime? createdAt,
    bool? isEmailVerified,
    bool? isProfileCompleted,
  }) {
    return AuthSession(
      userId: userId ?? this.userId,
      accessToken: accessToken ?? this.accessToken,
      createdAt: createdAt ?? this.createdAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        accessToken,
        createdAt,
        isEmailVerified,
        isProfileCompleted,
      ];
}
