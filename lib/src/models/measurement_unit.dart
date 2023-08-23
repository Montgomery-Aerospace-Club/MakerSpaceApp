class ComponentMeasurementUnit {
  final String unitName;
  final String unitDescription;

  ComponentMeasurementUnit({
    required this.unitName,
    this.unitDescription = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'unit_name': unitName,
      'unit_description': unitDescription,
    };
  }

  factory ComponentMeasurementUnit.fromJson(Map<String, dynamic> json) {
    return ComponentMeasurementUnit(
      unitName: json['unit_name'],
      unitDescription: json['unit_description'],
    );
  }
}
