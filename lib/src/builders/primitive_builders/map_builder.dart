import 'package:flutter/material.dart';
import 'package:flutter_json_view/src/builders/consts.dart';
import 'package:flutter_json_view/src/builders/json_path.dart';
import 'package:flutter_json_view/src/builders/primitive_builders/iterate_builder.dart';
import 'package:flutter_json_view/src/theme/json_view_theme.dart';
import 'package:flutter_json_view/src/widgets/widgets.dart';

class JsonMapBuilder extends IterateBuilder<Map<String, dynamic>> {
  const JsonMapBuilder({
    Key? key,
    required JsonPath jsonPath,
    required Map<String, dynamic> jsonObj,
    required JsonViewTheme jsonViewTheme,
    String? jsonKey,
  }) : super(
          key: key,
          jsonPath: jsonPath,
          jsonObj: jsonObj,
          jsonViewTheme: jsonViewTheme,
          brackets: const IterateBrackets(
              left: curlyBracesLeft, right: curlyBracesRight),
          jsonKey: jsonKey,
        );

  @override
  Iterable get items {
    return jsonObj.entries;
  }

  @override
  List<Widget> buildJsonItems() {
    return jsonObj.entries
        .map(
          (e) => JsonItem(
            entry: e,
            jsonPath: jsonPath.add(e.key),
            jsonViewTheme: jsonViewTheme,
          ),
        )
        .toList();
  }

  @override
  JsonMapBuilderState createState() => JsonMapBuilderState();
}

class JsonMapBuilderState extends IterateBuilderState<JsonMapBuilder> {
  @override
  Widget buildItems() {
    if (!isOpened) {
      return ClosedJsonObjectItem(
        isList: false,
        jsonViewTheme: widget.jsonViewTheme,
        count: widget.items.length,
      );
    }

    return super.buildItems();
  }
}
