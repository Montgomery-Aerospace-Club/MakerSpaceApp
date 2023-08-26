class Building {
  final String name;
  final String address;
  final String postcode;
  final String url;

  Building({
    required this.url,
    required this.name,
    this.address = '',
    this.postcode = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      'name': name,
      'address': address,
      'postcode': postcode,
    };
  }

  factory Building.fromJson(Map<String, dynamic> json) {
    return Building(
      url: json["url"],
      name: json['name'],
      address: json['address'],
      postcode: json['postcode'],
    );
  }
}
