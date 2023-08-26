import 'package:themakerspace/src/models/measurement_unit.dart';
import 'package:themakerspace/src/models/storage_bin.dart';

class Component {
  final String url;
  final String name;
  final String sku;
  final String mpn;
  final int upc;
  final List<StorageBin> storageBins;
  final ComponentMeasurementUnit measurementUnit;
  final int qty;
  final String description;

  Component({
    required this.url,
    required this.name,
    required this.sku,
    required this.mpn,
    required this.upc,
    required this.storageBins,
    required this.measurementUnit,
    required this.qty,
    required this.description,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      url: json['url'],
      name: json['name'],
      sku: json['sku'],
      mpn: json['mpn'],
      upc: json['upc'],
      storageBins: (json['storage_bins'] as List<dynamic>)
          .map((e) => StorageBin.fromJson(e))
          .toList(),
      measurementUnit:
          ComponentMeasurementUnit.fromJson(json['measurement_unit']),
      qty: json['qty'],
      description: json['description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'sku': sku,
      'mpn': mpn,
      'upc': upc,
      'storage_bin': storageBins.map((e) => e.toJson()).toList(),
      'measurement_unit': measurementUnit.toJson(),
      'qty': qty,
      'description': description,
    };
  }
}
