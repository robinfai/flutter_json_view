import 'package:flutter/material.dart';
import 'package:flutter_json_view/src/builders/json_path.dart';
import 'package:flutter_json_view/src/theme/json_view_theme.dart';

import 'builders.dart';

class MapJsonViewBuilder implements JsonViewBuilder {
  MapJsonViewBuilder(this.map,
      {required this.jsonPath, JsonViewTheme? jsonViewTheme, this.jsonKey})
      : _commonBuilder = CommonJsonViewBuilder(
          map,
          jsonKey: jsonKey,
          jsonPath: jsonPath,
          jsonViewTheme: jsonViewTheme ?? const JsonViewTheme(),
        );

  final JsonPath jsonPath;
  final String? jsonKey;
  final Map<String, dynamic> map;
  final JsonViewBuilder _commonBuilder;

  @override
  Widget build() {
    return _commonBuilder.build();
  }

  @override
  JsonViewTheme get jsonViewTheme => _commonBuilder.jsonViewTheme;
}
