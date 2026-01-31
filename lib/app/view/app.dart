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
  final AppStates _appStates = GetIt.instance<AppStates>();
  final ThemeServiceProvider _themeServiceProvider = GetIt.instance<ThemeServiceProvider>();

  /// A stream subscription for handling ProfileState changes.

  @override
  void initState() {
    /// Listens to changes in the theme mode provided by the [_themeServiceProvider].
    /// If the theme mode is set to [ThemeMode.dark], it sets the system UI overlay style to dark.
    /// Otherwise, it sets the system UI overlay style to the default.
    _themeServiceProvider.addListener(() {
      if (_themeServiceProvider.themeMode == ThemeMode.dark) {
        ThemeServiceProvider.setSystemUIOverlayStyle(isDark: true);
      } else {
        ThemeServiceProvider.setSystemUIOverlayStyle();
      }
    });
    
    // Trigger initial auth check
    GetIt.instance<AuthBloc>().add(const AuthCheckRequested());
    
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GetIt.instance<AppSettings>()),
        ChangeNotifierProvider.value(value: GetIt.instance<AppStates>()),
        ChangeNotifierProvider(create: (_) => GetIt.instance<ThemeServiceProvider>()),
        BlocProvider.value(value: GetIt.instance<AuthBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthAuthenticated) {
            _appStates.currentSession = state.session;
            _appStates.isInitialized = true;
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

            _appStates.currentSession = null;
            // App is still initialized, just not logged in.
            // Keeping this true prevents redirecting to Splash page.
            _appStates.isInitialized = true;
          }
        },
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              onGenerateTitle: (context) => context.l10n.appName,
              theme: context.watch<ThemeServiceProvider>().lightTheme,
              darkTheme: context.watch<ThemeServiceProvider>().darkTheme,
              themeMode: context.watch<ThemeServiceProvider>().themeMode,
              routerConfig: GetIt.instance<AppRouter>().goRouter,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) => OverlayUtility(child: child),
              // showPerformanceOverlay: true,
            );
          },
        ),
      ),
    );
  }
}
