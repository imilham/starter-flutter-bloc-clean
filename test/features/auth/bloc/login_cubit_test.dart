import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter/core/core.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/utils/utils.dart';

import '../mocks/auth_mocks.dart';

void main() {
  late LoginCubit loginCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockAppSettings mockAppSettings;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockAppSettings = MockAppSettings();

    // Setup GetIt for AppSettings
    final getIt = GetIt.instance;
    if (getIt.isRegistered<AppSettings>()) {
      getIt.unregister<AppSettings>();
    }
    getIt.registerSingleton<AppSettings>(mockAppSettings);

    // Stub AppSettings methods
    when(() => mockAppSettings.getDeviceId()).thenAnswer((_) async => 'device_id_123');
    when(() => mockAppSettings.getDevicePlatform()).thenReturn('android');

    loginCubit = LoginCubit(loginUseCase: mockLoginUseCase);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  setUpAll(() {
    registerFallbackValue(
      const LoginParams(
        email: 'test@example.com',
        password: 'password',
        deviceId: 'id',
        deviceType: 'type',
      ),
    );
  });

  group('LoginCubit', () {
    test('initial state is LoginInitial', () {
      expect(loginCubit.state, const LoginInitial());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login succeeds',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Result.success(mockAuthSession));
        return loginCubit;
      },
      act: (cubit) => cubit.login(email: 'test@example.com', password: 'password'),
      expect: () => [
        const LoginLoading(),
        LoginSuccess(mockAuthSession),
      ],
      verify: (_) {
        verify(() => mockAppSettings.getDeviceId()).called(1);
        verify(() => mockAppSettings.getDevicePlatform()).called(1);
        verify(() => mockLoginUseCase(any())).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginFailure] when login fails',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => const Result.failure(ServerFailure('Invalid credentials')));
        return loginCubit;
      },
      act: (cubit) => cubit.login(email: 'test@example.com', password: 'password'),
      expect: () => [
        const LoginLoading(),
        const LoginFailure('Invalid credentials'),
      ],
    );
  });
}
