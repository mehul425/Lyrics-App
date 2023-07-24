class ListData {
  String? id;
  Map<dynamic, dynamic>? data;

  ListData({required this.id, required this.data});

  dynamic get(String key) {
    if (data != null) {
      return data![key];
    }
    return null;
  }

  String? getId() {
    return id;
  }

  Map<dynamic, dynamic>? getData() {
    return data;
  }
}
