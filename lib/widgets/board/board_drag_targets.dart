import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/board/hang_board.dart';
import 'package:tenso_app/widgets/toast_message.dart';

class BoardDragTargets extends StatelessWidget {
  BoardDragTargets(
      {Key key,
      @required this.boardSize,
      @required this.handleSuccess,
      @required this.orientation,
      @required this.setErrorMessage,
      @required this.boardImageAsset,
      @required this.boardImageAssetWidth,
      @required this.boardHolds,
      @required this.activeBoardHolds,
      @required this.customBoardHoldImages})
      : super(key: key);

  final Size boardSize;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final List<BoardHold> activeBoardHolds;
  final String boardImageAsset;
  final double boardImageAssetWidth;
  final List<BoardHold> boardHolds;
  final void Function(Grip grip, BoardHold boardHold) handleSuccess;
  final Orientation orientation;
  final void Function(Widget errorMessage) setErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        HangBoard(
          boardImageAssetWidth: boardImageAssetWidth,
          boardSize: boardSize,
          customBoardHoldImages: customBoardHoldImages,
          boardImageAsset: boardImageAsset,
        ),
        ...boardHolds.map((BoardHold boardHold) {
          final Rect rect = boardHold.getRect(
              boardHeight: boardSize.height, boardWidth: boardSize.width);
          return Positioned.fromRect(
              rect: rect,
              child: DragTarget(
                builder: (BuildContext context, List<Grip> candidateData,
                    List<dynamic> rejectedData) {
                  if (candidateData.length > 0) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: styles.kBorderRadiusAll,
                          border:
                              Border.all(width: 2, color: styles.Colors.green)),
                    );
                  }
                  if (rejectedData.length > 0) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: styles.kBorderRadiusAll,
                          border: Border.all(
                              width: 2, color: styles.Colors.primary)),
                    );
                  }
                  return Container();
                },
                onWillAccept: (Grip grip) {
                  if (activeBoardHolds.contains(boardHold)) {
                    setErrorMessage(ToastMessages.holdAlreadyTaken());
                    return false;
                  }

                  if (boardHold.checkGripCompatibility(grip) == true) {
                    return true;
                  } else {
                    setErrorMessage(ToastMessages.exceedsSupportedFingers(
                        max: boardHold.supportedFingers));
                    return false;
                  }
                },
                onAccept: (data) {
                  setErrorMessage(null);
                  handleSuccess(data, boardHold);
                },
                onLeave: (data) {},
              ));
        }),
      ],
    );
  }
}
