import 'package:mocktail/mocktail.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockRegisterUseCase extends Mock implements RegisterUseCase {}
class MockResendVerificationCodeUseCase extends Mock implements ResendVerificationCodeUseCase {}
class MockVerifyEmailUseCase extends Mock implements VerifyEmailUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}
class MockGetStoredSessionUseCase extends Mock implements GetStoredSessionUseCase {}
class MockRefreshSessionUseCase extends Mock implements RefreshSessionUseCase {}

class MockAppSettings extends Mock implements AppSettings {}

// Entities for testing
// Note: User entity might be in different package, mocking common usage if needed
// final mockUser = User(...); 

final mockAuthSession = AuthSession(
  userId: 'user_123',
  accessToken: 'token_123',
  createdAt: DateTime.now(),
  isEmailVerified: true,
  isProfileCompleted: true,
);
