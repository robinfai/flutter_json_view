import 'package:flutter/material.dart';
import 'package:flutter_json_view/src/builders/builders.dart';
import 'package:flutter_json_view/src/builders/json_path.dart';
import 'package:flutter_json_view/src/theme/json_view_theme.dart';

class JsonItem extends StatefulWidget {
  JsonItem({
    Key? key,
    required this.entry,
    required this.jsonViewTheme,
    required this.jsonPath,
  })  : _commonBuilder = CommonJsonViewBuilder(
          entry.value,
          jsonViewTheme: jsonViewTheme,
          jsonKey: entry.key,
          jsonPath: jsonPath,
        ),
        super(key: key);

  final JsonPath jsonPath;
  final MapEntry<String, dynamic> entry;
  final JsonViewTheme jsonViewTheme;
  final CommonJsonViewBuilder _commonBuilder;

  @override
  State<JsonItem> createState() => _JsonItemState();
}

class _JsonItemState extends State<JsonItem> {
  bool isOpened = true;

  @override
  Widget build(BuildContext context) {
    final valueWidget = widget._commonBuilder.build();
    return valueWidget;
  }
}
