# Project: Desktop Pet Application

## Architecture
- **Framework**: Flutter Desktop (`flutter run -d windows`)
- **State Management**: `flutter_riverpod` (`ProviderScope`, `ConsumerStatefulWidget`, `StateNotifierProvider` / `NotifierProvider`)
- **Persistence**: Isar NoSQL Database (`lib/core/storage.dart`, `PetConfigSchema`, `ReminderSchema`, etc.)
- **Window & System Tray Integration**: `window_manager`, `tray_manager`, `hotkey_manager`, `local_notifier`
- **Animation & Image Rendering**: `rive` (`RiveAnimation.network`), Flutter `Image.file`
- **Data Flow**:
  - `SettingsPage` (UI) -> updates `PetConfig` via `Storage` / Riverpod -> notifies `PetWindow`
  - `PetWindow` -> reads `PetConfig` -> renders custom avatar `Image.file` or default Rive animation -> runs `PetRoamingController` physics loop

## Feature Inventory
| # | Feature | Description | Milestone | Source |
|---|---------|-------------|-----------|--------|
| 1 | Remove WhatsApp Sticker Export | Delete `sticker_export_page.dart`, `sticker_pipeline.dart`, and settings link | M1 | survey |
| 2 | Custom Pet Avatar Setting UI | Image picker (`file_picker`), copy to app docs, persist `petImagePath` in Isar, reset button | M1 | survey |
| 3 | Dynamic Pet Avatar Rendering | Render custom PNG/JPG in `pet_window.dart` if `petImagePath` is set, else default Rive animation | M2 | survey |
| 4 | Screen Roaming Physics Engine | 30Hz physics state machine (idle, walking, screen bounds, horizontal flipping, drag pause) | M2 | survey |
| 5 | String Interpolation & Syntax Fixes | Fix escaped `\$` in `scheduler_isolate.dart`, `shortcuts_page.dart`, `hotkey_setup.dart`, `path_launcher.dart` | M3 | survey |
| 6 | Exception & Null-Safety Hardening | Fix forced null assertions in `pet_window.dart`, `api_service.dart`, `chat_page.dart`, `main.dart`, `storage.dart` | M3 | survey |
| 7 | UI Overflow Fixes | Fix `Column` + `Spacer` in `shortcut_editor.dart`, dialogs in `settings_page.dart` & `reminders_page.dart`, `radial_menu.dart` label wrap | M3 | survey |
| 8 | Chat Context & Cleanup | Fix `.take(20)` in `chat_provider.dart` to take recent messages, clean up `widget_test.dart` | M3 | survey |
| 9 | Dual Track E2E Test Suite | Requirement-driven opaque-box test runner & cases (Tiers 1-4) + Tier 5 adversarial hardening | E2E | survey |

## Milestones
| # | Name | Scope | Dependencies | Status |
|---|------|-------|-------------|--------|
| M1 | Custom Pet Avatar Settings & Sticker Removal | Remove WhatsApp sticker exporter, implement `_CustomPetAvatarSection` in `settings_page.dart` | None | IN_PROGRESS |
| M2 | Dynamic Avatar Rendering & Roaming Physics Parity | Update `pet_window.dart` for dynamic PNG/JPG avatar rendering & 30Hz screen roaming physics | M1 | PLANNED |
| M3 | Global Application Review & Exception/Overflow Hardening | Fix string interpolation bugs, null assertion crashes, UI layout overflows, and chat provider | None | IN_PROGRESS |
| E2E | Opaque-Box E2E Testing Track | Design E2E test infra `TEST_INFRA.md`, publish `TEST_READY.md` (Tiers 1-4), verify app | M1, M2, M3 | IN_PROGRESS |

## Interface Contracts
### SettingsPage ↔ PetWindow Communication
- `PetConfig` Isar collection contains `String? petImagePath`.
- `petConfigProvider` (Riverpod `StateNotifierProvider` or `NotifierProvider`):
  - `state`: `PetConfig`
  - `updatePetImagePath(String? path)`: updates database and triggers state change listener in `PetWindow`.

### Pet Window Roaming Physics Engine Interface
- Class: `PetRoamingController`
- Methods:
  - `startRoaming()`: starts 30Hz movement timer.
  - `pauseRoaming()`: pauses physics updates (during user drag / menu open).
  - `resumeRoaming()`: resumes physics updates.
  - `updateBounds(Size screenBounds)`: updates work area limits.

## Code Layout
- `lib/models/`: Data models (`pet_config.dart`, `reminder.dart`, etc.)
- `lib/core/`: System services (`storage.dart`, `scheduler_isolate.dart`, `hotkey_setup.dart`, `path_launcher.dart`)
- `lib/pet/`: Pet window & roaming logic (`pet_window.dart`)
- `lib/ui/`: UI screens (`settings_page.dart`, `shortcuts_page.dart`, `shortcut_editor.dart`, `reminders_page.dart`, `radial_menu.dart`, `chat_page.dart`)
- `lib/ai_assistant/`: Chat & AI services (`chat_provider.dart`, `api_service.dart`)
- `test/`: Test cases & E2E runner (`widget_test.dart`, `e2e_test.dart`)
