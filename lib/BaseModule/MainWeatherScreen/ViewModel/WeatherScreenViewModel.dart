

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/WeatherModel.dart';
import 'package:intl/intl.dart';
import '../Model/CityWeatherModel.dart';

class WeatherViewModel {

  Future<WeatherDetails?> fetchWeather(String cityName) async {
    const apiKey = '0e467e5c6beceddf2be0be537b297025'; // Replace with your API key
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decoding the response
      return  WeatherDetails.fromRawJson(response.body);

    } else {
      throw Exception('Failed to load weather data: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<HourlyWelcome?> fetchWeatherForecast(String city) async {
    final apiKey = 'dc5faa7ba47bb772d5f0245345af9624';
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Successfully received response, now parse the JSON
        print(HourlyWelcome.fromRawJson(response.body).list);
        return HourlyWelcome.fromRawJson(response.body);
      } else {
        // Handle error if the request fails
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  List<String> formatDateTime(String dateTimeString) {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format the time as "hh:mm a"
    String timeFormatted = DateFormat('hh:mm a').format(dateTime);

    // Format the date as "MMM dd"
    String dateFormatted = DateFormat('MMM dd').format(dateTime);

    // Return the formatted time and date as a list of strings
    return [timeFormatted, dateFormatted];
  }

  int kelvinToCelsius(double kelvin) {
    // Convert Kelvin to Celsius
    double celsius = kelvin - 273.15;

    // Return the Celsius value as an integer
    return celsius.round();  // Use .round() to get the nearest integer
  }
}