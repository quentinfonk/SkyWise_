import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skywise/currently_weather.dart';
import 'package:skywise/currently_weather_class.dart';
import 'package:skywise/daily_weather_class.dart';
import 'package:skywise/hourly_weather_class.dart';
import 'package:skywise/weather.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CurentlyWeatherClass currentWeather = CurentlyWeatherClass(
      currentTempeture: '',
      currentWindspeed: '',
      currentWindDirection: '',
      weathercode: '');
  List<HourlyWeatherClass> hourlyWeather = <HourlyWeatherClass>[];
  List<DailyWeatherClass> dailyWeather = <DailyWeatherClass>[];
  String cityName = 'Cardiff';

  @override
  void initState() {
    super.initState();
    HttpOverrides.global = MyHttpOverrides(); // that fix error certificate
    callData();
    setState(() {});
  }

  void callData() async {
    List<Object> stock = await getData(51.5, -3.19);
    currentWeather = stock[0] as CurentlyWeatherClass;
    hourlyWeather = stock[1] as List<HourlyWeatherClass>;
    dailyWeather = stock[2] as List<DailyWeatherClass>;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              CurrentlyWeather(
                  currentWeather: currentWeather,
                  dailyWeather: dailyWeather,
                  hourlyWeather: hourlyWeather,
                  cityName: cityName),
            ],
          ),
        ));
  }
}
