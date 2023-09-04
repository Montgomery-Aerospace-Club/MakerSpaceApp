// ignore: depend_on_referenced_packages
import 'package:list_treeview/list_treeview.dart';

class Building extends NodeData {
  final String name;
  final String address;
  final String postcode;
  final String url;

  Building({
    required this.url,
    required this.name,
    this.address = '',
    this.postcode = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      'name': name,
      'address': address,
      'postcode': postcode,
    };
  }

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      url: json["url"],
      name: json['name'],
      address: json['address'] ?? "",
      postcode: json['postcode'] ?? "",
    );
  }

  @override
  String toString() {
    return name;
  }
}
