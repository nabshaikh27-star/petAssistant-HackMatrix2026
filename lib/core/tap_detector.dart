import 'dart:async';
import 'package:flutter/material.dart';

class DebouncedTapDetector extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSingleTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onTripleTap;
  final Duration timeout; // Time to wait before deciding the final tap count

  const DebouncedTapDetector({
    super.key,
    required this.child,
    this.onSingleTap,
    this.onDoubleTap,
    this.onTripleTap,
    this.timeout = const Duration(milliseconds: 400),
  });

  @override
  State<DebouncedTapDetector> createState() => _DebouncedTapDetectorState();
}

class _DebouncedTapDetectorState extends State<DebouncedTapDetector> {
  int _tapCount = 0;
  Timer? _timer;

  void _handleTap() {
    _tapCount++;

    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer(widget.timeout, () {
      if (_tapCount == 1) {
        widget.onSingleTap?.call();
      } else if (_tapCount == 2) {
        widget.onDoubleTap?.call();
      } else if (_tapCount >= 3) {
        widget.onTripleTap?.call();
      }
      _tapCount = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      // We don't use onDoubleTap here because standard GestureDetector 
      // blocks single tap until double tap timeout finishes, but doesn't handle triple taps.
      // Our custom timer handles all N-taps elegantly!
      child: widget.child,
    );
  }
}
