import 'package:http/http.dart' as http;
import '../Model/WeatherModel.dart';
import 'package:intl/intl.dart';
import '../Model/CityWeatherModel.dart';
import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class WeatherViewModel {
  Future<bool> hasConnection() async {
    return await InternetConnection().hasInternetAccess;
  }

  Future<WeatherDetails?> fetchWeather(String cityName) async {
    const apiKey =
        '0e467e5c6beceddf2be0be537b297025'; // Replace with your API key
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    final isConnected = await hasConnection();
    print(isConnected);
    if (isConnected == true) {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        String jsonString = jsonEncode(response.body);
        addWeatherByCityName(jsonString, cityName);


        saveListOfSearchedCityName(cityName);

        return WeatherDetails.fromRawJson(response.body);
      } else {
        throw Exception(
            'Failed to load weather data: ${response.statusCode} ${response.reasonPhrase}');
      }
    } else {
      String? weather = await getWeatherFromCityName(cityName);
      print('weather form local data = $weather');

      if (weather != null) {
        final json = jsonDecode(weather);
        return WeatherDetails.fromRawJson(json);
      } else {
        throw Exception('Failed to load weather data');
      }
    }
  }

  Future<HourlyWelcome?> fetchWeatherForecast(String city) async {
    final apiKey = 'dc5faa7ba47bb772d5f0245345af9624';
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey');

    final isConnected = await hasConnection();
    print(isConnected);
    if (isConnected == true) {
      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          String jsonString = jsonEncode(response.body);
          addWeatherByCityName(jsonString, '${city}Hourly');

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
    } else {
      String? weather = await getWeatherFromCityName('${city}Hourly');
      print('weather form local data = $weather');

      if (weather != null) {
        final json = jsonDecode(weather);
        return HourlyWelcome.fromRawJson(json);
      } else {
        throw Exception('Failed to load weather data');
      }
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
    return celsius.round(); // Use .round() to get the nearest integer
  }

  addWeatherByCityName(String jsonString, String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(cityName, jsonString);
  }

  Future<String?> getWeatherFromCityName(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString(cityName);
    print('successfully get');
    return jsonString;
  }

  saveListOfSearchedCityName(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? listOfCity = prefs.getStringList('SavedCityList');
    if (listOfCity == null) {
      List<String> savedCityName = [cityName];
      await prefs.setStringList('SavedCityList', savedCityName);
    } else {
      List<String> savedCityName = listOfCity!;
      savedCityName.add(cityName);
      Set<String> setOfCity = savedCityName.toSet();
      savedCityName = setOfCity.toList();

      await prefs.setStringList('SavedCityList', savedCityName);
    }
  }

  removeAllDataForKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('SavedCityList');
  }
}
