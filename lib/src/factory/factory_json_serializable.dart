import 'dart:convert';

mixin FactoryJsonSerializable<T> {
  // Utility methods
  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson(T model) {
    var jsonString = jsonEncode(model);
    var jsonMap = jsonDecode(jsonString);
    return jsonMap;
  }
}
