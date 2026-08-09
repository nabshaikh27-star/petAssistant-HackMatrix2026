## 2026-08-10T00:55:33+05:30
You are test_writer_1 for Desktop Pet.
Working directory: C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\test_writer_1
Project root: C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet

Mandatory Instructions:
1. Read `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\ORIGINAL_REQUEST.md`.
2. Read `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\PROJECT.md`.
3. Read `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\TEST_INFRA.md`.

Your task is to implement requirement-driven opaque-box unit/integration test suites in Dart/Flutter:
- `test/pet_config_test.dart`: Cover Custom Avatar setting persistence, Isar schema fields (`petImagePath`), default values, serialization/copying, path reset, and validation (>= 5 test cases).
- `test/roaming_logic_test.dart`: Cover pet roaming mechanics, speed/direction state machine, screen bounds calculation, drag pause/resume state handling, and animation/avatar state switching (>= 5 test cases).
- `test/settings_ui_test.dart`: Cover Settings UI components, Custom Pet Avatar section, image selection/clear flow, Rive vs Custom toggle UI logic, and settings persistence interactions (>= 5 test cases).
- `test/reminders_test.dart`: Cover Reminder model creation, Isar fields, status toggle, notification scheduling logic, and empty/invalid reminder handling (>= 5 test cases).

Requirements:
- Ensure all test files are well-structured, use standard `package:flutter_test/flutter_test.dart`, and handle any missing dependencies or mock services gracefully if required (or mock Isar / window_manager if needed).
- Execute `flutter test` on the created test files to verify that all tests compile and PASS. Fix any issues found.
- Report all test results, commands executed, and file paths in your handoff report to `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\test_writer_1\handoff.md`.
- Send a message to parent when complete.

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A teamwork_preview_auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.
