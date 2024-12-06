// data/datasources/remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/city_weather_model.dart';
import '../../domain/entities/weather_model.dart';

class RemoteDataSource {
  final String apiKey = '0e467e5c6beceddf2be0be537b297025';

  Future<WeatherDetails?> fetchWeather(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return WeatherDetails.fromRawJson(response.body);
    } else {
      throw Exception('Error fetching weather: ${response.statusCode}');
    }
  }

  Future<HourlyWelcome?> fetchWeatherForecast(String cityName) async {
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return HourlyWelcome.fromRawJson(response.body);
    } else {
      throw Exception('Error fetching forecast: ${response.statusCode}');
    }
  }
}
