import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure wrapper for the AI API key.
/// SECURITY GUARANTEES:
///   - Key is stored ONLY in flutter_secure_storage (Windows DPAPI-encrypted)
///   - Key is NEVER passed to print(), debugPrint(), log(), or any logger
///   - Key is NEVER included in exception messages
///   - Key is NEVER hardcoded in source
///   - UI shows only last 4 characters as '****xxxx'
class SecureKeyStorage {
  static const _storage = FlutterSecureStorage(
    wOptions: WindowsOptions(useBackwardCompatibility: false),
  );

  static const _keyName = 'gemini_api_key';
  static const _baseUrlKey = 'ai_base_url';
  static const _modelKey = 'ai_model';
  static const _onboardingKey = 'has_completed_onboarding';
  static const _themeKey = 'is_dark_mode';

  // Default Gemini free-tier endpoint
  static const defaultBaseUrl =
      'https://generativelanguage.googleapis.com/v1beta/openai';
  static const defaultModel = 'gemini-1.5-flash';

  // ── API Key ───────────────────────────────────────────────────────────────

  /// Save API key securely. Never log the value.
  static Future<void> saveApiKey(String key) async {
    await _storage.write(key: _keyName, value: key);
    // DO NOT log 'key' here or anywhere in this class
  }

  /// Read API key from secure storage.
  static Future<String?> getApiKey() async {
    return _storage.read(key: _keyName);
  }

  /// Delete stored API key.
  static Future<void> deleteApiKey() async {
    await _storage.delete(key: _keyName);
  }

  /// Returns a masked version safe for display: '****xxxx'
  static Future<String> getMaskedKey() async {
    final key = await getApiKey();
    if (key == null || key.length < 4) return key == null ? 'Not set' : '****';
    final last4 = key.substring(key.length - 4);
    return '****$last4';
  }

  // ── Base URL ──────────────────────────────────────────────────────────────

  static Future<void> saveBaseUrl(String url) async {
    await _storage.write(key: _baseUrlKey, value: url);
  }

  static Future<String> getBaseUrl() async {
    return (await _storage.read(key: _baseUrlKey)) ?? defaultBaseUrl;
  }

  // ── Model name ────────────────────────────────────────────────────────────

  static Future<void> saveModel(String model) async {
    await _storage.write(key: _modelKey, value: model);
  }

  static Future<String> getModel() async {
    return (await _storage.read(key: _modelKey)) ?? defaultModel;
  }

  // ── Onboarding ────────────────────────────────────────────────────────────

  static Future<void> completeOnboarding() async {
    await _storage.write(key: _onboardingKey, value: 'true');
  }

  static Future<bool> hasCompletedOnboarding() async {
    final value = await _storage.read(key: _onboardingKey);
    return value == 'true';
  }

  // ── Theme ─────────────────────────────────────────────────────────────────

  static Future<void> setDarkMode(bool isDark) async {
    await _storage.write(key: _themeKey, value: isDark.toString());
  }

  static Future<bool> isDarkMode() async {
    final value = await _storage.read(key: _themeKey);
    return value != 'false'; // Default to true if not set
  }
}
