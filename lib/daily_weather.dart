import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:skywise/daily_weather_class.dart';
import 'package:skywise/hourly_weather.dart';
import 'package:skywise/hourly_weather_class.dart';

class DailyWeather extends StatefulWidget {
  DailyWeather(
      {Key? key, required this.dailyWeather, required this.hourlyWeather})
      : super(key: key);

  List<DailyWeatherClass> dailyWeather;
  List<HourlyWeatherClass> hourlyWeather;

  @override
  DailyWeatherState createState() => DailyWeatherState();
}

class DailyWeatherState extends State<DailyWeather>
    with WidgetsBindingObserver {
  int selectedDay = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        height: 1,
      ),
      SizedBox(
        height: 60,
        child: allDaily(),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        height: 1,
      ),
      HourlyWeather(
        hourlyWeather: widget.hourlyWeather,
        selectedDay: selectedDay,
      ),
      footer(),
    ]);
  }

  Widget footer() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 255, 245, 63),
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 65, 214, 255),
          height: 35,
        ),
      ],
    );
  }

  Widget allDaily() {
    List<Widget> list = [];
    int i = 0;

    for (DailyWeatherClass x in widget.dailyWeather) {
      // décaler la premiere case, mettre current day
      list.add(boxDaily(x, i));
      i++;
    }

    return Row(
      children: list,
    );
  }

  Widget boxDaily(DailyWeatherClass x, int i) {
    var format = DateFormat('yyyy-mm-dd');
    DateTime time = format.parse(x.dailyTime);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          selectedDay = i;
        });
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 6,
        child: Row(
          children: [
            Container(
              height: 60,
              width: 1,
              color: Colors.black,
            ),
            const Spacer(),
            Column(children: [
              const SizedBox(
                height: 4,
              ),
              Text(
                  '${DateFormat('EEEE').format(time).substring(0, 3)} ${time.day.toString()}'),
              const SizedBox(
                height: 20,
              ),
              Text('${x.dailyMaxTemperature}°'),
              const SizedBox(
                height: 4,
              ),
            ]),
            const Spacer(),
            Container(
              height: 60,
              width: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
