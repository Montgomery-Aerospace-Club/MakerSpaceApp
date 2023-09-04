import 'package:themakerspace/src/models/storage_unit.dart';
// ignore: depend_on_referenced_packages
import 'package:list_treeview/list_treeview.dart';

class StorageBin extends NodeData {
  final String url;
  final String name;
  final String shortCode;
  final String unitRow;
  final String unitColumn;
  final StorageUnit storageUnit;

  StorageBin({
    required this.url,
    required this.name,
    this.shortCode = '',
    this.unitRow = '',
    this.unitColumn = '',
    required this.storageUnit,
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      'name': name,
      'short_code': shortCode,
      'unit_row': unitRow,
      'unit_column': unitColumn,
      'storage_unit': storageUnit.toJson(),
    };
  }

  factory StorageBin.fromJson(Map<String, dynamic> json) {
    return StorageBin(
      url: json["url"],
      name: json['name'],
      shortCode: json['short_code'] ?? "",
      unitRow: json['unit_row'] ?? "",
      unitColumn: json['unit_column'] ?? "",
      storageUnit: StorageUnit.fromJson(json['storage_unit']),
    );
  }

  @override
  String toString() {
    return name;
  }
}
