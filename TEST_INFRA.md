# E2E Test Infra: Desktop Pet Application

## Test Philosophy
- Opaque-box, requirement-driven. No dependency on implementation design details.
- Methodology: Category-Partition + Boundary Value Analysis (BVA) + Pairwise Combinatorial Testing + Real-World Workload Testing.

## Feature Inventory
| # | Feature | Source (requirement) | Tier 1 | Tier 2 | Tier 3 | Tier 4 |
|---|---------|---------------------|:------:|:------:|:------:|:------:|
| 1 | Custom Avatar Setting | ORIGINAL_REQUEST R1, PROJECT F2 | 5 | 5 | ✓ | ✓ |
| 2 | PetConfig Persistence | ORIGINAL_REQUEST R1, PROJECT F2 | 5 | 5 | ✓ | ✓ |
| 3 | Roaming Mechanics | ORIGINAL_REQUEST R1, PROJECT F4 | 5 | 5 | ✓ | ✓ |
| 4 | Settings UI | ORIGINAL_REQUEST R1, PROJECT F2 | 5 | 5 | ✓ | ✓ |
| 5 | Reminders | PROJECT F7 | 5 | 5 | ✓ | ✓ |
| 6 | Shortcuts | PROJECT F5, F7 | 5 | 5 | ✓ | ✓ |
| 7 | Chat UI | PROJECT F6, F8 | 5 | 5 | ✓ | ✓ |

## Test Architecture
- Test runner: `flutter test`
- Test case format: Flutter `test` / `testWidgets` with unit/integration harnesses
- Directory layout:
  - `test/pet_config_test.dart`: Custom Avatar setting & PetConfig persistence tests
  - `test/roaming_logic_test.dart`: Roaming mechanics & physics tests
  - `test/settings_ui_test.dart`: Settings UI & Avatar selection tests
  - `test/reminders_test.dart`: Reminders management & scheduling tests
  - `test/shortcuts_test.dart`: Shortcuts management & hotkey tests
  - `test/chat_ui_test.dart`: Chat UI & messaging tests
  - `test/e2e_test.dart`: Tier 2 Boundary, Tier 3 Cross-Feature, and Tier 4 Workflows

## Coverage Thresholds
- Tier 1: Feature Coverage (≥5 tests per feature across 7 features = ≥35 tests minimum)
- Tier 2: Boundary & Corner Cases (empty inputs, missing image files, invalid paths, rapid menu toggles)
- Tier 3: Cross-Feature Combinations (avatar change while active, hotkey triggers, notifications)
- Tier 4: Real-World Application Workflows (complete end-to-end application scenarios)
