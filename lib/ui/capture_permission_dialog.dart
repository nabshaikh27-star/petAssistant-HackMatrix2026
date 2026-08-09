import 'package:flutter/material.dart';

/// Shows an explicit, plain-language permission dialog before screen capture.
/// Returns true if the user allowed, false if they cancelled.
Future<bool> showCapturePermissionDialog(
  BuildContext context,
  CaptureType type,
) async {
  final label = type == CaptureType.fullScreen ? 'the full screen' : 'a selected region';
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Must explicitly choose
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.screenshot_monitor, size: 36, color: Colors.orange),
      title: const Text('📸 Screen Capture Request'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Desktop Pet wants to capture $label.',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const _BulletPoint(
            icon: Icons.timer_outlined,
            text: 'This happens once, right now, only because you asked.',
          ),
          const _BulletPoint(
            icon: Icons.block,
            text: 'It is never automatic.',
          ),
          const _BulletPoint(
            icon: Icons.visibility_off_outlined,
            text: 'It never runs silently in the background.',
          ),
          const _BulletPoint(
            icon: Icons.send_outlined,
            text: 'The image is sent directly to the AI API and stored locally only.',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.check),
          label: const Text('Allow Once'),
          onPressed: () => Navigator.pop(ctx, true),
        ),
      ],
    ),
  );
  return result ?? false;
}

enum CaptureType { fullScreen, region }

class _BulletPoint extends StatelessWidget {
  final IconData icon;
  final String text;
  const _BulletPoint({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}

/// Persistent banner shown while a capture is in progress.
class CapturingBanner extends StatelessWidget {
  const CapturingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.red.shade700,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fiber_manual_record, color: Colors.white, size: 12),
          SizedBox(width: 6),
          Text(
            'Screen capture in progress…',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
