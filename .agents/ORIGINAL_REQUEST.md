# Original User Request

## 2026-08-10T00:42:56Z

Review and stabilize the entire Desktop Pet application while implementing the new Custom Pet Avatar feature.

Working directory: `C:\Users\anmay\Desktop\Coding Rockerz\desktop_pet`
Integrity mode: development

## Requirements

### R1. Custom Pet Avatar Implementation
Replace the existing WhatsApp Sticker export feature with a "Custom Pet Avatar" setting. The user should be able to upload a local image (PNG/JPG) which will completely replace the default Rive animation (the car). The custom image must roam around the screen exactly like the original pet.

### R2. Global Application Review
Review the entire desktop pet application to ensure everything is functioning correctly. Identify and resolve any rendering errors (such as UI overflows) and runtime exceptions. Do not hesitate to fix bugs found across any file.

## Acceptance Criteria

### Implementation Quality
- [ ] The "Custom Pet Avatar" feature works locally: an image can be selected, saved to `Storage`, and rendered dynamically in `pet_window.dart`.
- [ ] The app compiles and launches successfully via `flutter run -d windows`.
- [ ] The application logs show no unhandled exceptions or layout overflow warnings during standard interactions (opening settings, moving the pet).
