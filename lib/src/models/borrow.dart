import 'user.dart';
import 'component.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class Borrow {
  final String url;
  final User user;
  final DateTime borrowTime;
  DateTime? returnTime;
  bool inProgress;
  final Component component;
  final int qty;

  Borrow({
    required this.url,
    required this.user,
    required this.borrowTime,
    required this.component,
    required this.qty,
    // ignore: avoid_init_to_null
    this.returnTime = null,
    this.inProgress = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      'person_who_borrowed': user.toJson(),
      'timestamp_check_out': borrowTime.toIso8601String(),
      'timestamp_check_in': returnTime?.toIso8601String(),
      "borrow_in_progress": inProgress,
      "component": component.toJson(),
      "qty": qty
    };
  }

  factory Borrow.fromJson(Map<String, dynamic> json) {
    //print(json);
    return Borrow(
        url: json["url"],
        borrowTime: DateTime.parse(json["timestamp_check_out"]),
        returnTime: DateTime.tryParse(json["timestamp_check_out"]),
        inProgress: json["borrow_in_progress"],
        user: User.fromJson(json["person_who_borrowed"]),
        component: Component.fromJson(json["component"]),
        qty: json["qty"]);
  }

  @override
  String toString() {
    return "${component.name} - $qty - ${DateFormat('yyyy-MM-dd kk:mm').format(borrowTime.toLocal())}";
  }
}
