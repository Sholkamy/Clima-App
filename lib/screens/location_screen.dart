import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'city_screen.dart';
import 'package:clima/services/weather.dart';

class LocationScreen extends StatefulWidget {
  //get weatherDate from Loading Screen
  LocationScreen({@required this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String weatherIcon;
  int temperature;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherDate) {
    if (weatherDate == null) {
      temperature = 0;
      weatherIcon = 'Error';
      weatherMessage = 'unable to get weather data';
      cityName = '';
      return;
    } else {
      double temp = weatherDate['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);
      int condition = weatherDate['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherDate['name'];
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      dynamic weatherDate = await weather.getLocationWeather();
                      updateUI(weatherDate);
                    },
                    child: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 45.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String typeName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      print(typeName);
                      if (typeName != null) {
                        var weatherData =
                            await weather.getCityWeather(typeName);
                        print(weatherData);
                        setState(() {
                          updateUI(weatherData);
                        });
                      } else {
                        setState(() {
                          updateUI(null);
                        });
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Colors.white,
                      size: 45.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature??',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
