import 'package:monty_makerspace/src/models/building.dart';

class Room {
  final String name;
  final String shortCode;
  final Building building;

  Room({
    required this.name,
    this.shortCode = '',
    required this.building,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'short_code': shortCode,
      'building': building.toJson(),
    };
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      shortCode: json['short_code'],
      building: Building.fromJson(json['building']),
    );
  }
}
