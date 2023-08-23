import 'package:monty_makerspace/src/models/storage_unit.dart';

class StorageBin {
  final String url;
  final String name;
  final String shortCode;
  final String unitRow;
  final String unitColumn;
  final StorageUnit storageUnit;

  StorageBin({
    this.url = "",
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
      shortCode: json['short_code'],
      unitRow: json['unit_row'],
      unitColumn: json['unit_column'],
      storageUnit: StorageUnit.fromJson(json['storage_unit']),
    );
  }
}
