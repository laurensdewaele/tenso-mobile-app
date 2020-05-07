import 'package:app/data/custom_board_hold_builder.dart' as customBoard;
import 'package:app/models/board_hold.dart';
import 'package:app/models/custom_board_hold_image.dart';
import 'package:app/models/hold_type.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board.dart';
import 'package:app/widgets/custom_board/box.dart';
import 'package:flutter/cupertino.dart';

class CustomBoard extends StatelessWidget {
  CustomBoard(
      {Key key,
      @required this.boxes,
      @required this.handleBoxTap,
      @required this.images,
      @required this.boardHolds})
      : super(key: key);

  final List<BoardHold> boardHolds;
  final List<BoxState> boxes;
  final List<CustomBoardHoldImage> images;
  final void Function(BoxState boxState) handleBoxTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final _customBoardWidth = constraints.maxWidth;
        final _customBoardHeight = _customBoardWidth / customBoard.kAspectRatio;

        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            ClipRRect(
                borderRadius: styles.kBorderRadiusAll,
                child:
                    Image.asset('assets/images/custom_board/custom_board.png')),
            AspectRatio(
              aspectRatio: customBoard.kAspectRatio,
              child: GridView.count(
                padding: EdgeInsets.all(styles.Measurements.xs),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisSpacing:
                    customBoard.kVerticalSpacingPercent * _customBoardHeight,
                mainAxisSpacing:
                    customBoard.kHorizontalSpacingPercent * _customBoardWidth,
                childAspectRatio: customBoard.kSelectionBoxAspectRatio,
                crossAxisCount: customBoard.kColumns,
                children: <Widget>[
                  ...boxes.map((BoxState boxState) {
                    if (boxState.visibility == BoxVisibility.selected) {
                      return SelectedBox(
                          handleTap: () => handleBoxTap(boxState));
                    } else if (boxState.visibility ==
                        BoxVisibility.deselected) {
                      return Box(handleTap: () => handleBoxTap(boxState));
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
            ),
            ...images.map((CustomBoardHoldImage image) => Positioned.fromRect(
                child: Transform.scale(
                  scale: image.scale,
                  child: Image.asset(
                    image.imageAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                rect: image.getRect(
                    boardWidth: _customBoardWidth,
                    boardHeight: _customBoardHeight))),
            ...boardHolds.map((BoardHold boardHold) {
              BorderRadius _borderRadius = styles.kBorderRadiusAll;
              if (boardHold.type == HoldType.jug) {
                _borderRadius = BorderRadius.vertical(
                    top: Radius.circular(25), bottom: styles.kBorderRadius);
              }

              if (boardHold.type == HoldType.sloper) {
                _borderRadius =
                    BorderRadius.vertical(bottom: styles.kBorderRadius);
              }

              if (boardHold.type == HoldType.pocket) {
                _borderRadius = BorderRadius.horizontal(
                    left: Radius.circular(25), right: Radius.circular(25));
              }
              return Positioned.fromRect(
                  rect: boardHold.getRect(
                      boardWidth: _customBoardWidth,
                      boardHeight: _customBoardHeight),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: _borderRadius,
                        border:
                            Border.all(width: 2, color: styles.Colors.primary)),
                  ));
            })
          ],
        );
      },
    );
  }
}
