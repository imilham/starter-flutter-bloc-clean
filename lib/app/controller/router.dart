import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/app.dart';
import 'package:starter/bootstrap.dart';
import 'package:starter/features/auth/auth.dart';
import 'package:starter/features/dev/dev.dart';
import 'package:starter/features/home/home.dart';
import 'package:starter/features/more/more.dart';
import 'package:starter/features/notification/notification.dart';
import 'package:starter/features/onboarding/onboarding.dart';
import 'package:starter/features/profile/profile.dart';
import 'package:starter/utils/utils.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

enum RouterAuthState {
  notInitialized,
  notLoggedIn,
  notVerified,
  notCompleted,
  authenticated,
}

class AppRouter {
  AppRouter();

  final AppCubit _appCubit = getIt<AppCubit>();
  final RouterNotifier _routerNotifier = getIt<RouterNotifier>();

  GoRouter get goRouter => _goRouter;
  GlobalKey<NavigatorState> get navigatorKey => _rootNavigatorKey;

  late final GoRouter _goRouter = GoRouter(
    /// Refresh the router when the app state changes.
    refreshListenable: _routerNotifier,
    initialLocation: '$homeRoutePrefix/${Pages.home.toPath(isSubRoute: true)}',
    navigatorKey: _rootNavigatorKey,
    /// Enable debug logging for diagnostics.
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Pages.splash.toPath(),
        name: Pages.splash.toPathName(),
        pageBuilder: (context, state) => const MaterialPage(child: SplashPage()),
      ),
      GoRoute(
        path: Pages.intro.toPath(),
        name: Pages.intro.toPathName(),
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const IntroPage(),
        ),
        routes: [
          GoRoute(
            path: Pages.signIn.toPath(isSubRoute: true),
            name: Pages.signIn.toPathName(),
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const SignInPage(),
            ),
            routes: [
              GoRoute(
                path: Pages.forgotPassword.toPath(isSubRoute: true),
                name: Pages.forgotPassword.toPathName(),
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const ForgotPasswordPage(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: Pages.signUp.toPath(isSubRoute: true),
            name: Pages.signUp.toPathName(),
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const SignUpPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: Pages.verify.toPath(),
        name: Pages.verify.toPathName(),
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CodeVerificationPage(),
        ),
      ),
      GoRoute(
        path: Pages.tutorials.toPath(),
        name: Pages.tutorials.toPathName(),
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TutorialPage(),
        ),
      ),
      GoRoute(
        path: Pages.completeAccount.toPath(),
        name: Pages.completeAccount.toPathName(),
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const OnboardingFlow(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, statefulNavigationShell) => ShellController(navigationShell: statefulNavigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Pages.home.toPath(pathPrefix: homeRoutePrefix),
                name: Pages.home.toPathName(),
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Pages.chat.toPath(pathPrefix: homeRoutePrefix),
                name: Pages.chat.toPathName(),
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(
                        context.l10n.explore,
                        style: context.headline16(),
                      ),
                    ),
                    body: Center(
                      child: Text(
                        'Chat Page',
                        style: context.bodyRegular16(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Pages.explore.toPath(pathPrefix: homeRoutePrefix),
                name: Pages.explore.toPathName(),
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text(context.l10n.explore),
                    ),
                    body: const Center(
                      child: Text('Explore Page'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Pages.more.toPath(pathPrefix: homeRoutePrefix),
                name: Pages.more.toPathName(),
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const MorePage(),
                ),
                routes: [
                  GoRoute(
                    path: Pages.profile.toPath(isSubRoute: true),
                    name: Pages.profile.toPathName(),
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: BlocProvider(
                        create: (context) => GetIt.instance<ProfileBloc>(),
                        child: const MyProfilePage(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: Pages.settings.toPath(isSubRoute: true),
                    name: Pages.settings.toPathName(),
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: const SettingsPage(),
                    ),
                  ),
                  GoRoute(
                    path: Pages.notifications.toPath(isSubRoute: true),
                    name: Pages.notifications.toPathName(),
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: BlocProvider(
                        create: (context) => getIt<NotificationBloc>(),
                        child: const NotificationPage(),
                      ),
                    ),
                  ),
                  GoRoute(
                    path: Pages.designSystem.toPath(isSubRoute: true),
                    name: Pages.designSystem.toPathName(),
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => MaterialPage(
                      key: state.pageKey,
                      child: const DesignSystemPage(),
                    ),
                  ),
                ],
              ),
          
        ],
      ),
    ],
      ),
    ],
    redirect: (context, state) {
      // Determine current auth state
      final currentState = _determineAuthState();

      // Define routing rules map
      final routingRules = {
        RouterAuthState.notInitialized: Pages.splash,
        RouterAuthState.notLoggedIn: Pages.intro,
        RouterAuthState.notVerified: Pages.verify,
        RouterAuthState.notCompleted: Pages.completeAccount,
        RouterAuthState.authenticated: Pages.home,
      };

      // Get target page for current auth state
      final targetPage = routingRules[currentState] ?? Pages.splash;

      // For authenticated state, only check if path starts with homePrefix
      // For other states, ensure exact path match
      if (currentState == RouterAuthState.authenticated) {
        if (!state.matchedLocation.startsWith(homeRoutePrefix)) {
          final targetPath = state.namedLocation(targetPage.toPathName());
          return targetPath;
        }
      } else {
        final targetPath = state.namedLocation(targetPage.toPathName());
        if (!state.matchedLocation.startsWith(targetPath)) {
          return targetPath;
        }
      }

      return null;
    },
    );
    

  // Helper method to determine current auth state
  RouterAuthState _determineAuthState() {
    final s = _appCubit.state;
    if (!s.isInitialized) return RouterAuthState.notInitialized;
    if (!s.isLogin) return RouterAuthState.notLoggedIn;
    if (!s.isCodeVerified) return RouterAuthState.notVerified;
    // if (!s.isAccountCompleted) return RouterAuthState.notCompleted;
    return RouterAuthState.authenticated;
  }
}
