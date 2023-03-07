class CurentlyWeatherClass {
  String currentTempeture;
  String currentWindspeed;
  String currentWindDirection;
  String weathercode;

  String get getCurrentTempeture {
    return currentTempeture;
  }

  String get getCurrentWindspeed {
    return currentWindspeed;
  }

  String get getCurrentWindDirection {
    return currentWindDirection;
  }

  String get getWeathercode {
    return weathercode;
  }

  @override
  String toString() {
    return '{this.currentTempeture,$currentTempeture, this.getCurrentWindspeed: $getCurrentWindspeed, this.getCurrentWindDirection: $getCurrentWindDirection, this.getWeathercode: $getWeathercode}';
  }

  CurentlyWeatherClass copy(CurentlyWeatherClass cpy) {
    return CurentlyWeatherClass(
      currentTempeture: cpy.currentTempeture,
      currentWindspeed: cpy.currentWindspeed,
      currentWindDirection: cpy.currentWindDirection,
      weathercode: cpy.weathercode,
    );
  }

  CurentlyWeatherClass({
    required this.currentTempeture,
    required this.currentWindspeed,
    required this.currentWindDirection,
    required this.weathercode,
  });
}
