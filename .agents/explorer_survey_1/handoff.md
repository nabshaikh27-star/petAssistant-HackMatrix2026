# Survey Explorer 1 Analysis & Handoff Report

## 1. Observation

### 1.1 Project Structure & Dependencies
- **Project Location**: `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet`
- **Flutter & Environment**: Target platform is Windows Desktop (`sdk: ^3.5.0`, `flutter run -d windows`).
- **`pubspec.yaml` Highlights**:
  - `flutter_riverpod: ^2.5.1` (State management)
  - `isar: ^3.1.0` & `isar_flutter_libs: ^3.1.0` (Local NoSQL persistence)
  - `flutter_secure_storage: ^9.2.2` (Windows DPAPI key storage)
  - `file_picker: ^8.0.3` & `image_picker: ^1.1.2` (File/Image selection)
  - `rive: ^0.13.1` (Rive animations)
  - `window_manager: ^0.4.3`, `tray_manager: ^0.2.2`, `hotkey_manager: ^0.1.8`, `local_notifier: ^0.1.6`, `screen_capturer: ^0.1.5`, `url_launcher: ^6.3.0`, `dio: ^5.5.0+1`, `image: ^4.2.0`, `launch_at_startup: ^0.2.2`, `package_info_plus: ^8.0.0`.

### 1.2 Existing Storage & State Management Implementation
- **Isar Database Initialization**: `Storage.init()` (`lib/core/storage.dart:11-32`) initializes Isar schema with `PetConfigSchema`, `ReminderSchema`, `QuickAccessShortcutSchema`, `ChatMessageSchema`.
- **Pet Configuration Model**: Defined in `lib/models/pet_config.dart` (`@collection class PetConfig`):
  - `petImagePath` (`String?`) is already present on line 9 of `lib/models/pet_config.dart` and generated in `lib/models/pet_config.g.dart:40-44`.
  - `positionX` (`double`, default 100), `positionY` (`double`, default 100), `size` (`double`, default 150).
  - `hotkeyJson` (`String?`), `hotkeyMode` (`String`), `launchOnStartup` (`bool`).
- **State Management**:
  - `main.dart:56` wraps root widget with `ProviderScope`.
  - `chat_page.dart` uses `ConsumerStatefulWidget` with Riverpod providers (`chatProvider`, `isCapturingProvider`, `petIsTypingProvider`).
  - `pet_window.dart` is currently a standard `StatefulWidget` (`lib/pet/pet_window.dart:14`), reading `Storage.getConfig()` asynchronously at startup and when resizing window after chat/radial menu close. It does not currently observe `PetConfig` updates reactively.

### 1.3 WhatsApp Sticker Export Code (To be Removed / Replaced)
1. **`lib/ui/sticker_export_page.dart`**:
   - 233-line widget file containing `StickerExportPage`.
   - Imports `../stickers/sticker_pipeline.dart`.
   - UI allows picking multiple images, editing pack name/publisher, and calling `StickerPipeline.packageStickers()`.
2. **`lib/stickers/sticker_pipeline.dart`**:
   - 125-line pipeline class using `image` package and `compute()` isolate to decode, resize to 512x512, pad, and export `.webp`/`.png` stickers and `contents.json`.
3. **`lib/ui/settings_page.dart`**:
   - Line 13: `import 'sticker_export_page.dart';`
   - Lines 86-91:
     ```dart
     ListTile(
       title: const Text('Make WhatsApp Stickers'),
       subtitle: const Text('Export custom images to WhatsApp sticker packs'),
       trailing: const Icon(Icons.star, color: Colors.amber),
       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StickerExportPage())),
     ),
     ```

### 1.4 Pet Window Rendering Code
- **`lib/pet/pet_window.dart` Lines 119-130**:
  ```dart
  child: Center(
    child: SizedBox(
      width: 150,
      height: 150,
      child: RiveAnimation.network(
        'https://cdn.rive.app/animations/vehicles.riv', 
        fit: BoxFit.contain,
      ),
    ),
  ),
  ```
- Currently always renders network Rive animation; `petImagePath` is never checked or displayed.

---

## 2. Logic Chain

1. **Storage Requirement**:
   - The user requires replacing WhatsApp Sticker export with a "Custom Pet Avatar" setting.
   - `PetConfig` already possesses `String? petImagePath`.
   - Therefore, no schema migration is needed for Isar; we can read and write `petImagePath` directly on `PetConfig`.
   - When a user picks a custom PNG/JPG file using `FilePicker.platform.pickFiles(type: FileType.image)`, the app should copy the file to application storage (e.g. `getApplicationDocumentsDirectory()`) or save the absolute path into `PetConfig.petImagePath`.

2. **UI & Feature Replacement**:
   - In `lib/ui/settings_page.dart`, delete the WhatsApp Sticker export `ListTile` and import.
   - Insert a new "Custom Pet Avatar" setting section in `lib/ui/settings_page.dart`.
   - The new setting UI should display:
     - Avatar preview (current custom image if set, or default indicator/icon if unset).
     - "Choose Image" button using `file_picker`.
     - "Reset to Default" button (sets `petImagePath = null`).
   - Remove `lib/ui/sticker_export_page.dart` and `lib/stickers/sticker_pipeline.dart`.

3. **Pet Window Dynamic Rendering & Reactive Updates**:
   - `pet_window.dart` must check if `config.petImagePath` is non-null and points to an existing file (`File(config.petImagePath!).existsSync()`).
   - If valid custom image path: Render `Image.file(File(config.petImagePath!), fit: BoxFit.contain)`.
   - If null or missing file: Fallback to `RiveAnimation.network('https://cdn.rive.app/animations/vehicles.riv', fit: BoxFit.contain)`.
   - To update `pet_window.dart` immediately when the user changes the avatar in `SettingsPage`, `PetWindow` can either:
     - Use a Riverpod StateNotifier/Notifier (`petConfigProvider`) and `ref.watch(petConfigProvider)`.
     - Or re-fetch `Storage.getConfig()` whenever the window regains focus or after Navigator push/pop. Using a Riverpod provider is cleaner and guarantees immediate UI update.

4. **Global Review & Stabilization**:
   - Verify layout and overflow safety in `SettingsPage`, `RadialMenuOverlay`, `ChatPage`.
   - Check `widget_test.dart` boilerplate test which references obsolete `MyApp` and update/clean it up.

---

## 3. Caveats

- `RiveAnimation.network` requires active internet access to fetch `vehicles.riv`. If internet is offline and no custom pet image is set, network loading may fail silently or log a network exception. (Providing a fallback offline container or handling image error gracefully is recommended).
- Custom pet image file paths must be validated with `File(path).existsSync()` before displaying `Image.file` to prevent image rendering crash if the user deletes the original file.

---

## 4. Conclusion

- **Removal Scope**: `lib/ui/sticker_export_page.dart`, `lib/stickers/sticker_pipeline.dart`, and the WhatsApp sticker tile in `lib/ui/settings_page.dart`.
- **Implementation Scope**:
  - Add Riverpod provider for `PetConfig` or live refresh listener.
  - Implement Custom Pet Avatar setting in `lib/ui/settings_page.dart` using `file_picker`.
  - Update `lib/pet/pet_window.dart` to conditionally render `Image.file` when `petImagePath` is set, or fall back to Rive animation.
  - Test and verify with `flutter run -d windows` or static analysis.

---

## 5. Verification Method

### 5.1 Verification Commands
- Check project compilation and analyze:
  ```powershell
  flutter analyze
  ```
- Build and run desktop app:
  ```powershell
  flutter run -d windows
  ```

### 5.2 Files to Inspect
- `lib/models/pet_config.dart` & `lib/core/storage.dart`
- `lib/ui/settings_page.dart`
- `lib/pet/pet_window.dart`
- Removal verification: Confirm `lib/ui/sticker_export_page.dart` and `lib/stickers/sticker_pipeline.dart` are removed.

### 5.3 Invalidation Conditions
- App crashes when custom image file is selected or deleted.
- Pet avatar fails to update in `PetWindow` after setting custom avatar in `SettingsPage`.
- Build failures during `flutter run -d windows`.
