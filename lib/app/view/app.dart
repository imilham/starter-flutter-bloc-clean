import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/app.dart';
import 'package:starter/features/auth/auth.dart';

import 'package:starter/l10n/gen/app_localizations.dart';
import 'package:starter/utils/utils.dart';

class StarterApp extends StatefulWidget {
  const StarterApp({super.key});

  @override
  State<StarterApp> createState() => _StarterAppState();
}

class _StarterAppState extends State<StarterApp> {
  @override
  void initState() {
    // Trigger initial auth check
    GetIt.instance<AuthBloc>().add(const AuthCheckRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: GetIt.instance<AppCubit>()),
        BlocProvider.value(value: GetIt.instance<ThemeCubit>()),
        BlocProvider.value(value: GetIt.instance<AuthBloc>()),
        if (GetIt.instance<AppSettings>().showOfflineOverlay) BlocProvider.value(value: GetIt.instance<ConnectivityCubit>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          final appCubit = GetIt.instance<AppCubit>();
          if (state is AuthAuthenticated) {
            appCubit
              ..setSession(state.session)
              ..setInitialized(value: true);
          } else if (state is AuthUnauthenticated) {
            if (state.message != null) {
              final router = GetIt.instance<AppRouter>();
              // Use the root navigator context to ensure we can show dialogs
              // even if the listener context doesn't have a Navigator ancestor
              final navContext = router.navigatorKey.currentContext;

              if (navContext != null && navContext.mounted) {
                navContext.showErrorSnackBar(state.message!);
              }
            }

            appCubit
              ..setSession(null)
              // App is still initialized, just not logged in.
              // Keeping this true prevents redirecting to Splash page.
              ..setInitialized(value: true);
          }
        },
        child: Builder(
          builder: (context) {
            return BlocListener<ThemeCubit, ThemeState>(
              listener: (context, themeState) {
                ThemeService.setSystemUIOverlayStyle(isDark: themeState.isDark);
              },
              child: BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, themeState) {
                  final themeCubit = context.read<ThemeCubit>();
                  return ScreenUtilInit(
                    designSize: const Size(375, 812),
                    minTextAdapt: true,
                    splitScreenMode: true,
                    builder: (context, child) => MaterialApp.router(
                      onGenerateTitle: (context) => context.l10n.appName,
                      theme: themeCubit.lightTheme,
                      darkTheme: themeCubit.darkTheme,
                      themeMode: themeCubit.themeMode,
                      routerConfig: GetIt.instance<AppRouter>().goRouter,
                      localizationsDelegates: AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                      builder: (context, child) => ConnectivityOverlay(
                        child: OverlayUtility(child: child),
                      ),
                      // showPerformanceOverlay: true,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
