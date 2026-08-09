# Handoff Report — Custom Pet Avatar & Roaming Engine Survey Analysis

## 1. Observation

Direct observations from examining the codebase in `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\lib`:

- **Pet Window & Rendering (`lib/pet/pet_window.dart`)**:
  - `PetWindow` currently loads a network Rive animation at lines 122–129:
    ```dart
    child: SizedBox(
      width: 150,
      height: 150,
      child: RiveAnimation.network(
        'https://cdn.rive.app/animations/vehicles.riv', 
        fit: BoxFit.contain,
      ),
    ),
    ```
  - `PetWindow` handles user window dragging (`windowManager.startDragging()` on line 88), single-tap opening `ChatPage` (lines 90–100), and secondary tap opening `RadialMenuOverlay` (lines 101–118).
  - Currently, there is **no automatic screen roaming loop / movement engine** implemented in `pet_window.dart`. Window positioning only happens at app initialization (`main.dart` line 47) or when the user manually drags the pet window (`onWindowMoved` in `pet_window.dart` line 70).

- **Data Storage & Model (`lib/models/pet_config.dart` & `lib/core/storage.dart`)**:
  - `PetConfig` in `lib/models/pet_config.dart` already defines fields:
    ```dart
    String? petImagePath;
    String? activeAnimationSet;
    double positionX = 100;
    double positionY = 100;
    double size = 150;
    ```
  - `Storage` in `lib/core/storage.dart` manages Isar instance initialization and position persistence (`Storage.savePosition(x, y)`).

- **Settings Page & Existing WhatsApp Sticker Feature (`lib/ui/settings_page.dart` & `lib/ui/sticker_export_page.dart`)**:
  - `SettingsPage` lines 86–91 contains the WhatsApp Sticker export setting:
    ```dart
    ListTile(
      title: const Text('Make WhatsApp Stickers'),
      subtitle: const Text('Export custom images to WhatsApp sticker packs'),
      trailing: const Icon(Icons.star, color: Colors.amber),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const StickerExportPage())),
    )
    ```
  - The requirement (`ORIGINAL_REQUEST.md` R1) explicitly mandates replacing the WhatsApp Sticker export feature with a "Custom Pet Avatar" setting.

- **Defects & Syntax Issues Discovered Across Codebase**:
  - `lib/ui/shortcuts_page.dart` line 51:
    ```dart
    subtitle: Text("Double: \${sc.doubleTapTargetPath != null ? 'Set' : 'Unset'} | Triple: \${sc.tripleTapTargetPath != null ? 'Set' : 'Unset'}"),
    ```
    (Escaped `\$` prevents Dart string interpolation, causing raw string literal rendering).
  - `lib/core/hotkey_setup.dart` line 53: `print("Failed to register hotkey: \$e");`
  - `lib/core/scheduler_isolate.dart` lines 95, 117: `sendPort.send(SchedulerMessage('show_notification', "\${reminder.title}||\${reminder.isBirthday}"));` and `print("ISOLATE ERROR: \$message");`.

---

## 2. Logic Chain

1. **Observation 1 (Rive Rendering vs Custom Image)**:
   `pet_window.dart` hardcodes `RiveAnimation.network(...)`.
   **Step 1**: To support custom pet avatars, `pet_window.dart` must dynamically query `PetConfig.petImagePath`. If `petImagePath != null` and points to a valid existing file (`File(petImagePath).existsSync()`), `pet_window.dart` must render `Image.file(File(petImagePath), fit: BoxFit.contain)`; otherwise, it falls back to the default `RiveAnimation`.

2. **Observation 2 (Persistent Storage & File Stability)**:
   User image selection using `FilePicker` provides a local file path. If the user picks an image from Downloads or an external drive and later moves/deletes it, the pet image would break.
   **Step 2**: When a user selects a PNG/JPG in `SettingsPage`, copy the image to the application documents directory (`getApplicationDocumentsDirectory() / custom_pet_avatar.<ext>`) before saving the persistent path to `PetConfig.petImagePath`. Also provide a "Reset to Default" button which sets `petImagePath = null`.

3. **Observation 3 (Screen Roaming Engine & Parity)**:
   `pet_window.dart` currently lacks an automated roaming loop. The requirements state "The custom image must roam around the screen exactly like the original pet."
   **Step 3**: Implement a unified `PetRoamingController` / roaming physics state machine in `pet_window.dart` (or as a dedicated helper/widget):
   - **Screen Bounds**: Query screen work area dimensions via `windowManager.getBounds()` or display dimensions, keeping pet within margins $[0, W - petSize] \times [0, H - petSize]$.
   - **State Machine**:
     - `Idle`: Stay stationary at current position for a random interval ($3.0$ to $7.0$ seconds).
     - `Walking`: Pick a random target waypoint within screen bounds. Step incrementally toward the target position (e.g. 30 Hz timer updating `positionX` and `positionY` via `windowManager.setPosition(...)`).
     - `Direction Flipping`: When moving left ($\Delta X < 0$), mirror the pet render using `Transform(alignment: Alignment.center, transform: Matrix4.diagonal3Values(-1.0, 1.0, 1.0))`. When moving right ($\Delta X > 0$), face right (`scaleX: 1.0`).
     - `Pause/Resume`: Pause roaming while user drags pet (`onPanStart`), or opens Chat/Radial menu. Resume roaming after interaction completes.
   - **Parity**: Place this roaming physics loop at the outer container level so it operates identically regardless of whether the child is a Rive animation or a custom PNG/JPG image.

4. **Observation 4 (Global Review Fixes)**:
   Found multiple syntax string-escaping bugs in `shortcuts_page.dart`, `hotkey_setup.dart`, and `scheduler_isolate.dart`, plus obsolete sticker export UI in `settings_page.dart`.
   **Step 4**: Replace sticker export tile with Custom Pet Avatar controls in `settings_page.dart`, and fix all string interpolation bugs during global code cleanup.

---

## 3. Caveats

- **Multi-Monitor Setup**: `windowManager` position coordinates operate across virtual screen boundaries. Querying screen bounds should target primary display dimensions to prevent the pet from roaming off-screen or onto secondary monitors unexpectedly.
- **Isar Database Schema**: `PetConfig` already contains `petImagePath`. No Isar schema migration is needed, but `Isar.open` must continue loading `PetConfigSchema`.
- **Rive State Machines**: The current Rive animation is a network asset (`vehicles.riv`). The fallback Rive animation should gracefully remain if no custom image is selected.

---

## 4. Conclusion & Detailed Implementation Plan

### Step-by-Step Implementation Strategy

1. **Step 1: Settings Page Update (`lib/ui/settings_page.dart`)**
   - Replace the `ListTile` for `StickerExportPage` with a new `_CustomPetAvatarSection` widget.
   - Implement `_pickCustomAvatar()`:
     - Call `FilePicker.platform.pickFiles(type: FileType.image, allowedExtensions: ['png', 'jpg', 'jpeg'])`.
     - Copy picked file to `${appDocDir.path}/custom_pet_avatar_${timestamp}.${ext}`.
     - Update `PetConfig.petImagePath` in Isar.
   - Implement `_resetToDefaultAvatar()`:
     - Set `PetConfig.petImagePath = null` in Isar.
   - Display avatar preview thumbnail, active file path status, and Pick/Reset buttons.

2. **Step 2: Dynamic Pet Rendering (`lib/pet/pet_window.dart`)**
   - Add state management / listener to reload `PetConfig` when updated.
   - Build `_buildPetContent(PetConfig config)`:
     ```dart
     if (config.petImagePath != null && File(config.petImagePath!).existsSync()) {
       return Image.file(File(config.petImagePath!), fit: BoxFit.contain);
     }
     return const RiveAnimation.network(
       'https://cdn.rive.app/animations/vehicles.riv',
       fit: BoxFit.contain,
     );
     ```

3. **Step 3: Screen Roaming Physics Engine (`lib/pet/pet_window.dart`)**
   - Initialize a 30Hz `Timer.periodic` for pet physics ticks.
   - Maintain state: `double _currentX`, `double _currentY`, `double _targetX`, `double _targetY`, `bool _isMovingLeft`, `bool _isPaused`, `Timer? _idleTimer`.
   - On tick:
     - If `_isPaused`, do nothing.
     - If at target position, enter `Idle` state: schedule `_idleTimer` for 3–6s, then select new random `(_targetX, _targetY)` within display bounds.
     - If moving, compute velocity vector $(\Delta X, \Delta Y)$, step current position by speed factor, update `windowManager.setPosition(...)`, and update `_isMovingLeft = dx < 0`.
   - Wrap pet display widget with:
     ```dart
     Transform(
       alignment: Alignment.center,
       transform: Matrix4.diagonal3Values(_isMovingLeft ? -1.0 : 1.0, 1.0, 1.0),
       child: SizedBox(width: config.size, height: config.size, child: petContent),
     )
     ```
   - Pause roaming on drag start / tap / secondary tap; resume on completion.

4. **Step 4: Global Review & Bug Fixes**
   - Fix escaped string interpolation in `lib/ui/shortcuts_page.dart` line 51.
   - Fix escaped string interpolation in `lib/core/hotkey_setup.dart` line 53.
   - Fix escaped string interpolation in `lib/core/scheduler_isolate.dart` lines 95, 117.

---

## 5. Verification Method

- **Compilation Verification**:
  - Run `flutter analyze` or `flutter pub get` / `flutter build windows --debug` to ensure zero compilation errors.
- **Custom Image Upload Verification**:
  - Open Settings, click "Upload Custom Pet Avatar", select a PNG/JPG.
  - Verify `PetConfig.petImagePath` updates in Isar and copied file exists in application documents directory.
  - Verify `PetWindow` renders the uploaded PNG/JPG image immediately.
  - Click "Reset to Default Avatar" and verify `PetWindow` restores the default Rive animation.
- **Roaming Parity Verification**:
  - Observe both the Rive car pet and the Custom PNG pet roaming across desktop boundaries.
  - Confirm pet flips horizontally when walking left vs walking right.
  - Confirm roaming pauses during drag / chat / radial menu interactions and resumes afterwards.
- **Code Integrity Check**:
  - Inspect `shortcuts_page.dart`, `hotkey_setup.dart`, and `scheduler_isolate.dart` to verify string interpolation syntax is clean.
