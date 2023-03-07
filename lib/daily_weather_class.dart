class DailyWeatherClass {
  String dailyTime;
  String dailyWeathercode;
  String dailyMaxTemperature;
  String dailyMinTemperature;
  String dailySunrise;
  String dailySunset;

  String get getHourlyTime {
    return dailyTime;
  }

  String get getHourlyWeathercode {
    return dailyWeathercode;
  }

  String get getHourlyMaxTemperature {
    return dailyMaxTemperature;
  }

  String get getDailyMinTemperature {
    return dailyMinTemperature;
  }

  String get getDailySunrise {
    return dailySunrise;
  }

  String get getDailySunset {
    return dailySunset;
  }

  @override
  String toString() {
    return '{this.dailyTime,$dailyTime, this.getHourlyWeathercode: $getHourlyWeathercode, this.getHourlyMaxTemperature: $getHourlyMaxTemperature, this.getDailyMinTemperature: $getDailyMinTemperature, this.getDailySunrise: $getDailySunrise, this.getDailySunset: $getDailySunset}';
  }

  DailyWeatherClass copy(DailyWeatherClass cpy) {
    return DailyWeatherClass(
      dailyTime: cpy.dailyTime,
      dailyWeathercode: cpy.dailyWeathercode,
      dailyMaxTemperature: cpy.dailyMaxTemperature,
      dailyMinTemperature: cpy.dailyMinTemperature,
      dailySunrise: cpy.dailySunrise,
      dailySunset: cpy.dailySunset,
    );
  }

  DailyWeatherClass({
    required this.dailyTime,
    required this.dailyWeathercode,
    required this.dailyMaxTemperature,
    required this.dailyMinTemperature,
    required this.dailySunrise,
    required this.dailySunset,
  });
}
