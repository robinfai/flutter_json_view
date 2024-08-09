import 'package:flutter/material.dart';
import 'package:flutter_json_view/src/builders/builders.dart';
import 'package:flutter_json_view/src/builders/json_path.dart';
import 'package:flutter_json_view/src/theme/json_view_theme.dart';

class JsonListItem extends StatelessWidget {
  JsonListItem(
      {Key? key,
      required this.value,
      required this.jsonViewTheme,
      required this.jsonPath})
      : _commonBuilder = CommonJsonViewBuilder(
          value,
          jsonViewTheme: jsonViewTheme,
          jsonPath: jsonPath,
        ),
        super(key: key);

  final JsonPath jsonPath;
  final dynamic value;
  final JsonViewTheme jsonViewTheme;
  final CommonJsonViewBuilder _commonBuilder;

  @override
  Widget build(BuildContext context) {
    return _commonBuilder.build();
  }
}
