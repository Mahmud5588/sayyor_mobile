import 'package:shared_preferences/shared_preferences.dart';











class OnboardingStorage {
  static const String _onboardedKey = 'onboarded';

  
  
  
  Future<bool> isOnboarded() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_onboardedKey) ?? false;
    } catch (e) {
      print('OnboardingStorage error: $e');
      return false;
    }
  }

  
  
  
  Future<void> setOnboarded(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardedKey, value);
    } catch (e) {
      print('OnboardingStorage error: $e');
    }
  }

  
  
  
  Future<void> resetOnboarding() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_onboardedKey);
    } catch (e) {
      print('OnboardingStorage error: $e');
    }
  }
}
