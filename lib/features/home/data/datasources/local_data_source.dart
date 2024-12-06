// data/datasources/local_data_source.dart
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  Future<void> cacheWeatherData(String key, String jsonData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonData);
  }

  Future<String?> getCachedWeatherData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveSearchedCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cities = prefs.getStringList('SavedCityList');
    if (cities == null) cities = [];
    cities.add(cityName);
    prefs.setStringList('SavedCityList', cities.toSet().toList());
  }
}
