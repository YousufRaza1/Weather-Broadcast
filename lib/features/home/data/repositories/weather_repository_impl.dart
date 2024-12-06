// data/repositories/weather_repository_impl.dart
import '../../domain/repositories/weather_repository.dart';
import '../../domain/entities/city_weather_model.dart';
import '../../domain/entities/weather_model.dart';
import '../datasources/remote_data_source.dart';
import '../datasources/local_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource = RemoteDataSource();
  final LocalDataSource localDataSource = LocalDataSource();

  @override
  Future<WeatherDetails?> fetchWeather(String cityName) async {
    try {
      final weather = await remoteDataSource.fetchWeather(cityName);
      if (weather != null) {
        localDataSource.cacheWeatherData(cityName, weather.toRawJson());
        localDataSource.saveSearchedCity(cityName);
      }
      return weather;
    } catch (_) {
      final cachedData = await localDataSource.getCachedWeatherData(cityName);
      if (cachedData != null) {
        return WeatherDetails.fromRawJson(cachedData);
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<HourlyWelcome?> fetchWeatherForecast(String cityName) async {
    try {
      final forecast = await remoteDataSource.fetchWeatherForecast(cityName);
      if(forecast != null) {
        localDataSource.cacheWeatherData(
            '${cityName}Hourly', forecast.toRawJson());
      }
      return forecast;
    } catch (_) {
      final cachedData =
          await localDataSource.getCachedWeatherData('${cityName}Hourly');
      if (cachedData != null) {
        return HourlyWelcome.fromRawJson(cachedData);
      } else {
        rethrow;
      }
    }
  }
}
