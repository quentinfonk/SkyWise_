import 'package:flutter/material.dart';
import 'package:skywise/hourly_weather_class.dart';

class HourlyWeather extends StatefulWidget {
  HourlyWeather(
      {Key? key, required this.hourlyWeather, required this.selectedDay})
      : super(key: key);

  List<HourlyWeatherClass> hourlyWeather;
  int selectedDay;

  @override
  HourlyWeatherState createState() => HourlyWeatherState();
}

class HourlyWeatherState extends State<HourlyWeather>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.56, // ici pour taille écran
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            child: allHourly(),
          ),
        ]),
      ),
    );
  }

  Widget allHourly() {
    List<Widget> list = [];

    if (widget.hourlyWeather.isEmpty && widget.hourlyWeather.length != 120) {
      return Container();
    }
    for (int i = widget.selectedDay * 24, x = i + 24; i != x; i++) {
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: listHourly(widget.hourlyWeather[i]),
      ));
    }

    return Column(
      children: list,
    );
  }

  Widget listHourly(HourlyWeatherClass x) {
    return Row(
      children: [
        const SizedBox(
          width: 45,
        ),
        Text(
          x.hourlyTime.substring(11, 16),
          style: const TextStyle(fontSize: 20),
        ),
        const Spacer(),
        Text(
          x.hourlyTemperature,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 45,
        ),
      ],
    );
  }
}
