import 'package:flutter/material.dart';
import 'weather_info_tile.dart';
import '../../domain/entities/city_weather_model.dart';

class WeatherDetailsWidget extends StatelessWidget {
  final WeatherDetails weatherData;

  const WeatherDetailsWidget({Key? key, required this.weatherData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (weatherData.weather != null && weatherData.weather!.isNotEmpty)
            Image.network(
              'https://openweathermap.org/img/wn/${weatherData.weather![0].icon}@4x.png',
              width: 50,
              height: 50,
            ),
          const SizedBox(height: 10),
          if (weatherData.name != null)
            Text(
              weatherData.name!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          const SizedBox(height: 10),
          if (weatherData.main?.temp != null)
            Text(
              '${weatherData.main!.temp!.toStringAsFixed(1)} °C',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(height: 10),
          if (weatherData.weather != null && weatherData.weather!.isNotEmpty)
            Text(
              weatherData.weather![0].description!.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeatherInfoTile(
                icon: Icons.wind_power,
                label: 'Wind',
                value: '${weatherData.wind?.speed ?? '-'} m/s',
              ),
              WeatherInfoTile(
                icon: Icons.water_drop,
                label: 'Humidity',
                value: '${weatherData.main?.humidity ?? '-'}%',
              ),
              WeatherInfoTile(
                icon: Icons.speed,
                label: 'Pressure',
                value: '${weatherData.main?.pressure ?? '-'} hPa',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
