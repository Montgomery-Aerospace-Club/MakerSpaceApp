import 'package:monty_makerspace/src/models/room.dart';

class StorageUnit {
  final String name;
  final String shortCode;
  final Room room;

  StorageUnit({
    required this.name,
    this.shortCode = '',
    required this.room,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'short_code': shortCode,
      'room': room.toJson(),
    };
  }

  factory StorageUnit.fromJson(Map<String, dynamic> json) {
    return StorageUnit(
      name: json['name'],
      shortCode: json['short_code'],
      room: Room.fromJson(json['room']),
    );
  }
}
