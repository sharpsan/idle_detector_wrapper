import 'dart:async';

import 'package:flutter/material.dart';

class IdleDetector extends StatefulWidget {
  final Duration idleTime;
  final Widget child;
  final Function? onIdle;

  IdleDetector({
    required this.idleTime,
    required this.child,
    this.onIdle,
  });

  @override
  State<IdleDetector> createState() => _IdleDetectorState();
}

class _IdleDetectorState extends State<IdleDetector> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(widget.idleTime, () {
      if (widget.onIdle != null) {
        widget.onIdle!();
      }
    });
  }

  void handleUserInteraction() {
    _resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => handleUserInteraction(),
      onPointerMove: (_) => handleUserInteraction(),
      onPointerUp: (_) => handleUserInteraction(),
      onPointerCancel: (_) => handleUserInteraction(),
      onPointerHover: (_) => handleUserInteraction(),
      onPointerPanZoomEnd: (_) => handleUserInteraction(),
      onPointerSignal: (_) => handleUserInteraction(),
      onPointerPanZoomStart: (_) => handleUserInteraction(),
      onPointerPanZoomUpdate: (_) => handleUserInteraction(),
      child: widget.child,
    );
  }
}
