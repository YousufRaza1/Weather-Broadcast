import 'package:flutter/material.dart';
import 'WeatherModel.dart'; // Assuming your model is here
import 'WeatherScreenViewModel.dart';
import 'SearchListScreen.dart';
import 'CityWeatherModel.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<WeatherDetails?> futureWeather;
  late Future<HourlyWelcome?> hourlyWeather;
  final viewModel = WeatherViewModel();
  String currentCity = 'Dhaka';

  void _updateCityName(String newValue) {
    setState(() {
      currentCity = newValue;
    });
    futureWeather = viewModel.fetchWeather(currentCity);
    hourlyWeather = viewModel.fetchWeatherForecast(currentCity);
  }

  @override
  void initState() {
    super.initState();
    futureWeather = viewModel
        .fetchWeather(currentCity); // You can replace with a dynamic city
    hourlyWeather = viewModel.fetchWeatherForecast(currentCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchListScreen(
                          onUpdate:
                              _updateCityName)), // Replace with your target screen
                );
              },
              icon: Icon(Icons.search))
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          FutureBuilder<WeatherDetails?>(
            future: futureWeather,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: 350,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data != null) {
                WeatherDetails weatherData = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Weather icon
                      if (weatherData.weather != null &&
                          weatherData.weather!.isNotEmpty)
                        Image.network(
                          'https://openweathermap.org/img/wn/${weatherData.weather![0].icon}@4x.png',
                          width: 50,
                          height: 50,
                        ),
                      SizedBox(height: 10),
                      // City Name
                      if (weatherData.name != null)
                        Text(
                          weatherData.name!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                      SizedBox(height: 10),
                      // Temperature
                      if (weatherData.main?.temp != null)
                        Text(
                          '${weatherData.main!.temp!.toStringAsFixed(1)} °C',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      SizedBox(height: 10),
                      // Weather description
                      if (weatherData.weather != null &&
                          weatherData.weather!.isNotEmpty)
                        Text(
                          weatherData.weather![0].description!.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      SizedBox(height: 15),
                      // Additional Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _weatherInfoTile(
                            icon: Icons.wind_power,
                            label: 'Wind',
                            value: '${weatherData.wind?.speed ?? '-'} m/s',
                          ),
                          _weatherInfoTile(
                            icon: Icons.water_drop,
                            label: 'Humidity',
                            value: '${weatherData.main?.humidity ?? '-'}%',
                          ),
                          _weatherInfoTile(
                            icon: Icons.speed,
                            label: 'Pressure',
                            value: '${weatherData.main?.pressure ?? '-'} hPa',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: Text('No data found.'));
              }
            },
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [Text('Hourly Weather'), Spacer()],
            ),
          ),
          FutureBuilder<HourlyWelcome?>(
              future: hourlyWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final hourlyWeather = snapshot.data!.list;
                  print(hourlyWeather!.length);
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 14, right: 14),
                    child: Column(
                      children: List.generate(
                        hourlyWeather!.length,
                        (index) {
                          List<String> formatted = viewModel.formatDateTime(
                              hourlyWeather[index].dtTxt.toString());
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, top: 16, bottom: 16),
                                height: 80,
                                width: double.infinity,

                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  color: Colors.white60
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(formatted[0]),
                                        SizedBox(height: 8),
                                        Text(formatted[1])
                                      ],
                                    ),
                                    Image.network(
                                      'https://openweathermap.org/img/wn/${hourlyWeather[index].weather![0].icon}@4x.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                            '${viewModel.kelvinToCelsius(hourlyWeather[index].main!.temp!)}° feels like ${viewModel.kelvinToCelsius(hourlyWeather[index].main!.feelsLike!)}°'),
                                        Text(
                                            '${hourlyWeather[index].weather![0].description}')
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          child: Image.asset('assets/img.png',
                                              fit: BoxFit.fill),
                                        ),
                                        Icon(Icons.cloudy_snowing)
                                      ],
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text(
                                            '${hourlyWeather[index].wind!.speed!} km/h'),
                                        Text(
                                            '${hourlyWeather[index].clouds!.all!} %')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10)
                            ],
                          );
                        },
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return Text('');
                }
              })
        ],
      )),
    );
  }

  Widget _weatherInfoTile(
      {required IconData icon, required String label, required String value}) {
    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: Colors.blueAccent,
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
