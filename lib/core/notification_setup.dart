import 'package:local_notifier/local_notifier.dart';
import 'package:window_manager/window_manager.dart';

class SystemNotificationManager {
  static final SystemNotificationManager _instance = SystemNotificationManager._internal();
  factory SystemNotificationManager() => _instance;
  SystemNotificationManager._internal();

  Future<void> init() async {
    // Add in main package: local_notifier: ^0.1.7
    await localNotifier.setup(
      appName: 'Desktop Pet',
      // The shortcutPolicy can be omitted or set, we'll just use defaults
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );
  }

  Future<void> showNotification({required int id, required String title, required String body}) async {
    LocalNotification notification = LocalNotification(
      title: title,
      body: body,
    );
    
    notification.onClick = () async {
      await windowManager.show();
      await windowManager.focus();
    };

    await notification.show();
  }
}
