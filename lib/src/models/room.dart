import 'package:themakerspace/src/models/building.dart';

class Room {
  final String url;
  final String name;
  final String shortCode;
  final Building building;

  Room({
    this.url = "",
    required this.name,
    this.shortCode = '',
    required this.building,
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      'name': name,
      'short_code': shortCode,
      'building': building.toJson(),
    };
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      url: json["url"],
      name: json['name'],
      shortCode: json['short_code'],
      building: Building.fromJson(json['building']),
    );
  }
}
