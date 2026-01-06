import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:starter/app/app.dart';
import 'package:starter/auth/auth.dart';
import 'package:starter/utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
    super.initState();
  }

  /// Initializes the application by delaying for 2 seconds
  /// and setting the `isInitialized` property of `AppStates` to true.
  Future<void> init() async {
    FlutterNativeSplash.remove();
    // TODO(ishanga): Remove the delay after actual API calls are implemented.
    // This is just to simulate a loading state.
    await Future.delayed(const Duration(seconds: 2), () {});
    await GetIt.instance<AppStates>().onAppStart();
    try {
      await GetIt.instance<AuthService>().refreshSession();
    } catch (_) {
      return;
    }
    GetIt.instance<AppStates>().isInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: AppLogo(aspectRatio: 1.5),
            ),
            Gap.medium16,
            StreamBuilder(
              stream: GetIt.instance<AuthService>().onAuthStateChanges,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state is AuthLoading) {
                  if (state is AuthRetrying) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        ),
                        Gap.medium16,
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: bodyRegular(textColor: context.colorScheme.error),
                        ),
                        Builder(
                          builder: (context) {
                            if (state.lastError == null || state.lastError!.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Text(
                                state.lastError ?? '',
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: tab3Xs(textColor: context.colorScheme.onSurface.withValues(alpha: 0.5)),
                              ),
                            );
                          },
                        ),
                        Builder(
                          builder: (context) {
                            if (state.retryCount != null && state.retryCount! > 0) {
                              return Text(
                                'Attempt ${state.retryCount!} of ${state.maxRetries}',
                                style: tab3Xs(textColor: context.colorScheme.onSurface.withValues(alpha: 0.5)),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        Gap.extraLarge32,
                        Gap.medium16,
                        Builder(
                          builder: (context) {
                            if (state.cancellationToken == null) {
                              return const SizedBox.shrink();
                            }
                            if (state.retryCount != null && state.retryCount! >= 3) {
                              return FilledButton.icon(
                                onPressed: () {
                                  state.cancellationToken?.cancel();
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.red),
                                ),
                                icon: const Icon(Icons.cancel),
                                label: Text(
                                  'Cancel & Logout',
                                  style: bodyRegular(),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    );
                  }
                  if (state is AuthRetryingFailed) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: bodyRegular(textColor: context.colorScheme.error),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Try again later or contact support if the issue persists.',
                            textAlign: TextAlign.center,
                            style: tab3Xs(textColor: context.colorScheme.onSurface.withValues(alpha: 0.5)),
                          ),
                        ),
                      ],
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
