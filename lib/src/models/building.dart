class Building {
  final String name;
  final String address;
  final String postcode;

  Building({
    required this.name,
    this.address = '',
    this.postcode = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'postcode': postcode,
    };
  }

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      name: json['name'],
      address: json['address'],
      postcode: json['postcode'],
    );
  }
}
