import 'package:http/http.dart' as http;
import 'package:skywise/currently_weather_class.dart';
import 'package:skywise/daily_weather_class.dart';
import 'dart:convert';

import 'package:skywise/hourly_weather_class.dart';

Future<List<Object>> getData(double pos1, double pos2) async {
  try {
    var response = await http.get(
      Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$pos1&longitude=$pos2&hourly=temperature_2m,weathercode&daily=temperature_2m_max,temperature_2m_min,weathercode,sunrise,sunset&current_weather=true&timezone=GMT'),
    );
    if (response.statusCode == 200) {
      CurentlyWeatherClass currentWeather =
          stockCurrentInfo(jsonDecode(response.body)['current_weather']);
      List<HourlyWeatherClass> hourlyWeather =
          stockHourlyInfo(jsonDecode(response.body)['hourly']);
      List<DailyWeatherClass> dailyWeather =
          stockDailyInfo(jsonDecode(response.body)['daily']);
      return [currentWeather, hourlyWeather, dailyWeather];
    } else {
      print(response.statusCode);
      return [];
    }
  } catch (e) {
    print(e);
  }
  return [];
}

CurentlyWeatherClass stockCurrentInfo(var body) {
  CurentlyWeatherClass currentWeather = CurentlyWeatherClass(
      currentTempeture: (body['temperature']).toString(),
      currentWindspeed: body['windspeed'].toString(),
      currentWindDirection: body['winddirection'].toString(),
      weathercode: body['weathercode'].toString());
  return currentWeather;
}

List<HourlyWeatherClass> stockHourlyInfo(var body) {
  List<HourlyWeatherClass> hourlyWeather = <HourlyWeatherClass>[];

  for (int i = 0; i != body['time'].length; i++) {
    hourlyWeather.add(HourlyWeatherClass(
        hourlyTime: body['time'][i].toString(),
        hourlyWeathercode: body['weathercode'][i].toString(),
        hourlyTemperature: body['temperature_2m'][i].toString()));
  }
  return hourlyWeather;
}

List<DailyWeatherClass> stockDailyInfo(var body) {
  List<DailyWeatherClass> dailyWeather = <DailyWeatherClass>[];
  for (int i = 1; i != body['time'].length; i++) {
    dailyWeather.add(DailyWeatherClass(
        dailyTime: body['time'][i].toString(),
        dailyWeathercode: body['weathercode'][i].toString(),
        dailyMaxTemperature: body['temperature_2m_max'][i].toString(),
        dailyMinTemperature: body['temperature_2m_min'][i].toString(),
        dailySunrise: body['sunrise'][i].toString(),
        dailySunset: body['sunset'][i].toString()));
  }
  return dailyWeather;
}
