import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/auth/auth.dart';

import '../mocks/auth_mocks.dart';

void main() {
  late AuthBloc authBloc;
  late MockGetStoredSessionUseCase mockGetStoredSessionUseCase;
  late MockLogoutUseCase mockLogoutUseCase;
  late MockRefreshSessionUseCase mockRefreshSessionUseCase;

  setUp(() {
    mockGetStoredSessionUseCase = MockGetStoredSessionUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    mockRefreshSessionUseCase = MockRefreshSessionUseCase();

    authBloc = AuthBloc(
      getStoredSessionUseCase: mockGetStoredSessionUseCase,
      logoutUseCase: mockLogoutUseCase,
      refreshSessionUseCase: mockRefreshSessionUseCase,
    );
  });

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(const LogoutParams(token: ''));
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(authBloc.state, const AuthInitial());
    });

    group('AuthCheckRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when session exists',
        build: () {
          when(() => mockGetStoredSessionUseCase(any()))
              .thenAnswer((_) async => Result.success(mockAuthSession));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [
          const AuthLoading(),
          AuthAuthenticated(mockAuthSession),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when session is null',
        build: () {
          when(() => mockGetStoredSessionUseCase(any()))
              .thenAnswer((_) async => const Result.success(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [
          const AuthLoading(),
          const AuthUnauthenticated(),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when check fails',
        build: () {
          when(() => mockGetStoredSessionUseCase(any()))
              .thenAnswer((_) async => const Result.failure(CacheFailure()));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthCheckRequested()),
        expect: () => [
          const AuthLoading(),
          const AuthUnauthenticated(),
        ],
      );
    });

    group('AuthLogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthUnauthenticated] when logout is requested',
        seed: () => AuthAuthenticated(mockUserSession), // We need a session to logout
        build: () {
          when(() => mockLogoutUseCase(any()))
              .thenAnswer((_) async => const Result.success(null));
          return authBloc;
        },
        act: (bloc) => bloc.add(const AuthLogoutRequested()),
        expect: () => [
          const AuthUnauthenticated(),
        ],
      );
    });
  });
}

final mockUserSession = AuthSession(
  userId: '123',
  accessToken: 'token',
  createdAt: DateTime.now(),
  isEmailVerified: true,
  isProfileCompleted: true,
);
