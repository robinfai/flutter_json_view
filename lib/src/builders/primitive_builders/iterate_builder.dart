import 'package:flutter/material.dart';
import 'package:flutter_json_view/src/builders/consts.dart';
import 'package:flutter_json_view/src/builders/json_path.dart';
import 'package:flutter_json_view/src/theme/json_view_theme.dart';
import 'package:flutter_json_view/src/utils/typer.dart';
import 'package:flutter_json_view/src/widgets/widgets.dart';

class IterateBrackets {
  const IterateBrackets({
    required this.left,
    required this.right,
  });

  final String left;
  final String right;
}

abstract class IterateBuilder<T> extends StatefulWidget {
  const IterateBuilder({
    Key? key,
    required this.jsonPath,
    required this.jsonObj,
    required this.jsonViewTheme,
    required this.brackets,
    this.jsonKey,
  }) : super(key: key);

  final IterateBrackets brackets;

  final JsonPath jsonPath;
  final String? jsonKey;
  final T jsonObj;
  final JsonViewTheme jsonViewTheme;

  Iterable get items;

  List<Widget> buildJsonItems();

  bool needPatchComma() {
    if (Typer.isList(jsonObj) || Typer.isObject(jsonObj)) {
      return jsonPath.path != null;
    }
    return false;
  }
}

class IterateBuilderState<T extends IterateBuilder>
    extends State<IterateBuilder> {
  bool isOpened = true;

  collapse() {
    setState(() => isOpened = !isOpened);
  }

  Widget buildItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.buildJsonItems(),
    );
  }

  Widget buildObjectKey() {
    if (widget.jsonKey != null) {
      return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.jsonKey!, style: widget.jsonViewTheme.keyStyle),
        JsonViewSeparator(jsonViewTheme: widget.jsonViewTheme),
      ]);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: collapse,
              child: isOpened
                  ? widget.jsonViewTheme.closeIcon
                  : widget.jsonViewTheme.openIcon,
            ),
            buildObjectKey(),
            Text(" ${widget.brackets.left}",
                style: widget.jsonViewTheme.keyStyle),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: widget.jsonViewTheme.defaultTextStyle.fontSize!),
          child: buildItems(),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: widget.jsonViewTheme.defaultTextStyle.fontSize!),
          child: Text.rich(
              TextSpan(
                text:
                    " ${widget.brackets.right}${widget.needPatchComma() ? comma : ''}",
                children: const [
                  TextSpan(
                    text: "\n ",
                    style: TextStyle(
                      fontSize: 0,
                      height: 0,
                    ),
                  ),
                ],
              ),
              style: widget.jsonViewTheme.keyStyle),
        ),
      ],
    );
  }
}
