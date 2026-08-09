## 2026-08-10T00:53:20Z
<USER_REQUEST>
You are the E2E Testing Track Orchestrator for Desktop Pet.
Working directory: C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\sub_orch_e2e
Project root: C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet

Task instructions:
1. Read `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\ORIGINAL_REQUEST.md`.
2. Read `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\PROJECT.md`.
3. Create `TEST_INFRA.md` at `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\TEST_INFRA.md` following the Dual Track E2E Testing specification in Project Orchestrator guidelines.
4. Build requirement-driven opaque-box unit/integration test suites in `test/` (e.g., `test/e2e_test.dart`, `test/pet_config_test.dart`, `test/roaming_logic_test.dart`):
   - Tier 1: Feature Coverage (>=5 test cases per feature: Custom Avatar setting, PetConfig persistence, Roaming mechanics, Settings UI, Reminders, Shortcuts, Chat UI).
   - Tier 2: Boundary & Corner Cases (empty inputs, missing image files, invalid paths, rapid menu toggles).
   - Tier 3: Cross-Feature Combinations (Avatar change while pet active, hotkey triggers, notifications).
   - Tier 4: Real-World Application Workflows.
5. Ensure tests pass when run via `flutter test`.
6. When test suite is complete and passing, publish `TEST_READY.md` at `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\TEST_READY.md`.
7. Write your handoff report to `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet\.agents\sub_orch_e2e\handoff.md`.
8. Send a message to parent upon completion.
</USER_REQUEST>
