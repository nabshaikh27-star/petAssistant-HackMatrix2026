# Project Execution Plan — Desktop Pet

## Objectives
1. Perform complete codebase survey using 3 parallel survey explorers.
2. Formulate `PROJECT.md` with Feature Inventory, Architecture, Code Layout, Interface Contracts, and Milestone Decomposition.
3. Execute Implementation Track:
   - Milestone 1: Remove WhatsApp sticker export feature, implement Custom Pet Avatar setting (image selection, Storage persistence, UI settings).
   - Milestone 2: Update `pet_window.dart` to dynamically render custom avatar image (PNG/JPG) instead of default Rive animation, preserving movement/roaming mechanics.
   - Milestone 3: Global Review & Fixes: Identify and fix all UI overflow warnings and runtime exceptions across screens/widgets.
4. Execute Dual Track E2E Testing:
   - Create requirement-driven opaque-box test runner & test cases (Tiers 1-4).
   - Perform Tier 5 adversarial coverage hardening.
5. Verification & Gating:
   - Dual Reviewers, Dual Challengers, Forensic Auditor (Binary Veto).
   - Verification via `flutter run -d windows` / Flutter test suites.
