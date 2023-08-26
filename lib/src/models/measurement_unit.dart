class ComponentMeasurementUnit {
  final String url;
  final String unitName;
  final String unitDescription;

  ComponentMeasurementUnit({
    required this.url,
    required this.unitName,
    this.unitDescription = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      'unit_name': unitName,
      'unit_description': unitDescription,
    };
  }

  factory ComponentMeasurementUnit.fromJson(Map<String, dynamic> json) {
    return ComponentMeasurementUnit(
      url: json["url"],
      unitName: json['unit_name'],
      unitDescription: json['unit_description'],
    );
  }
}
