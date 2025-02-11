import 'package:shared_preferences/shared_preferences.dart';

class ProfileIconManager {
  static const String _key = "selected_profile_icon";

  static Future<void> saveSelectedIcon(String iconPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, iconPath);
  }

  static Future<String> getSelectedIcon() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? 'assets/images/iconProfile.png';
  }
}
