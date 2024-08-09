class JsonPath {
  JsonPath({required this.path, this.parent});

  JsonPath? parent;

  dynamic path;

  JsonPath add(dynamic item) {
    if (item is String || item is int) {
      return JsonPath(path: item, parent: this);
    }
    throw Exception("path item must be String or int");
  }

  @override
  String toString() {
    var items = [path];
    var tmpParent = parent;
    while (tmpParent != null) {
      items = [tmpParent.path, ...items];
      tmpParent = tmpParent.parent;
    }
    return items.map((item) {
      if (item == null) {
        return '';
      }
      if (item is int) {
        return '[$item]';
      }
      return '$item';
    }).join(".");
  }
}
