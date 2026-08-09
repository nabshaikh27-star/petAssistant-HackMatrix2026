import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desktop_pet/ui/capture_permission_dialog.dart';
import 'package:screen_capturer/screen_capturer.dart';

void main() {
  group('Screen Capture Permission Flow Tests', () {
    testWidgets('Dialog defaults to denying permission if dismissed', (WidgetTester tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showCapturePermissionDialog(context, CaptureType.fullScreen);
                },
                child: const Text('Ask'),
              );
            },
          ),
        ),
      );

      // Tap button to show dialog
      await tester.tap(find.text('Ask'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);

      // Dismiss dialog by tapping outside (barrier dismissible)
      // Since barrierDismissible is true, we simulate tapping outside by popping the route
      Navigator.of(tester.element(find.byType(AlertDialog))).pop();
      await tester.pumpAndSettle();

      // In showCapturePermissionDialog, a null pop resolves to false
      expect(result, isFalse);
    });

    testWidgets('Dialog returns true only on explicit Allow', (WidgetTester tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showCapturePermissionDialog(context, CaptureType.fullScreen);
                },
                child: const Text('Ask'),
              );
            },
          ),
        ),
      );

      // Tap button to show dialog
      await tester.tap(find.text('Ask'));
      await tester.pumpAndSettle();

      // Tap 'Allow'
      await tester.tap(find.text('Allow'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    testWidgets('Dialog returns false on explicit Deny', (WidgetTester tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showCapturePermissionDialog(context, CaptureType.fullScreen);
                },
                child: const Text('Ask'),
              );
            },
          ),
        ),
      );

      // Tap button to show dialog
      await tester.tap(find.text('Ask'));
      await tester.pumpAndSettle();

      // Tap 'Deny'
      await tester.tap(find.text('Deny'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });
  });
}
