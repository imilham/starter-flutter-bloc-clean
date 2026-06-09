import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/app/app.dart';
import 'package:starter/utils/utils.dart';

/// A widget that shows a non-blocking, slide-up connectivity banner
/// when the device is offline.
///
/// Wraps the [child] in a [Stack] and overlays a slide-up banner driven by
/// [ConnectivityCubit]. The banner only appears when [AppSettings.showOfflineOverlay]
/// is `true`.
class ConnectivityOverlay extends StatefulWidget {
  const ConnectivityOverlay({required this.child, super.key});

  final Widget? child;

  @override
  State<ConnectivityOverlay> createState() => _ConnectivityOverlayState();
}

class _ConnectivityOverlayState extends State<ConnectivityOverlay>
    with TickerProviderStateMixin {
  late Animation<Offset> _slideAnimation;
  late AnimationController _slideController;
  final _settings = GetIt.instance<AppSettings>();

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Slide from below the viewport into its resting position.
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_settings.showOfflineOverlay) {
      return widget.child ?? const SizedBox.shrink();
    }

    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      listenWhen: (prev, curr) =>
          prev.isConnected != curr.isConnected ||
          prev.isInitialized != curr.isInitialized,
      listener: (context, state) {
        if (state.isConnected || !state.isInitialized) {
          _slideController.reverse();
        } else {
          _slideController.forward();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            widget.child ?? const SizedBox.shrink(),
            Positioned(
              left: 16,
              right: 16,
              bottom: MediaQuery.paddingOf(context).bottom + 80,
              child: AnimatedBuilder(
                animation: _slideController,
                builder: (context, _) {
                  if (_slideController.value == 0) {
                    return const SizedBox.shrink();
                  }

                  return SlideTransition(
                    position: _slideAnimation,
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.errorContainer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.wifi,
                              size: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onErrorContainer,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                context.l10n.noInternetConnection,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            TextButton(
                              onPressed: _settings.openSettings,
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                minimumSize: Size.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                context.l10n.goToSettings,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
