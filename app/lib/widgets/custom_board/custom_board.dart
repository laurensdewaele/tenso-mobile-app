import 'package:app/data/custom_board_hold_images.dart' as custom_board;
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
        final _customBoardHeight =
            _customBoardWidth / custom_board.kAspectRatio;

        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            ClipRRect(
                borderRadius: styles.kBorderRadiusAll,
                child:
                    Image.asset('assets/images/custom_board/custom_board.png')),
            AspectRatio(
              aspectRatio: custom_board.kAspectRatio,
              child: GridView.count(
                padding: EdgeInsets.all(styles.Measurements.xs),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisSpacing:
                    custom_board.kVerticalSpacingPercent * _customBoardHeight,
                mainAxisSpacing:
                    custom_board.kHorizontalSpacingPercent * _customBoardWidth,
                childAspectRatio: custom_board.kSelectionBoxAspectRatio,
                crossAxisCount: custom_board.kColumns,
                children: <Widget>[
                  ...widget.boxes.map((BoxState boxState) {
                    if (boxState.visibility == BoxVisibility.selected) {
                      return SelectedBox(
                          handleTap: () => widget.handleBoxTap(boxState));
                    } else if (boxState.visibility ==
                        BoxVisibility.deselected) {
                      return Box(
                          handleTap: () => widget.handleBoxTap(boxState));
                    } else {
                      return Container();
                    }
                  })
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
