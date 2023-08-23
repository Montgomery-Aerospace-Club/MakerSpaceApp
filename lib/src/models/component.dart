import 'package:monty_makerspace/src/models/measurement_unit.dart';
import 'package:monty_makerspace/src/models/storage_bin.dart';
import 'package:monty_makerspace/src/models/user.dart';

class Component {
  final int id; // You can use a unique identifier for each component
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
    required this.id,
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
      id: json['id'],
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
      'id': id,
      'name': name,
      'sku': sku,
      'mpn': mpn,
      'upc': upc,
      'storageBins': storageBins.map((e) => e.toJson()).toList(),
      'measurementUnit': measurementUnit.toJson(),
      'qty': qty,
      'checkedOut': checkedOut,
      'personWhoCheckedOut': personWhoCheckedOut.toJson(),
      'description': description,
    };
  }
}
