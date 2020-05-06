import 'package:app/data/custom_board_hold_images.dart';
import 'package:app/models/custom_board_hold_image.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board.dart';
import 'package:app/widgets/custom_board/box.dart';
import 'package:flutter/cupertino.dart';

class CustomBoard extends StatefulWidget {
  CustomBoard(
      {Key key,
      @required this.boxes,
      @required this.handleBoxTap,
      @required this.images})
      : super(key: key);

  final List<BoxState> boxes;
  final List<CustomBoardHoldImage> images;
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
        final _spacing = kCustomBoardSpacingPercent * _customBoardWidth;
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
                crossAxisSpacing: _spacing,
                mainAxisSpacing: _spacing,
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
            ...widget.images.map((CustomBoardHoldImage image) =>
                Positioned.fromRect(
                    child: Transform.scale(
                      scale: image.scale,
                      child: Image.asset(
                        image.imageAsset,
                        fit: BoxFit.contain,
                      ),
                    ),
                    rect: image.getRect(
                        boardWidth: _customBoardWidth,
                        boardHeight: _customBoardHeight)))
          ],
        );
      },
    );
  }
}
