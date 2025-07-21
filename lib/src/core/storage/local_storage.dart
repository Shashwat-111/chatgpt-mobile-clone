import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const _key = 'selectedModel';
  static const _defaultModel = 'gpt-3.5';

  /// Save model as string
  static Future<void> setSelectedModel(String model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, model);
  }

  /// Get the currently selected model or default
  static Future<String> get selectedModel async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? _defaultModel;
  }
}
