import 'package:flutter/cupertino.dart';

import 'package:app/models/label.dart';
import 'package:app/styles/styles.dart' as styles;

class LabelPicker extends StatefulWidget {
  LabelPicker(
      {Key key, @required this.handleLabelChanged, @required this.initialLabel})
      : super(key: key);

  final void Function(Label label) handleLabelChanged;
  final Label initialLabel;

  @override
  _LabelPickerState createState() => _LabelPickerState();
}

class _LabelPickerState extends State<LabelPicker> {
  Label _activeLabel;

  @override
  void initState() {
    super.initState();
    _activeLabel = widget.initialLabel;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleLabelTap(Label label) {
    setState(() {
      _activeLabel = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Determine max length
    // Then you can make them squares
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double maxWidth = constraints.maxWidth;
      final double containerSize = maxWidth / 7;
      return Container(
        height: containerSize + 20,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 10,
              child: _ColorSquare(
                size: containerSize,
                isActive: Label.black == _activeLabel,
                isFirst: true,
                isLast: false,
                label: Label.black,
                handleLabelTap: _handleLabelTap,
              ),
            ),
            Positioned(
              left: containerSize,
              top: 10,
              child: _ColorSquare(
                size: containerSize,
                isActive: Label.red == _activeLabel,
                isFirst: false,
                isLast: false,
                label: Label.red,
                handleLabelTap: _handleLabelTap,
              ),
            ),
            Positioned(
              left: 2 * containerSize,
              top: 10,
              child: _ColorSquare(
                size: containerSize,
                isActive: Label.orange == _activeLabel,
                isFirst: false,
                isLast: false,
                label: Label.orange,
                handleLabelTap: _handleLabelTap,
              ),
            ),
            Positioned(
              left: 3 * containerSize,
              top: 10,
              child: _ColorSquare(
                size: containerSize,
                isActive: Label.yellow == _activeLabel,
                isFirst: false,
                isLast: false,
                label: Label.yellow,
                handleLabelTap: _handleLabelTap,
              ),
            ),
            Positioned(
              left: 4 * containerSize,
              top: 10,
              child: _ColorSquare(
                size: containerSize,
                isActive: Label.blue == _activeLabel,
                isFirst: false,
                isLast: false,
                label: Label.blue,
                handleLabelTap: _handleLabelTap,
              ),
            ),
            Positioned(
              left: 5 * containerSize,
              top: 10,
              child: _ColorSquare(
                size: containerSize,
                isActive: Label.turquoise == _activeLabel,
                isFirst: false,
                isLast: false,
                label: Label.turquoise,
                handleLabelTap: _handleLabelTap,
              ),
            ),
            Positioned(
              left: 6 * containerSize,
              top: 10,
              child: _ColorSquare(
                size: containerSize,
                isActive: Label.purple == _activeLabel,
                isFirst: false,
                isLast: true,
                label: Label.purple,
                handleLabelTap: _handleLabelTap,
              ),
            )
          ],
        ),
      );
    });
  }
}

class _ColorSquare extends StatefulWidget {
  _ColorSquare(
      {Key key,
      @required this.isActive,
      @required this.isFirst,
      @required this.isLast,
      @required this.label,
      @required this.handleLabelTap,
      @required this.size})
      : super(key: key);

  final double size;
  final bool isFirst;
  final bool isLast;
  final bool isActive;
  final Label label;
  final void Function(Label label) handleLabelTap;

  @override
  __ColorSquareState createState() => __ColorSquareState();
}

class __ColorSquareState extends State<_ColorSquare> {
  @override
  void didUpdateWidget(_ColorSquare oldWidget) {
    if (oldWidget.isActive != widget.isActive) {}
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _firstBorderRadius = BorderRadius.only(
        topLeft: styles.kBorderRadius, bottomLeft: styles.kBorderRadius);
    final _lastBorderRadius = BorderRadius.only(
        topRight: styles.kBorderRadius, bottomRight: styles.kBorderRadius);

    var _borderRadius;
    if (widget.isFirst == true) {
      _borderRadius = _firstBorderRadius;
    } else if (widget.isLast == true) {
      _borderRadius = _lastBorderRadius;
    } else if (widget.isActive == true) {
      _borderRadius = styles.kBorderRadiusAll;
    } else {
      _borderRadius = BorderRadius.zero;
    }

    return GestureDetector(
        onTap: () {
          widget.handleLabelTap(widget.label);
        },
        child: widget.isActive == true
            ? Container(
                height: widget.size + 10,
                width: widget.size + 10,
                decoration: BoxDecoration(
                  borderRadius: _borderRadius,
                  color: styles.labelColors[widget.label],
                ))
            : Container(
                height: widget.size,
                width: widget.size,
                decoration: BoxDecoration(
                  borderRadius: _borderRadius,
                  color: styles.labelColors[widget.label],
                )));
  }
}
