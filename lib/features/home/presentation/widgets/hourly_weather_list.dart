import 'package:flutter/material.dart';
import '../../domain/entities/weather_model.dart';

class HourlyWeatherList extends StatelessWidget {
  final List<HourlyListElement> hourlyWeather;
  final String Function(DateTime) formatDate;
  final String Function(double) kelvinToCelsius;

  const HourlyWeatherList({
    Key? key,
    required this.hourlyWeather,
    required this.formatDate,
    required this.kelvinToCelsius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String savedDate = '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: List.generate(
          hourlyWeather.length,
              (index) {
            final hourlyData = hourlyWeather[index];
            final formattedDate = formatDate(DateTime.parse(hourlyData.dtTxt! as String));
            final isNewDate = formattedDate != savedDate;
            savedDate = formattedDate;

            return Column(
              children: [
                if (isNewDate)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Text(
                          formattedDate,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(formatDate(
                            DateTime.parse(hourlyData.dtTxt! as String),
                          )
                          ),
                          const SizedBox(height: 5),
                          Image.network(
                            'https://openweathermap.org/img/wn/${hourlyData.weather![0].icon}@4x.png',
                            width: 40,
                            height: 35,
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${kelvinToCelsius(hourlyData.main!.temp!)}° feels like ${kelvinToCelsius(hourlyData.main!.feelsLike!)}°',
                            ),
                            const SizedBox(height: 5),
                            Text(hourlyData.weather![0].description ?? ''),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Image.asset(
                            'assets/img.png',
                            height: 20,
                            width: 20,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 5),
                          const Icon(Icons.cloudy_snowing),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${hourlyData.wind?.speed} km/h'),
                          Text('${hourlyData.clouds?.all} %'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
