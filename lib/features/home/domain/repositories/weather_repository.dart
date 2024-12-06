// domain/repositories/weather_repository.dart

import '../entities/city_weather_model.dart';
import '../entities/weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherDetails?> fetchWeather(String cityName);
  Future<HourlyWelcome?> fetchWeatherForecast(String cityName);
}
