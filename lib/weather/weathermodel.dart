class GetWeather {
  Location? location;
  Current? current;

  GetWeather({this.location, this.current});

  GetWeather.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (current != null) {
      data['current'] = current!.toJson();
    }
    return data;
  }

  static List<GetWeather>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => GetWeather.fromJson(item)).toList();
  }
}

class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['country'] = country;
    data['localtime'] = localtime;
    return data;
  }

  static List<Location>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => Location.fromJson(item)).toList();
  }
}

class Current {
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  double? precipMm;
  int? humidity;
  double? uv;

  Current(
      {this.tempC,
      this.isDay,
      this.condition,
      this.windKph,
      this.precipMm,
      this.humidity,
      this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    precipMm = json['precip_mm'];
    humidity = json['humidity'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp_c'] = tempC;
    data['is_day'] = isDay;
    if (condition != null) {
      data['condition'] = condition!.toJson();
    }
    data['wind_kph'] = windKph;
    data['precip_mm'] = precipMm;
    data['humidity'] = humidity;
    data['uv'] = uv;
    return data;
  }

  static List<Current>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => Current.fromJson(item)).toList();
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['icon'] = icon;
    data['code'] = code;
    return data;
  }

  static List<Condition>? fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => Condition.fromJson(item)).toList();
  }
}
