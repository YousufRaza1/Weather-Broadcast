import 'package:flutter/material.dart';
import 'WeatherModel.dart'; // Assuming your model is here
import 'WeatherScreenViewModel.dart';
import 'SearchListScreen.dart';


class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Welcome?> futureWeather;
  final viewModel = WeatherViewModel();
  String currentCity = 'Dhaka';

  void _updateCityName(String newValue) {
    setState(() {
      currentCity = newValue;
    });
    futureWeather = viewModel.fetchWeather(currentCity);
  }

  @override
  void initState() {
    super.initState();
    futureWeather = viewModel.fetchWeather(currentCity); // You can replace with a dynamic city
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
                  MaterialPageRoute(builder: (context) => SearchListScreen(onUpdate: _updateCityName)), // Replace with your target screen
                );

              },
              icon: Icon(Icons.search)
          )
        ],

        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<Welcome?>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            Welcome weatherData = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Weather icon
                    Image.network(
                      'https://openweathermap.org/img/wn/${weatherData.weather[0].icon}@4x.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(height: 10),
                    // City Name
                    Text(
                      weatherData.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Temperature
                    Text(
                      '${weatherData.main.temp.toStringAsFixed(1)} °C',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Weather description
                    Text(
                      weatherData.weather[0].description.toUpperCase(),
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
                          value: '${weatherData.wind.speed} m/s',
                        ),
                        _weatherInfoTile(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: '${weatherData.main.humidity}%',
                        ),
                        _weatherInfoTile(
                          icon: Icons.speed,
                          label: 'Pressure',
                          value: '${weatherData.main.pressure} hPa',
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          print(currentCity);
                        },
                        child: Text('print city')
                    )
                  ],
                ),

              ),
            );
          } else {
            return Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }

  Widget _weatherInfoTile({required IconData icon, required String label, required String value}) {
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


