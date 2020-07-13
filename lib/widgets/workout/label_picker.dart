import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

final Map<int, Label> _labels = {
  0: Label.black,
  1: Label.red,
  2: Label.orange,
  3: Label.yellow,
  4: Label.blue,
  5: Label.turquoise,
  6: Label.purple
};

class LabelPicker extends StatefulWidget {
  LabelPicker(
      {Key key,
      @required this.handleLabelChanged,
      @required this.initialLabel,
      @required this.enabled})
      : super(key: key);

  final void Function(Label label) handleLabelChanged;
  final Label initialLabel;
  final bool enabled;

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
    if (widget.enabled) {
      widget.handleLabelChanged(label);
      setState(() {
        _activeLabel = label;
      });
    }
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
                    ..._labels
                        .map((int i, Label l) => MapEntry(
                            i,
                            _SmallSquare(
                              size: smallSquareSize,
                              isFirst: i == 0,
                              isLast: i == 6,
                              label: l,
                              handleLabelTap: _handleLabelTap,
                            )))
                        .values
                        .toList(),
                  ],
                ),
              ),
            ),
            _labels
                .map((int i, Label l) => MapEntry(
                    i,
                    l == _activeLabel
                        ? Positioned(
                            left: i * smallSquareSize,
                            top: 0,
                            child: _BigSquare(
                              size: bigSquareSize,
                              label: l,
                            ),
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
  _BigSquare({Key key, @required this.label, @required this.size})
      : super(key: key);

  final Label label;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: styles.kBorderRadiusAll,
          color: styles.labelColors[label],
        ));
  }
}

class _SmallSquare extends StatelessWidget {
  _SmallSquare({
    Key key,
    @required this.size,
    @required this.isFirst,
    @required this.isLast,
    @required this.label,
    @required this.handleLabelTap,
  }) : super(key: key);

  final double size;
  final bool isFirst;
  final bool isLast;
  final Label label;
  final void Function(Label label) handleLabelTap;

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

    return GestureDetector(
        onTap: () {
          handleLabelTap(label);
        },
        child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              borderRadius: _borderRadius,
              color: styles.labelColors[label],
            )));
  }
}
