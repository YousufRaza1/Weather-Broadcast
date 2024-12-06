import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Coord coord;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  Welcome({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    coord: Coord.fromJson(json["coord"]),
    weather: List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
    base: json["base"],
    main: Main.fromJson(json["main"]),
    visibility: json["visibility"],
    wind: Wind.fromJson(json["wind"]),
    clouds: Clouds.fromJson(json["clouds"]),
    dt: json["dt"],
    sys: Sys.fromJson(json["sys"]),
    timezone: json["timezone"],
    id: json["id"],
    name: json["name"],
    cod: json["cod"],
  );

  Map<String, dynamic> toJson() => {
    "coord": coord.toJson(),
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "base": base,
    "main": main.toJson(),
    "visibility": visibility,
    "wind": wind.toJson(),
    "clouds": clouds.toJson(),
    "dt": dt,
    "sys": sys.toJson(),
    "timezone": timezone,
    "id": id,
    "name": name,
    "cod": cod,
  };
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lon: json["lon"]?.toDouble(),
    lat: json["lat"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lon": lon,
    "lat": lat,
  };
}

class Main {
  double temp;
  double? feelsLike; // Changed to nullable
  double? tempMin; // Changed to nullable
  double? tempMax; // Changed to nullable
  int pressure;
  int humidity;
  int? seaLevel; // Changed to nullable
  int? grndLevel; // Changed to nullable

  Main({
    required this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory Main.fromJson(Map<String, dynamic> json) => Main(
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    tempMin: json["temp_min"]?.toDouble(),
    tempMax: json["temp_max"]?.toDouble(),
    pressure: json["pressure"],
    humidity: json["humidity"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "humidity": humidity,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
  };
}

class Sys {
  int type;
  int id;
  String country;
  int sunrise;
  int sunset;

  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    type: json["type"],
    id: json["id"],
    country: json["country"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "country": country,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class Wind {
  double speed;
  int deg;

  Wind({
    required this.speed,
    required this.deg,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"]?.toDouble(),
    deg: json["deg"],
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
  };
}



class WeatherForThreeHour {
  String? cod;
  int? message;
  int? cnt;
  List<ListElementForThreeHour>? list;
  CityForThreeHour? city;

  WeatherForThreeHour({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory WeatherForThreeHour.fromRawJson(String str) =>
      WeatherForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeatherForThreeHour.fromJson(Map<String, dynamic> json) => WeatherForThreeHour(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list: json["list"] == null
        ? null
        : List<ListElementForThreeHour>.from(json["list"].map((x) => ListElementForThreeHour.fromJson(x))),
    city: json["city"] == null ? null : CityForThreeHour.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "message": message,
    "cnt": cnt,
    "list": list == null ? null : List<dynamic>.from(list!.map((x) => x.toJson())),
    "city": city?.toJson(),
  };
}

class CityForThreeHour {
  int? id;
  String? name;
  CoordForThreeHour? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  CityForThreeHour({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory CityForThreeHour.fromRawJson(String str) =>
      CityForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityForThreeHour.fromJson(Map<String, dynamic> json) => CityForThreeHour(
    id: json["id"],
    name: json["name"],
    coord: json["coord"] == null ? null : CoordForThreeHour.fromJson(json["coord"]),
    country: json["country"],
    population: json["population"],
    timezone: json["timezone"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coord": coord?.toJson(),
    "country": country,
    "population": population,
    "timezone": timezone,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class CoordForThreeHour {
  double? lat;
  double? lon;

  CoordForThreeHour({
    this.lat,
    this.lon,
  });

  factory CoordForThreeHour.fromRawJson(String str) =>
      CoordForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoordForThreeHour.fromJson(Map<String, dynamic> json) => CoordForThreeHour(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
  };
}

class ListElementForThreeHour {
  int? dt;
  MainForThreeHour? main;
  List<WeatherForThreeHourElement>? weather;
  CloudsForThreeHour? clouds;
  WindForThreeHour? wind;
  int? visibility;
  double? pop;
  RainForThreeHour? rain;
  SysForThreeHour? sys;
  DateTime? dtTxt;

  ListElementForThreeHour({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  factory ListElementForThreeHour.fromRawJson(String str) =>
      ListElementForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElementForThreeHour.fromJson(Map<String, dynamic> json) => ListElementForThreeHour(
    dt: json["dt"],
    main: json["main"] == null ? null : MainForThreeHour.fromJson(json["main"]),
    weather: json["weather"] == null
        ? null
        : List<WeatherForThreeHourElement>.from(json["weather"].map((x) => WeatherForThreeHourElement.fromJson(x))),
    clouds: json["clouds"] == null ? null : CloudsForThreeHour.fromJson(json["clouds"]),
    wind: json["wind"] == null ? null : WindForThreeHour.fromJson(json["wind"]),
    visibility: json["visibility"],
    pop: json["pop"]?.toDouble(),
    rain: json["rain"] == null ? null : RainForThreeHour.fromJson(json["rain"]),
    sys: json["sys"] == null ? null : SysForThreeHour.fromJson(json["sys"]),
    dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "main": main?.toJson(),
    "weather": weather == null ? null : List<dynamic>.from(weather!.map((x) => x.toJson())),
    "clouds": clouds?.toJson(),
    "wind": wind?.toJson(),
    "visibility": visibility,
    "pop": pop,
    "rain": rain?.toJson(),
    "sys": sys?.toJson(),
    "dt_txt": dtTxt?.toIso8601String(),
  };
}

class CloudsForThreeHour {
  int? all;

  CloudsForThreeHour({
    this.all,
  });

  factory CloudsForThreeHour.fromRawJson(String str) =>
      CloudsForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CloudsForThreeHour.fromJson(Map<String, dynamic> json) => CloudsForThreeHour(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class MainForThreeHour {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  MainForThreeHour({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory MainForThreeHour.fromRawJson(String str) =>
      MainForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainForThreeHour.fromJson(Map<String, dynamic> json) => MainForThreeHour(
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    tempMin: json["temp_min"]?.toDouble(),
    tempMax: json["temp_max"]?.toDouble(),
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class RainForThreeHour {
  double? the3H;

  RainForThreeHour({
    this.the3H,
  });

  factory RainForThreeHour.fromRawJson(String str) =>
      RainForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RainForThreeHour.fromJson(Map<String, dynamic> json) => RainForThreeHour(
    the3H: json["3h"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "3h": the3H,
  };
}

class SysForThreeHour {
  String? pod;

  SysForThreeHour({
    this.pod,
  });

  factory SysForThreeHour.fromRawJson(String str) =>
      SysForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SysForThreeHour.fromJson(Map<String, dynamic> json) => SysForThreeHour(
    pod: json["pod"],
  );

  Map<String, dynamic> toJson() => {
    "pod": pod,
  };
}

class WeatherForThreeHourElement {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherForThreeHourElement({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory WeatherForThreeHourElement.fromRawJson(String str) =>
      WeatherForThreeHourElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeatherForThreeHourElement.fromJson(Map<String, dynamic> json) => WeatherForThreeHourElement(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class WindForThreeHour {
  double? speed;
  int? deg;
  double? gust;

  WindForThreeHour({
    this.speed,
    this.deg,
    this.gust,
  });

  factory WindForThreeHour.fromRawJson(String str) =>
      WindForThreeHour.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WindForThreeHour.fromJson(Map<String, dynamic> json) => WindForThreeHour(
    speed: json["speed"]?.toDouble(),
    deg: json["deg"],
    gust: json["gust"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}
// start of hourly

class HourlyWelcome {
  String? cod;
  int? message;
  int? cnt;
  List<HourlyListElement>? list;
  HourlyCity? city;

  HourlyWelcome({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });

  factory HourlyWelcome.fromRawJson(String str) => HourlyWelcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyWelcome.fromJson(Map<String, dynamic> json) => HourlyWelcome(
    cod: json["cod"],
    message: json["message"],
    cnt: json["cnt"],
    list: json["list"] == null ? [] : List<HourlyListElement>.from(json["list"]!.map((x) => HourlyListElement.fromJson(x))),
    city: json["city"] == null ? null : HourlyCity.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "cod": cod,
    "message": message,
    "cnt": cnt,
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
    "city": city?.toJson(),
  };
}

class HourlyCity {
  int? id;
  String? name;
  HourlyCoord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  HourlyCity({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory HourlyCity.fromRawJson(String str) => HourlyCity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyCity.fromJson(Map<String, dynamic> json) => HourlyCity(
    id: json["id"],
    name: json["name"],
    coord: json["coord"] == null ? null : HourlyCoord.fromJson(json["coord"]),
    country: json["country"],
    population: json["population"],
    timezone: json["timezone"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "coord": coord?.toJson(),
    "country": country,
    "population": population,
    "timezone": timezone,
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class HourlyCoord {
  double? lat;
  double? lon;

  HourlyCoord({
    this.lat,
    this.lon,
  });

  factory HourlyCoord.fromRawJson(String str) => HourlyCoord.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyCoord.fromJson(Map<String, dynamic> json) => HourlyCoord(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lon": lon,
  };
}

class HourlyListElement {
  int? dt;
  HourlyMain? main;
  List<HourlyWeather>? weather;
  HourlyClouds? clouds;
  HourlyWind? wind;
  int? visibility;
  double? pop;
  HourlyRain? rain;
  HourlySys? sys;
  DateTime? dtTxt;

  HourlyListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });

  factory HourlyListElement.fromRawJson(String str) => HourlyListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyListElement.fromJson(Map<String, dynamic> json) => HourlyListElement(
    dt: json["dt"],
    main: json["main"] == null ? null : HourlyMain.fromJson(json["main"]),
    weather: json["weather"] == null ? [] : List<HourlyWeather>.from(json["weather"]!.map((x) => HourlyWeather.fromJson(x))),
    clouds: json["clouds"] == null ? null : HourlyClouds.fromJson(json["clouds"]),
    wind: json["wind"] == null ? null : HourlyWind.fromJson(json["wind"]),
    visibility: json["visibility"],
    pop: json["pop"]?.toDouble(),
    rain: json["rain"] == null ? null : HourlyRain.fromJson(json["rain"]),
    sys: json["sys"] == null ? null : HourlySys.fromJson(json["sys"]),
    dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt,
    "main": main?.toJson(),
    "weather": weather == null ? [] : List<dynamic>.from(weather!.map((x) => x.toJson())),
    "clouds": clouds?.toJson(),
    "wind": wind?.toJson(),
    "visibility": visibility,
    "pop": pop,
    "rain": rain?.toJson(),
    "sys": sys?.toJson(),
    "dt_txt": dtTxt?.toIso8601String(),
  };
}

class HourlyClouds {
  int? all;

  HourlyClouds({
    this.all,
  });

  factory HourlyClouds.fromRawJson(String str) => HourlyClouds.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyClouds.fromJson(Map<String, dynamic> json) => HourlyClouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class HourlyMain {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  HourlyMain({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory HourlyMain.fromRawJson(String str) => HourlyMain.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyMain.fromJson(Map<String, dynamic> json) => HourlyMain(
    temp: json["temp"]?.toDouble(),
    feelsLike: json["feels_like"]?.toDouble(),
    tempMin: json["temp_min"]?.toDouble(),
    tempMax: json["temp_max"]?.toDouble(),
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

class HourlyRain {
  double? the3H;

  HourlyRain({
    this.the3H,
  });

  factory HourlyRain.fromRawJson(String str) => HourlyRain.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyRain.fromJson(Map<String, dynamic> json) => HourlyRain(
    the3H: json["3h"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "3h": the3H,
  };
}

class HourlySys {
  String? pod;

  HourlySys({
    this.pod,
  });

  factory HourlySys.fromRawJson(String str) => HourlySys.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlySys.fromJson(Map<String, dynamic> json) => HourlySys(
    pod: json["pod"],
  );

  Map<String, dynamic> toJson() => {
    "pod": pod,
  };
}

class HourlyWeather {
  int? id;
  String? main;
  String? description;
  String? icon;

  HourlyWeather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory HourlyWeather.fromRawJson(String str) => HourlyWeather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyWeather.fromJson(Map<String, dynamic> json) => HourlyWeather(
    id: json["id"],
    main: json["main"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "main": main,
    "description": description,
    "icon": icon,
  };
}

class HourlyWind {
  double? speed;
  int? deg;
  double? gust;

  HourlyWind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory HourlyWind.fromRawJson(String str) => HourlyWind.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HourlyWind.fromJson(Map<String, dynamic> json) => HourlyWind(
    speed: json["speed"]?.toDouble(),
    deg: json["deg"],
    gust: json["gust"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}
