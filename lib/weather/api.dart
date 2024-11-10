import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firstty_app/weather/constants.dart';
import 'package:firstty_app/weather/weathermodel.dart';
import 'package:geolocator/geolocator.dart';

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<GetWeather?> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await Dio().get(apiUrl);
      if (response.statusCode == 200) {
        return GetWeather.fromJson(response.data);
      } else {
        throw Exception("Failed to load weather: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load weather: $e");
    }
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> getDataFromPinCode(String pinCode) async {
    final url = "http://www.postalpincode.in/api/pincode/$pinCode";

    try {
      final response = await Dio().get(url);
      print(response);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.data);

        if (jsonResponse['Status'] == 'Error') {
          // Show a snackbar if the PIN code is not valid
          return 'Pin code is not valid.';
        } else {
          // Parse and display details if the PIN code is valid
          final postOfficeArray = jsonResponse['PostOffice'] as List;
          final obj = postOfficeArray[0];

          final district = obj['District'];
          final state = obj['State'];
          final country = obj['Country'];

          return 'Details of pin code are:\nDistrict: $district\nState: $state\nCountry: $country';
        }
      } else {
        // Show a snackbar if there is an issue fetching data

        return 'Failed to fetch data. Please try again.';
      }
    } catch (e) {
      // Show a snackbar if an error occurs during the API call

      return 'Error occurred. Please try again.';
    }
  }
}
