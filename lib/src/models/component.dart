import 'package:themakerspace/src/models/measurement_unit.dart';
import 'package:themakerspace/src/models/storage_bin.dart';

class Component {
  final String uuid;
  final String id;
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
    required this.uuid,
    required this.id,
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
    String id = json["url"];
    id = id.split("/components/")[1];
    id = id.replaceAll("/", "");

    return Component(
      url: json['url'],
      id: id,
      uuid: json["unique_id"],
      name: json['name'],
      sku: json['sku'],
      mpn: json['mpn'],
      upc: json['upc'],
      storageBins: (json['storage_bin'] as List<dynamic>)
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
      "unique_id": uuid,
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

  @override
  bool operator ==(Object other) {
    return (other is Component) && other.url == url && other.uuid == uuid;
  }

  @override
  int get hashCode {
    return url.hashCode ^ uuid.hashCode;
  }
}
