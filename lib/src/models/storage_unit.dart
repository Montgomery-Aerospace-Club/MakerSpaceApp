import 'package:themakerspace/src/models/room.dart';
// ignore: depend_on_referenced_packages
import 'package:list_treeview/list_treeview.dart';

class StorageUnit extends NodeData {
  final String url;
  final String name;
  final String shortCode;
  final Room room;

  StorageUnit({
    required this.url,
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
      shortCode: json['short_code'] ?? "",
      room: Room.fromJson(json['room']),
    );
  }
  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    return (other is StorageUnit) && other.url == url;
  }

  @override
  int get hashCode {
    return url.hashCode;
  }
}
