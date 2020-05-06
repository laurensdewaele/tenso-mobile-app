import 'package:app/data/custom_board_hold_images.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board.dart';
import 'package:app/widgets/custom_board/box.dart';
import 'package:flutter/cupertino.dart';

class CustomBoard extends StatefulWidget {
  CustomBoard({Key key, @required this.boxes, @required this.handleBoxTap})
      : super(key: key);

  final List<BoxState> boxes;
  final void Function(BoxState boxState) handleBoxTap;

  @override
  _CustomBoardState createState() => _CustomBoardState();
}

class _CustomBoardState extends State<CustomBoard> {
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final _customBoardWidth = constraints.maxWidth;
        final _customBoardHeight = _customBoardWidth / kCustomBoardAspectRatio;
        final _customBoardY0 = (constraints.maxHeight - _customBoardHeight) / 2;
        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            ClipRRect(
                borderRadius: styles.kBorderRadiusAll,
                child:
                    Image.asset('assets/images/custom_board/custom_board.png')),
            AspectRatio(
              aspectRatio: kCustomBoardAspectRatio,
              child: GridView.count(
                padding: EdgeInsets.all(styles.Measurements.xs),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisSpacing: kCustomBoardSpacing,
                mainAxisSpacing: kCustomBoardSpacing,
                childAspectRatio: kSelectionBoxAspectRatio,
                crossAxisCount: kCustomBoardColumns,
                children: <Widget>[
                  ...widget.boxes.map((BoxState boxState) =>
                      boxState.selected == true
                          ? SelectedBox(
                              handleTap: () => widget.handleBoxTap(boxState))
                          : Box(
                              handleTap: () => widget.handleBoxTap(boxState),
                            ))
                ],
              ),
            ),
            Positioned.fromRect(
                child: Transform.scale(
                  scale: jug1.scale,
                  child: Image.asset(
                    jug1.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                rect: Rect.fromLTWH(
                    jug1.leftXPercent[0] * _customBoardWidth,
                    -50,
                    jug1.widthPercent * _customBoardWidth,
                    jug1.heightPercent * _customBoardHeight)),
            Positioned.fromRect(
                child: Transform.scale(
                  scale: pinchBlock1.scale,
                  child: Image.asset(
                    pinchBlock1.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                rect: Rect.fromLTWH(
                    jug1.leftXPercent[1] * _customBoardWidth,
                    _customBoardY0 +
                        pinchBlock1.topYPercent[0] * _customBoardHeight,
                    pinchBlock1.widthPercent * _customBoardWidth,
                    pinchBlock1.heightPercent * _customBoardHeight)),
            Positioned.fromRect(
                child: Transform.scale(
                  scale: sloper2.scale,
                  child: Image.asset(
                    sloper2.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                rect: Rect.fromLTWH(
                    jug1.leftXPercent[2] * _customBoardWidth,
                    _customBoardY0 +
                        sloper2.topYPercent[0] * _customBoardHeight,
                    sloper2.widthPercent * _customBoardWidth,
                    sloper2.heightPercent * _customBoardHeight)),
            Positioned.fromRect(
                child: Transform.scale(
                  scale: edge4.scale,
                  child: Image.asset(
                    edge4.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                rect: Rect.fromLTWH(
                    edge4.leftXPercent[0] * _customBoardWidth,
                    _customBoardY0 + edge4.topYPercent[1] * _customBoardHeight,
                    edge4.widthPercent * _customBoardWidth,
                    edge4.heightPercent * _customBoardHeight)),
            Positioned.fromRect(
                child: Transform.scale(
                  scale: edge4.scale,
                  child: Image.asset(
                    edge4.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                rect: Rect.fromLTWH(
                    edge4.leftXPercent[0] * _customBoardWidth,
                    _customBoardY0 + edge4.topYPercent[2] * _customBoardHeight,
                    edge4.widthPercent * _customBoardWidth,
                    edge4.heightPercent * _customBoardHeight)),
            Positioned.fromRect(
                child: Transform.scale(
                  scale: edge2.scale,
                  child: Image.asset(
                    edge2.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                rect: Rect.fromLTWH(
                    edge2.leftXPercent[0] * _customBoardWidth,
                    _customBoardY0 + edge2.topYPercent[3] * _customBoardHeight,
                    edge2.widthPercent * _customBoardWidth,
                    edge2.heightPercent * _customBoardHeight)),
            Positioned.fromRect(
                child: Transform.scale(
                  scale: pocket2.scale,
                  child: Image.asset(
                    pocket2.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                rect: Rect.fromLTWH(
                    pocket2.leftXPercent[2] * _customBoardWidth,
                    pocket2.topYPercent[3] * _customBoardHeight,
                    pocket2.widthPercent * _customBoardWidth,
                    pocket2.heightPercent * _customBoardHeight)),
          ],
        );
      },
    );
  }
}
