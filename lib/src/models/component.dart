import 'package:themakerspace/src/models/measurement_unit.dart';
import 'package:themakerspace/src/models/storage_bin.dart';
import 'package:themakerspace/src/models/user.dart';

class Component {
  final String url;
  final String name;
  final String sku;
  final String mpn;
  final int upc;
  final List<StorageBin> storageBins;
  final ComponentMeasurementUnit measurementUnit;
  final int qty;
  final bool checkedOut;
  final User personWhoCheckedOut;
  final String description;

  Component({
    this.url = "",
    required this.name,
    required this.sku,
    required this.mpn,
    required this.upc,
    required this.storageBins,
    required this.measurementUnit,
    required this.qty,
    required this.checkedOut,
    required this.personWhoCheckedOut,
    required this.description,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      url: json['url'],
      name: json['name'],
      sku: json['sku'],
      mpn: json['mpn'],
      upc: json['upc'],
      storageBins: (json['storageBins'] as List<dynamic>)
          .map((e) => StorageBin.fromJson(e))
          .toList(),
      measurementUnit:
          ComponentMeasurementUnit.fromJson(json['measurementUnit']),
      qty: json['qty'],
      checkedOut: json['checkedOut'],
      personWhoCheckedOut: User.fromJson(json['personWhoCheckedOut']),
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
      'checked_out': checkedOut,
      'person_who_checked_out': personWhoCheckedOut.toJson(),
      'description': description,
    };
  }
}
