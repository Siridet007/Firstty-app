import 'dart:async';

import 'package:firstty_app/weather/api.dart';
import 'package:firstty_app/weather/weathermodel.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController searchBar = TextEditingController();
  double? width;
  double? height;
  GetWeather? response;
  bool inProgress = false;
  String message = "Search for the location to get weather data";
  String format = '';

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        format = DateFormat('HH:mm').format(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchWidget(),
              const Padding(padding: EdgeInsets.only(top: 20)),
              inProgress
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: SingleChildScrollView(
                        child: _buildWeatherWidget(),
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              inProgress = true;
            });
            WeatherApi().determinePosition().then((value) async {
              //print(value);
              List<Placemark> placemarks = await placemarkFromCoordinates(
                value.latitude,
                value.longitude,
              );
              searchBar.text = placemarks.first.administrativeArea!
                  .replaceAll("Chang Wat ", "");
              _getWeatherData(placemarks.first.administrativeArea!
                  .replaceAll("Chang Wat ", ""));
            });
          },
          child: const Icon(Icons.my_location_outlined),
        ),
      ),
    );
  }

  Widget _buildWeatherWidget() {
    if (response == null) {
      return Text(message);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                size: 50,
              ),
              Text(
                response!.location!.name ?? "",
                style: const TextStyle(fontSize: 40),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                response!.location!.country ?? "",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${response!.current!.tempC.toString()}  ํc",
                  style: const TextStyle(fontSize: 60),
                ),
              ),
              Text(
                response!.current!.condition!.text.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: 200,
              child: Image.network(
                "https:${response!.current!.condition!.icon}"
                    .replaceAll("64x64", "128x128"),
                scale: 0.7,
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.purple[50],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _dataAndTitleWidget(
                        "Humidity",
                        '${response!.current!.humidity!.toString()}%',
                      ),
                    ),
                    Expanded(
                      child: _dataAndTitleWidget(
                        "Wind Speed",
                        '${response!.current!.windKph!.toString()} km/h',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _dataAndTitleWidget(
                        "UV",
                        response!.current!.uv!.toString(),
                      ),
                    ),
                    Expanded(
                      child: _dataAndTitleWidget(
                        "Percipitation",
                        '${response!.current!.precipMm!.toString()} mm',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _dataAndTitleWidget(
                        "Local Time",
                        response!.location!.localtime!.split(" ").last,
                      ),
                    ),
                    Expanded(
                      child: _dataAndTitleWidget(
                        "Local Date",
                        DateFormat('dd MMM yyyy').format(
                          DateTime.parse(
                            response!.location!.localtime!.split(" ").first,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _dataAndTitleWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(
              fontSize: 27,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 27,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width! * .8,
          child: TextField(
            controller: searchBar,
            style: const TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onSubmitted: (value) {
              _getWeatherData(value);
            },
          ),
        ),
      ],
    );
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });
    if (location.isEmpty) {
      setState(() {
        inProgress = false;
        message = "Search for the location to get weather data";
        response = null;
      });
    } else {
      try {
        response = await WeatherApi().getCurrentWeather(location);
      } catch (e) {
        message = "Failed to get weather";
        response = null;
      } finally {
        setState(() {
          inProgress = false;
        });
      }
    }
  }
}
