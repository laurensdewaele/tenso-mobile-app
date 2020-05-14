import 'package:app/data/custom_board.data.dart' as customBoard;
import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board.vm.dart';
import 'package:app/widgets/board/hang_board.dart';
import 'package:app/widgets/custom_board/box.dart';
import 'package:app/widgets/custom_board/positioned_image.dart';
import 'package:flutter/cupertino.dart';

class CustomBoard extends StatelessWidget {
  CustomBoard({
    Key key,
    @required this.boxes,
    @required this.handleBoxTap,
    @required this.customBoardHoldImages,
    @required this.boardHolds,
    @required this.handleCustomBoardHoldImageTap,
    @required this.selectedCustomBoardHoldImage,
  }) : super(key: key);

  final CustomBoardHoldImage selectedCustomBoardHoldImage;
  final List<BoardHold> boardHolds;
  final List<BoxState> boxes;
  final void Function(CustomBoardHoldImage customBoardHoldImage)
      handleCustomBoardHoldImageTap;
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
            if (selectedCustomBoardHoldImage != null)
              PositionedCustomBoardHoldImage(
                  isSelected: true,
                  customBoardHoldImage: selectedCustomBoardHoldImage,
                  boardSize: _boardSize),
            // The gestureDetectors cannot be in the HangBoard widget.
            // This is because we paint the selection boxes over them.
            ...customBoardHoldImages
                .map((CustomBoardHoldImage customBoardHoldImage) {
              return Positioned.fromRect(
                  child: GestureDetector(
                    onTap: () =>
                        handleCustomBoardHoldImageTap(customBoardHoldImage),
                    child: Container(
                      decoration:
                          BoxDecoration(color: styles.Colors.translucent),
                    ),
                  ),
                  rect: _getGestureDetectorRect(
                      boardSize: _boardSize,
                      customBoardHoldImage: customBoardHoldImage));
            })
          ],
        );
      },
    );
  }
}

Rect _getGestureDetectorRect(
    {CustomBoardHoldImage customBoardHoldImage, Size boardSize}) {
  Rect _rect;

  if (customBoardHoldImage.holdType == HoldType.pinchBlock ||
      customBoardHoldImage.holdType == HoldType.jug) {
    _rect = Rect.fromLTWH(
        customBoardHoldImage.leftPercent * boardSize.width,
        (customBoardHoldImage.topPercent - .02) * boardSize.height,
        customBoardHoldImage.widthPercent * boardSize.width,
        (customBoardHoldImage.heightPercent + .02) * boardSize.height);
  }

  if (customBoardHoldImage.holdType == HoldType.sloper) {
    _rect = customBoardHoldImage.getRect(
        boardHeight: boardSize.height, boardWidth: boardSize.width);
  }

  if (customBoardHoldImage.holdType == HoldType.edge) {
    _rect = Rect.fromLTWH(
        customBoardHoldImage.leftPercent * boardSize.width,
        (customBoardHoldImage.topPercent - .09) * boardSize.height,
        customBoardHoldImage.widthPercent * boardSize.width,
        (customBoardHoldImage.heightPercent + .13) * boardSize.height);
  }

  if (customBoardHoldImage.holdType == HoldType.pocket) {
    _rect = Rect.fromLTWH(
        customBoardHoldImage.leftPercent * boardSize.width,
        (customBoardHoldImage.topPercent - .04) * boardSize.height,
        customBoardHoldImage.widthPercent * boardSize.width,
        (customBoardHoldImage.heightPercent + .08) * boardSize.height);
  }

  return _rect;
}
