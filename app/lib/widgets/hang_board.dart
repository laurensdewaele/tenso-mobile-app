import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

class HangBoard extends StatelessWidget {
  HangBoard(
      {Key key,
      @required this.boardSize,
      @required this.boardImageAsset,
      @required this.customBoardHoldImages})
      : super(key: key);

  final Size boardSize;
  final String boardImageAsset;
  final List<CustomBoardHoldImage> customBoardHoldImages;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        ClipRRect(
            borderRadius: styles.kBorderRadiusAll,
            child: Image.asset(boardImageAsset)),
        if (customBoardHoldImages != null && customBoardHoldImages.length > 0)
          ...customBoardHoldImages.map((CustomBoardHoldImage image) =>
              Positioned.fromRect(
                  child: Transform.scale(
                    scale: image.scale,
                    child: Image.asset(
                      image.imageAsset,
                      fit: BoxFit.contain,
                    ),
                  ),
                  rect: image.getRect(
                      boardWidth: boardSize.width,
                      boardHeight: boardSize.height))),
      ],
    );
  }
}
