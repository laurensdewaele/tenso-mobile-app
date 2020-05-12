import 'package:app/data/custom_board.data.dart' as customBoard;
import 'package:app/models/board_hold.model.dart';
import 'package:app/models/custom_board_hold_image.model.dart';
import 'package:app/models/hold_type.model.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/custom_board/custom_board.vm.dart';
import 'package:app/widgets/board/hang_board.dart';
import 'package:app/widgets/custom_board/box.dart';
import 'package:flutter/cupertino.dart';

class CustomBoard extends StatelessWidget {
  CustomBoard({
    Key key,
    @required this.boxes,
    @required this.handleBoxTap,
    @required this.customBoardHoldImages,
    @required this.boardHolds,
    @required this.handleCustomBoardHoldImageTap,
    @required this.selectedBoardHoldImage,
  }) : super(key: key);

  final CustomBoardHoldImage selectedBoardHoldImage;
  final List<BoardHold> boardHolds;
  final List<BoxState> boxes;
  final void Function(CustomBoardHoldImage customBoardHoldImage)
      handleCustomBoardHoldImageTap;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final void Function(BoxState boxState) handleBoxTap;

  @override
  Widget build(BuildContext context) {
    final List<CustomBoardHoldImage> _imageGestureDetectors =
        customBoardHoldImages;

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
            if (selectedBoardHoldImage != null)
              Positioned.fromRect(
                  child: Transform.scale(
                    scale: selectedBoardHoldImage.scale,
                    child: Image.asset(
                      selectedBoardHoldImage.imageAsset,
                      color: styles.Colors.primary,
                      fit: BoxFit.contain,
                    ),
                  ),
                  rect: selectedBoardHoldImage.getRect(
                      boardWidth: _boardSize.width,
                      boardHeight: _boardSize.height)),
            ..._imageGestureDetectors.map((CustomBoardHoldImage image) {
              Rect _rect = image.getRect(
                  boardHeight: _boardSize.height, boardWidth: _boardSize.width);

              if (image.holdType == HoldType.pinchBlock ||
                  image.holdType == HoldType.jug) {
                _rect = Rect.fromLTWH(
                    image.leftPercent * _boardSize.width,
                    (image.topPercent - .02) * _boardSize.height,
                    image.widthPercent * _boardSize.width,
                    (image.heightPercent + .02) * _boardSize.height);
              }

              if (image.holdType == HoldType.edge) {
                _rect = Rect.fromLTWH(
                    image.leftPercent * _boardSize.width,
                    (image.topPercent - .09) * _boardSize.height,
                    image.widthPercent * _boardSize.width,
                    (image.heightPercent + .13) * _boardSize.height);
              }

              if (image.holdType == HoldType.pocket) {
                _rect = Rect.fromLTWH(
                    image.leftPercent * _boardSize.width,
                    (image.topPercent - .04) * _boardSize.height,
                    image.widthPercent * _boardSize.width,
                    (image.heightPercent + .08) * _boardSize.height);
              }
              return Positioned.fromRect(
                  child: GestureDetector(
                    onTap: () => handleCustomBoardHoldImageTap(image),
                    child: Container(
                      decoration:
                          BoxDecoration(color: styles.Colors.translucent),
                    ),
                  ),
                  rect: _rect);
            })
          ],
        );
      },
    );
  }
}
