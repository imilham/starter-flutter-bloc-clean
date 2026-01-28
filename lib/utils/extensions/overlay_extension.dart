import 'package:flutter/material.dart';

/// 💎 Premium Overlay Extension
/// 
/// Uses [LayerLink] and [CompositedTransformTarget] to create high-performance
/// floating UI elements that stick to their targets at the engine level.
/// 
/// Zero lag. Hardware-synced.
extension WidgetOverlayExtension on Widget {
  /// Wraps this widget in an [AnchoredOverlay] to show a floating element
  /// that physically tracks this widget using [LayerLink].
  /// 
  /// [overlayBuilder] builds the floating content.
  /// [anchor] defines how the overlay aligns with the target.
  Widget anchored({
    required Widget Function(BuildContext, VoidCallback hide) overlayBuilder,
    OverlayAnchor anchor = OverlayAnchor.bottomCenter,
    Offset offset = Offset.zero,
    bool showOverlayImmediately = false,
  }) {
    return AnchoredOverlay(
      overlayBuilder: overlayBuilder,
      anchor: anchor,
      offset: offset,
      showImmediately: showOverlayImmediately,
      child: this,
    );
  }
}

/// Defines where the overlay should be anchored relative to the target.
enum OverlayAnchor {
  topCenter,
  bottomCenter,
  center,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  leftCenter,
  rightCenter,
}

/// A widget that composites its child and allows an overlay to track it.
class AnchoredOverlay extends StatefulWidget {
  const AnchoredOverlay({
    required this.child,
    required this.overlayBuilder,
    this.anchor = OverlayAnchor.bottomCenter,
    this.offset = Offset.zero,
    this.showImmediately = false,
    super.key,
  });

  final Widget child;
  final Widget Function(BuildContext context, VoidCallback hide) overlayBuilder;
  final OverlayAnchor anchor;
  final Offset offset;
  final bool showImmediately;

  @override
  State<AnchoredOverlay> createState() => AnchoredOverlayState();
}

class AnchoredOverlayState extends State<AnchoredOverlay> {
  final LayerLink _layerLink = LayerLink();
  final OverlayPortalController _controller = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    if (widget.showImmediately) {
      // Post frame callback to ensure overlay is ready
      WidgetsBinding.instance.addPostFrameCallback((_) => show());
    }
  }

  /// Toggle the visibility of the overlay
  void toggle() {
    _controller.toggle();
  }

  /// Show the overlay
  void show() {
    _controller.show();
  }

  /// Hide the overlay
  void hide() {
    _controller.hide();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            link: _layerLink,
            targetAnchor: _getTargetAlignment(widget.anchor),
            followerAnchor: _getFollowerAlignment(widget.anchor),
            offset: widget.offset,
            child: widget.overlayBuilder(context, hide),
          );
        },
        child: GestureDetector(
          onTap: toggle,
          child: widget.child,
        ),
      ),
    );
  }

  Alignment _getTargetAlignment(OverlayAnchor anchor) {
    switch (anchor) {
      case OverlayAnchor.topCenter: return Alignment.topCenter;
      case OverlayAnchor.bottomCenter: return Alignment.bottomCenter;
      case OverlayAnchor.center: return Alignment.center;
      case OverlayAnchor.topLeft: return Alignment.topLeft;
      case OverlayAnchor.topRight: return Alignment.topRight;
      case OverlayAnchor.bottomLeft: return Alignment.bottomLeft;
      case OverlayAnchor.bottomRight: return Alignment.bottomRight;
      case OverlayAnchor.leftCenter: return Alignment.centerLeft;
      case OverlayAnchor.rightCenter: return Alignment.centerRight;
    }
  }

  Alignment _getFollowerAlignment(OverlayAnchor anchor) {
    switch (anchor) {
      case OverlayAnchor.topCenter: return Alignment.bottomCenter;
      case OverlayAnchor.bottomCenter: return Alignment.topCenter;
      case OverlayAnchor.center: return Alignment.center;
      case OverlayAnchor.topLeft: return Alignment.bottomLeft;
      case OverlayAnchor.topRight: return Alignment.bottomRight;
      case OverlayAnchor.bottomLeft: return Alignment.topLeft;
      case OverlayAnchor.bottomRight: return Alignment.topRight;
      case OverlayAnchor.leftCenter: return Alignment.centerRight;
      case OverlayAnchor.rightCenter: return Alignment.centerLeft;
    }
  }
}
