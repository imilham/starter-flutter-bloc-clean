import 'package:equatable/equatable.dart';

/// Entity representing data collected during onboarding flow.
class OnboardingData extends Equatable {
  const OnboardingData({
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
  });

  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;

  OnboardingData copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
  }) {
    return OnboardingData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, phoneNumber, dateOfBirth];
}
