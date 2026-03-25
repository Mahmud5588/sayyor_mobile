import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage(this._preferences);

  static const String _userSelectionKey = 'user_selection';
  static const String _themeModeKey = 'theme_mode';
  final SharedPreferences _preferences;

  String? get userSelection => _preferences.getString(_userSelectionKey);

  Future<void> setUserSelection(String value) async {
    await _preferences.setString(_userSelectionKey, value);
  }

  Future<void> clearUserSelection() async {
    await _preferences.remove(_userSelectionKey);
  }

  String get themeMode => _preferences.getString(_themeModeKey) ?? 'system';

  Future<void> setThemeMode(String value) async {
    await _preferences.setString(_themeModeKey, value);}
}
