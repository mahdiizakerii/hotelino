import 'package:shared_preferences/shared_preferences.dart';

class TabStroageService {
  static const String _selectedKey = 'selesctedTab';
  static Future<void> savedSelectedTab(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_selectedKey, index);
  }

  static Future<int> getSelectedTab() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_selectedKey) ?? 0;
  }
}
