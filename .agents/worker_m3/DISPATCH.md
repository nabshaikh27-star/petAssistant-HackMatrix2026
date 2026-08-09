## 2026-08-10T00:53:20Z
<USER_REQUEST>
You are teamwork_preview_worker for Milestone M3 (Global Application Review & Hardening).
Working directory: C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\worker_m3
Project root: C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet

Task instructions:
1. Read `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\ORIGINAL_REQUEST.md`.
2. Read `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\PROJECT.md`.
3. Read handoff report `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\explorer_survey_3\handoff.md`.
4. Fix all reported global bugs in `lib/`:
   a. String Interpolation Syntax Bugs: Fix escaped `\$` in `lib/core/scheduler_isolate.dart:95`, `lib/ui/shortcuts_page.dart:51`, `lib/core/hotkey_setup.dart:53`, `lib/core/path_launcher.dart:18`.
   b. Exception & Crash Hardening:
      - `lib/ai_assistant/api_service.dart:30`: Move `File(imagePath).readAsBytes()` inside `try-catch`.
      - `lib/ui/chat_page.dart:329`: Add `errorBuilder` to `Image.file` to handle missing/corrupted image files cleanly without paint errors.
      - `lib/main.dart`: Wrap initialization chain calls in `try-catch` blocks with clear error logging.
      - `lib/core/storage.dart:14`: Wrap `Isar.getInstance()!` check safely.
      - `lib/ai_assistant/chat_provider.dart:69`: Fix `.take(20)` to correctly take the MOST RECENT 20 messages for Gemini API prompt context.
   c. UI Layout Overflow Fixes:
      - `lib/ui/shortcut_editor.dart:95`: Fix unbounded `Column` + `Spacer()` overflow by using `SingleChildScrollView` / flexible layout.
      - `lib/ui/settings_page.dart:127` & `lib/ui/reminders_page.dart:97`: Wrap `AlertDialog` `Column` contents in `SingleChildScrollView`.
      - `lib/ui/radial_menu.dart:155`: Add `maxLines: 2, overflow: TextOverflow.ellipsis` to shortcut label `Text` widget.
   d. Clean up `test/widget_test.dart` to resolve obsolete test references.
5. Run build / static analysis (`flutter analyze`) to ensure 0 errors.
6. Write handoff report with build results to `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\worker_m3\handoff.md`.
7. Send a message to parent upon completion with the path to your handoff file.

MANDATORY INTEGRITY WARNING:
DO NOT CHEAT. All implementations must be genuine. DO NOT hardcode test results, create dummy/facade implementations, or circumvent the intended task. A teamwork_preview_auditor will independently verify your work. Integrity violations WILL be detected and your work WILL be rejected.
</USER_REQUEST>
