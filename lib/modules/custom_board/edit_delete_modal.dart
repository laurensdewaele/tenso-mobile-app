import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/modal_popup.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class EditDeleteModal extends StatelessWidget {
  EditDeleteModal(
      {Key key,
      @required this.open,
      @required this.holdType,
      @required this.handleDeleteTap,
      @required this.depth,
      @required this.sloperDegrees,
      @required this.supportedFingers})
      : super(key: key);

  final bool open;
  final HoldType holdType;
  final double depth;
  final double sloperDegrees;
  final int supportedFingers;
  final VoidCallback handleDeleteTap;

  @override
  Widget build(BuildContext context) {
    final Orientation _orientation = MediaQuery.of(context).orientation;

    final bool _moreThanOneTopRowItem = depth != null || sloperDegrees != null;
    final _landscapeAlignment = _moreThanOneTopRowItem
        ? MainAxisAlignment.spaceBetween
        : MainAxisAlignment.center;

    final List<Widget> _topRowContent = [
      if (holdType != null)
        RichText(
          text: TextSpan(
              text: 'type: ',
              style: styles.Staatliches.xsBlack,
              children: [
                TextSpan(text: holdType.toString(), style: styles.Lato.xsGray),
              ]),
        ),
      if (depth != null)
        RichText(
          text: TextSpan(
              text: 'depth: ',
              style: styles.Staatliches.xsBlack,
              children: [
                TextSpan(text: depth.toString(), style: styles.Lato.xsGray),
                TextSpan(text: ' mm', style: styles.Lato.xsGray),
              ]),
        ),
      if (sloperDegrees != null)
        RichText(
          text: TextSpan(
              text: 'degrees: ',
              style: styles.Staatliches.xsBlack,
              children: [
                TextSpan(
                    text: sloperDegrees.toString(), style: styles.Lato.xsGray),
              ]),
        ),
      if (supportedFingers != null)
        RichText(
          text: TextSpan(
              text: 'fingers: ',
              style: styles.Staatliches.xsBlack,
              children: [
                TextSpan(
                    text: supportedFingers.toString(),
                    style: styles.Lato.xsGray),
              ]),
        )
    ];

    return AppModal(
        open: open,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _orientation == Orientation.landscape
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: _landscapeAlignment,
                    children: <Widget>[..._topRowContent],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[..._topRowContent],
                  ),
            Divider(
              height: _orientation == Orientation.landscape
                  ? styles.Measurements.xs
                  : styles.Measurements.m,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Button(
                    handleTap: handleDeleteTap,
                    text: 'delete',
                    backgroundColor: styles.Colors.primary,
                    height: _orientation == Orientation.landscape
                        ? styles.kSmallButtonHeight
                        : styles.kStandardButtonHeight,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
