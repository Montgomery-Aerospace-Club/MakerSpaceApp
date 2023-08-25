import 'package:themakerspace/src/models/room.dart';

class StorageUnit {
  final String url;
  final String name;
  final String shortCode;
  final Room room;

  StorageUnit({
    this.url = "",
    required this.name,
    this.shortCode = '',
    required this.room,
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      'name': name,
      'short_code': shortCode,
      'room': room.toJson(),
    };
  }

  factory StorageUnit.fromJson(Map<String, dynamic> json) {
    return StorageUnit(
      url: json["url"],
      name: json['name'],
      shortCode: json['short_code'],
      room: Room.fromJson(json['room']),
    );
  }
}
