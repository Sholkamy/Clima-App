import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '6e722a63fee4ec99e4aeb7d044f5cdaa';
const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    // Get Data from Api
    //This Definition of Class NetworkHelper
    NetworkHelper networkHelper = NetworkHelper(
        url: '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    //Call getDate function in weatherDate
    var weatherDate = await networkHelper.getDate();
    return weatherDate;
  }

  Future<dynamic> getLocationWeather() async {
    // To get lat and long
    Location location = Location();
    await location.getCurrentLocation();

    // Get Data from Api
    //This Definition of Class NetworkHelper
    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    //Call getDate function in weatherDate
    var weatherDate = await networkHelper.getDate();
    return weatherDate;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
