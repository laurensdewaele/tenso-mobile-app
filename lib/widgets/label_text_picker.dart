import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class LabelWithText {
  final Label label;
  final String text;

  const LabelWithText({
    @required this.label,
    @required this.text,
  });
}

class LabelWithTextPicker extends StatefulWidget {
  const LabelWithTextPicker(
      {@required this.labelsWithText,
      @required this.handleLabelChanged,
      this.initialLabelWithText,
      @required this.reset$});

  final List<LabelWithText> labelsWithText;
  final void Function(Label label) handleLabelChanged;
  final LabelWithText initialLabelWithText;
  final Stream<bool> reset$;

  @override
  _LabelWithTextPickerState createState() => _LabelWithTextPickerState();
}

class _LabelWithTextPickerState extends State<LabelWithTextPicker> {
  LabelWithText _activeLabelWithText;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _activeLabelWithText = widget.initialLabelWithText;
    _sub = widget.reset$.listen((bool _) {
      setState(() {
        _activeLabelWithText = null;
      });
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  void _handleLabelTap(LabelWithText labelWithText) {
    widget.handleLabelChanged(labelWithText.label);
    setState(() {
      _activeLabelWithText = labelWithText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double maxWidth = constraints.maxWidth;
      final double padding = styles.Measurements.xs / 2;
      final double smallSquareSize = (maxWidth - padding * 2) / 7;
      final double bigSquareSize = (padding + (smallSquareSize / 2)) * 2;

      return Container(
        height: bigSquareSize,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: padding,
              top: (bigSquareSize - smallSquareSize) / 2,
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ...widget.labelsWithText
                        .asMap()
                        .map((int i, LabelWithText l) => MapEntry(
                            i,
                            GestureDetector(
                              onTap: () => _handleLabelTap(l),
                              child: _SmallSquare(
                                  size: smallSquareSize,
                                  isFirst: i == 0,
                                  isLast: i == 6,
                                  label: l.label,
                                  text: l.text),
                            )))
                        .values
                        .toList(),
                  ],
                ),
              ),
            ),
            if (_activeLabelWithText != null)
              widget.labelsWithText
                  .asMap()
                  .map((int i, LabelWithText l) => MapEntry(
                      i,
                      l == _activeLabelWithText
                          ? Positioned(
                              left: i * smallSquareSize,
                              top: 0,
                              child: _BigSquare(
                                  size: bigSquareSize,
                                  label: l.label,
                                  text: l.text),
                            )
                          : null))
                  .values
                  .firstWhere((e) => e != null),
          ],
        ),
      );
    });
  }
}

class _BigSquare extends StatelessWidget {
  _BigSquare(
      {Key key, @required this.label, @required this.size, @required this.text})
      : super(key: key);

  final Label label;
  final double size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: styles.kBorderRadiusAll,
        color: styles.labelColors[label],
      ),
      child: Center(
        child: Text(
          text,
          style: styles.Staatliches.lWhite,
        ),
      ),
    );
  }
}

class _SmallSquare extends StatelessWidget {
  _SmallSquare(
      {Key key,
      @required this.size,
      @required this.isFirst,
      @required this.isLast,
      @required this.label,
      @required this.text})
      : super(key: key);

  final String text;
  final double size;
  final bool isFirst;
  final bool isLast;
  final Label label;

  @override
  Widget build(BuildContext context) {
    final _firstBorderRadius = BorderRadius.only(
        topLeft: styles.kBorderRadius, bottomLeft: styles.kBorderRadius);
    final _lastBorderRadius = BorderRadius.only(
        topRight: styles.kBorderRadius, bottomRight: styles.kBorderRadius);

    var _borderRadius;
    if (isLast == true) {
      _borderRadius = _lastBorderRadius;
    } else if (isFirst == true) {
      _borderRadius = _firstBorderRadius;
    } else {
      _borderRadius = BorderRadius.zero;
    }

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        color: styles.labelColors[label],
      ),
      child: Center(
        child: Text(
          text,
          style: styles.Staatliches.sWhite,
        ),
      ),
    );
  }
}
