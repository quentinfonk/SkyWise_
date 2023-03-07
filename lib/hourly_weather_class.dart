class HourlyWeatherClass {
  String hourlyTime;
  String hourlyWeathercode;
  String hourlyTemperature;

  String get getHourlyTime {
    return hourlyTime;
  }

  String get getHourlyWeathercode {
    return hourlyWeathercode;
  }

  String get getHourlyTemperature {
    return hourlyTemperature;
  }

  @override
  String toString() {
    return '{this.hourlyTime,$hourlyTime, this.getHourlyWeathercode: $getHourlyWeathercode, this.getHourlyTemperature: $getHourlyTemperature}';
  }

  HourlyWeatherClass copy(HourlyWeatherClass cpy) {
    return HourlyWeatherClass(
      hourlyTime: cpy.hourlyTime,
      hourlyWeathercode: cpy.hourlyWeathercode,
      hourlyTemperature: cpy.hourlyTemperature,
    );
  }

  HourlyWeatherClass({
    required this.hourlyTime,
    required this.hourlyWeathercode,
    required this.hourlyTemperature,
  });
}
