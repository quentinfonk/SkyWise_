import 'package:flutter/material.dart';
import 'package:skywise/currently_weather_class.dart';
import 'package:skywise/daily_weather.dart';
import 'package:skywise/daily_weather_class.dart';
import 'package:skywise/hourly_weather_class.dart';
import 'package:skywise/position.dart';
import 'package:skywise/weather.dart';

class CurrentlyWeather extends StatefulWidget {
  CurrentlyWeather(
      {Key? key,
      required this.currentWeather,
      required this.dailyWeather,
      required this.hourlyWeather,
      required this.cityName})
      : super(key: key);

  CurentlyWeatherClass currentWeather;
  List<HourlyWeatherClass> hourlyWeather;
  List<DailyWeatherClass> dailyWeather;
  String cityName;

  @override
  CurrentlyWeatherState createState() => CurrentlyWeatherState();
}

class CurrentlyWeatherState extends State<CurrentlyWeather>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        header(),
        Text(widget.cityName, style: const TextStyle(fontSize: 30)),
        currentlyDegres(),
        minMaxTemp(),
        const SizedBox(
          height: 20,
        ),
        DailyWeather(
            dailyWeather: widget.dailyWeather,
            hourlyWeather: widget.hourlyWeather),
      ],
    );
  }

  Widget header() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 65, 214, 255),
          height: 100,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color.fromARGB(255, 255, 245, 63),
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        searchBar(),
      ],
    );
  }

  Widget searchBar() {
    TextEditingController controller = TextEditingController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 134, 138),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
              ),
              hintText: "Search ...",
              hintStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
              prefixIcon: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
            ),
            onSubmitted: (String value) {
              if (value.length > 2) {
                newData(value);
              }
            },
          ),
        ),
      ],
    );
  }

  void newData(String value) async {
    List<dynamic> stockPosition = await getPosition(value);
    if (stockPosition.isEmpty) {
      return;
    }
    widget.cityName = stockPosition[2];
    List<dynamic> stockWeather =
        await getData(stockPosition[0], stockPosition[1]);
    setState(() {
      widget.currentWeather = stockWeather[0] as CurentlyWeatherClass;
      widget.hourlyWeather = stockWeather[1] as List<HourlyWeatherClass>;
      widget.dailyWeather = stockWeather[2] as List<DailyWeatherClass>;
    });
  }

  Widget currentlyDegres() {
    return Center(
      child: Text(
        widget.currentWeather.currentTempeture,
        style: const TextStyle(fontSize: 60),
      ),
    );
  }

  Widget minMaxTemp() {
    if (widget.dailyWeather.isEmpty) return Container();
    return Text(
        'Min: ${widget.dailyWeather[0].dailyMinTemperature}°  Max: ${widget.dailyWeather[0].dailyMaxTemperature}°');
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
