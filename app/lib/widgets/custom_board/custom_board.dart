import 'package:app/data/custom_board_hold_builder.dart' as customBoard;
import 'package:app/models/board_hold.dart';
import 'package:app/models/custom_board_hold_image.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board_vm.dart';
import 'package:app/widgets/board/hang_board.dart';
import 'package:app/widgets/custom_board/box.dart';
import 'package:flutter/cupertino.dart';

class CustomBoard extends StatelessWidget {
  CustomBoard(
      {Key key,
      @required this.boxes,
      @required this.handleBoxTap,
      @required this.customBoardHoldImages,
      @required this.boardHolds})
      : super(key: key);

  final List<BoardHold> boardHolds;
  final List<BoxState> boxes;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final void Function(BoxState boxState) handleBoxTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size _boardSize = Size(constraints.maxWidth,
            constraints.maxWidth / customBoard.kAspectRatio);

        return Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            HangBoard(
              boardSize: _boardSize,
              customBoardHoldImages: customBoardHoldImages,
              boardImageAsset: customBoard.kImageAsset,
            ),
            AspectRatio(
              aspectRatio: customBoard.kAspectRatio,
              child: GridView.count(
                padding: EdgeInsets.all(styles.Measurements.xs),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisSpacing:
                    customBoard.kVerticalSpacingPercent * _boardSize.height,
                mainAxisSpacing:
                    customBoard.kHorizontalSpacingPercent * _boardSize.width,
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
          ],
        );
      },
    );
  }
}
