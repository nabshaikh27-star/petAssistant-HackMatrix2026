# Desktop Pet AI Assistant 🐾

An intelligent, interactive desktop companion built with Flutter for Windows. Your pet lives on your desktop, floating above your windows, ready to help you with tasks, remind you of important events, and chat with you using the power of Google Gemini.

## ✨ Features
- **Always on Top:** A draggable, frameless pet that floats on your screen (transparent background).
- **Global Hotkey:** Press `Alt + B` from anywhere to summon your pet to the front or toggle visibility.
- **AI Chat Integration:** Talk directly to your pet using Gemini 2.5 Flash. Fully aware of screenshots if you choose to attach them.
- **Offline Reliability:** Core features like Reminders, Birthdays, Alarms, Quick Access, and Hotkeys work completely offline. AI Chat gracefully handles network disconnections.
- **Custom Avatars:** Don't like the default pet? Upload your own PNG/JPG avatar! It comes to life with dynamic physical animations:
  - **Idle:** Gentle floating/bobbing.
  - **Talking:** Rhythmic pulsing when the chat window is open.
  - **Alert:** Rapid shaking when a reminder triggers.
- **Quick Access Radial Menu:** Double-tap or triple-tap the pet to quickly launch paths, folders, or URLs!
- **Dynamic Theming:** Beautiful Light and Dark "Cyber-Glass" mode (glassmorphism UI) toggled instantly in settings.
- **WhatsApp Sticker Export:** Export your custom pet into a neat sticker-ready format.

---

## 🚀 Setup & Installation

### Prerequisites
Because this is a Flutter Desktop application for Windows that relies on advanced window manipulation, system tray integration, and global hotkeys, you must install native build tools.

1. **Install Flutter SDK** (version 3.5.0 or newer).
2. **Install Microsoft Visual Studio Build Tools:**
   - Download the Visual Studio 2022 Installer.
   - Select **"Desktop development with C++"**.
   - **CRITICAL:** Ensure that **"C++ ATL for latest v143 build tools (x86 & x64)"** is checked! This is required by the `hotkey_manager` and `screen_capturer` plugins.
3. **Run Flutter Doctor** to verify Windows desktop support:
   ```bash
   flutter doctor
   ```

### Building the App
1. Clone this repository.
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app in debug mode:
   ```bash
   flutter run -d windows
   ```
4. Build the release `.exe`:
   ```bash
   flutter build windows
   ```

---

## 🔒 Security: How Your Gemini API Key is Handled
We take your API key security extremely seriously. 

1. **No Backend or Servers:** This application connects directly from your machine to Google's official Gemini REST API (`generativelanguage.googleapis.com`). No middleman server is used.
2. **Secure Local Storage:** The API key is stored using the `flutter_secure_storage` package. On Windows, this relies entirely on the native **Windows Data Protection API (DPAPI)** and the **Windows Credential Locker**.
3. **No Logging:** Your key is explicitly masked in any UI fields (e.g. `obscureText: true`) and is never printed to standard output or log files.
4. **Where it lives:** `lib/ai_assistant/key_storage.dart`. You can review the exact implementation to verify that it is pulled out of secure storage just-in-time for HTTP requests and immediately discarded from memory.

---

## 🧪 Testing
The `test/` directory contains unit tests verifying:
- **Reminder CRUD & Scheduler Logic:** Ensures alarms fire precisely when they should (daily, weekly, birthdays).
- **Screen Capture Privacy Flow:** Validates that the capture prompt strictly defaults to denying permission unless explicitly allowed.
- **Tap Detector Timing:** Ensures single, double, and triple taps resolve accurately.

Run tests via:
```bash
flutter test
```
