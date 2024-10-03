

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'WeatherModel.dart';

class WeatherViewModel {

  Future<Welcome?> fetchWeather(String cityName) async {
    const apiKey = '0e467e5c6beceddf2be0be537b297025'; // Replace with your API key
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decoding the response
      return Welcome.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}