import 'dart:io';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../models/pet_config.dart';
import 'storage.dart';

class SystemStartupManager {
  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    launchAtStartup.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
    );

    final config = await Storage.getConfig();
    if (config.launchOnStartup) {
      await launchAtStartup.enable();
    } else {
      await launchAtStartup.disable();
    }
  }

  static Future<void> setLaunchOnStartup(bool enable) async {
    final config = await Storage.getConfig();
    config.launchOnStartup = enable;
    
    await Storage.isar.writeTxn(() async {
      await Storage.isar.petConfigs.put(config);
    });

    if (enable) {
      await launchAtStartup.enable();
    } else {
      await launchAtStartup.disable();
    }
  }
}
