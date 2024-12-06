import 'package:flutter/material.dart';
import '../viewmodel/weather_view_model.dart';
import '../../../../BaseModule/MainWeatherScreen/View/SearchListScreen.dart';
import '../widgets/weather_details_widget.dart';
import '../widgets/hourly_weather_list.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherViewModel viewModel = WeatherViewModel();

  String currentCity = 'Dhaka';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  void _loadWeatherData() {
    setState(() => isLoading = true);
    viewModel.loadWeather(currentCity).then((_) {
      setState(() => isLoading = false);
    });
    viewModel.loadForecast(currentCity).then((_) {
      setState(() => isLoading = false);
    });
  }

  void _updateCityName(String newValue) {
    setState(() {
      currentCity = newValue;
    });
    _loadWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchListScreen(onUpdate: _updateCityName),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display weather details or loading indicator
            if (isLoading)
              const SizedBox(
                height: 350,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (viewModel.currentWeather != null)
              WeatherDetailsWidget(weatherData: viewModel.currentWeather!)
            else
              const Center(child: Text('No weather data available.')),

            // Hourly Weather Section Header
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [Text('Hourly Weather'), Spacer()],
              ),
            ),

            // Hourly Weather List or Loading/No Data Indicator
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (viewModel.forecast != null)
              HourlyWeatherList(
                hourlyWeather: viewModel.forecast!.list!,
                formatDate: (date) {
                  // Example: Format date as "HH:mm, EEEE"
                  return '${date.hour}:${date.minute.toString().padLeft(2, '0')} on ${date.weekday}';
                },
                kelvinToCelsius: (temp) {
                  // Convert Kelvin to Celsius
                  return (temp - 273.15).toStringAsFixed(1);
                },
              )
            else
              const Center(child: Text('No forecast data available.')),
          ],
        ),
      ),
    );
  }
}
