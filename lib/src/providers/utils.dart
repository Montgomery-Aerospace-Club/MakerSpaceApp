Map<String, String> convertToMap(dynamic item) {
  if (item is Map<String, dynamic>) {
    Map<String, String> convertedMap = {};
    item.forEach((key, value) {
      convertedMap[key] = value.toString();
    });
    return convertedMap;
  }
  return {};
}

Map<String, dynamic> convertToMapDynamic(dynamic item) {
  if (item is Map<String, dynamic>) {
    Map<String, dynamic> converted = {};

    item.forEach((key, value) {
      converted[key] = value;
    });

    return converted;
  }

  return {};
}

List<String> convertToListString(dynamic item) {
  if (item is List<dynamic>) {
    List<String> convertedLst = [];

    for (var element in item) {
      convertedLst.add(element.toString());
    }

    return convertedLst;
  }

  return [];
}
