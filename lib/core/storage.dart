import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/pet_config.dart';
import '../models/reminder.dart';

class Storage {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isNotEmpty) {
      isar = Isar.getInstance()!;
    } else {
      isar = await Isar.open(
        [PetConfigSchema, ReminderSchema],
        directory: dir.path,
      );
    }

    // Initialize default config if none exists
    if (await isar.petConfigs.count() == 0) {
      final config = PetConfig()
        ..positionX = 100
        ..positionY = 100
        ..size = 150;
      await isar.writeTxn(() async {
        await isar.petConfigs.put(config);
      });
    }
  }

  static Future<PetConfig> getConfig() async {
    return (await isar.petConfigs.where().findFirst()) ?? PetConfig();
  }

  static Future<void> savePosition(double x, double y) async {
    final config = await getConfig();
    config.positionX = x;
    config.positionY = y;
    await isar.writeTxn(() async {
      await isar.petConfigs.put(config);
    });
  }
}
