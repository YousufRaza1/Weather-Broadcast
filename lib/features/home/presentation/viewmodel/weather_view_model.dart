// presentation/viewmodels/weather_view_model.dart
import 'package:flutter/material.dart';
import '../../domain/entities/city_weather_model.dart';
import '../../domain/entities/weather_model.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../data/repositories/weather_repository_impl.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository repository;

  WeatherViewModel({
    WeatherRepository? repository,
  }) : repository = repository ?? WeatherRepositoryImpl();

  WeatherDetails? currentWeather;
  HourlyWelcome? forecast;
  bool isLoading = false;

  Future<void> loadWeather(String cityName) async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch weather details directly from the repository
      currentWeather = await repository.fetchWeather(cityName);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadForecast(String cityName) async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch forecast details directly from the repository
      forecast = await repository.fetchWeatherForecast(cityName);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
