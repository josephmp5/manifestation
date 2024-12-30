import 'package:shared_preferences/shared_preferences.dart';

class ManifestationRepository {
  static const String key = 'manifestations';

  // Save the list of manifestations locally
  Future<void> saveManifestations(List<String> manifestations) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, manifestations);
  }

  // Load the list of manifestations from local storage
  Future<List<String>> loadManifestations() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }
}
