import 'package:flutter/material.dart';
import 'package:flutter_json_view/src/builders/consts.dart';
import 'package:flutter_json_view/src/builders/json_path.dart';
import 'package:flutter_json_view/src/builders/primitive_builders/iterate_builder.dart';
import 'package:flutter_json_view/src/theme/json_view_theme.dart';
import 'package:flutter_json_view/src/utils/typer.dart';
import 'package:flutter_json_view/src/widgets/widgets.dart';
import 'package:collection/collection.dart';

class JsonListBuilder extends IterateBuilder<List<dynamic>> {
  const JsonListBuilder({
    Key? key,
    required JsonPath jsonPath,
    required List<dynamic> jsonObj,
    required JsonViewTheme jsonViewTheme,
    String? jsonKey,
  }) : super(
          key: key,
          jsonPath: jsonPath,
          jsonObj: jsonObj,
          jsonViewTheme: jsonViewTheme,
          brackets: const IterateBrackets(
              left: squareBracketsLeft, right: squareBracketsRight),
          jsonKey: jsonKey,
        );

  @override
  Iterable get items {
    return jsonObj;
  }

  @override
  List<Widget> buildJsonItems() {
    return jsonObj.mapIndexed(
      (index, e) {
        var item = JsonListItem(
          value: e,
          jsonPath: jsonPath.add(index),
          jsonViewTheme: jsonViewTheme,
        );
        if (e is Map<String, dynamic> || e is List) {
          return item;
        }
        return Row(
          children: [
            item,
          ],
        );
      },
    ).toList();
  }

  @override
  JsonListBuilderState createState() => JsonListBuilderState();
}

class JsonListBuilderState extends IterateBuilderState<JsonListBuilder> {
  @override
  Widget buildItems() {
    if (!isOpened) {
      return Padding(
        padding: EdgeInsets.only(
            left: widget.jsonViewTheme.defaultTextStyle.fontSize!),
        child: ClosedJsonObjectItem(
          isList: true,
          jsonViewTheme: widget.jsonViewTheme,
          count: widget.jsonObj.length,
          type: Typer.getType(
              widget.jsonObj.isNotEmpty ? widget.jsonObj.first : null),
        ),
      );
    }

    return super.buildItems();
  }
}
