import 'package:flutter/material.dart';
import '../services/network.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/location.dart';
import 'city_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location location = Location(); // Instantiate the Location class

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    // Get current location data
    await location.getCurrentLocation();

    // Get weather data using the fetched latitude and longitude
    var weatherData = await getCityWeather(location.latitude, location.longitude);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
          );
        },
      ),
    );
  }

  Future<dynamic> getCityWeather(double latitude, double longitude) async {
    final String weatherUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=56bf08b0d9522be3ececf8dd981e50b7&units=metric";

    NetworkHelper networkHelper = NetworkHelper(weatherUrl);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.09),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
