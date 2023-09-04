import 'package:themakerspace/src/models/building.dart';
// ignore: depend_on_referenced_packages
import 'package:list_treeview/list_treeview.dart';

class Room extends NodeData {
  final String url;
  final String name;
  final String shortCode;
  final Building building;

  Room({
    required this.url,
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
      shortCode: json['short_code'] ?? "",
      building: Building.fromJson(json['building']),
    );
  }

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    return (other is Room) && other.url == url;
  }

  @override
  int get hashCode {
    return url.hashCode;
  }
}
