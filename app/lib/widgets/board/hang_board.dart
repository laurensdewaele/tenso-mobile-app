import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/custom_board/positioned_image.dart';
import 'package:flutter/cupertino.dart';

class HangBoard extends StatelessWidget {
  HangBoard(
      {Key key,
      @required this.boardSize,
      @required this.boardImageAsset,
      @required this.boardImageAssetWidth,
      @required this.customBoardHoldImages})
      : super(key: key);

  final Size boardSize;
  final String boardImageAsset;
  final double boardImageAssetWidth;
  final List<CustomBoardHoldImage> customBoardHoldImages;

  @override
  Widget build(BuildContext context) {
    final double imageScale = boardSize.width > boardImageAssetWidth
        ? boardImageAssetWidth / boardSize.width
        : 1.0;

    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        ClipRRect(
            borderRadius: styles.kBorderRadiusAll,
            child: Image.asset(
              boardImageAsset,
              scale: imageScale,
              fit: BoxFit.contain,
            )),
        if (customBoardHoldImages != null && customBoardHoldImages.length > 0)
          ...customBoardHoldImages.map(
              (CustomBoardHoldImage customBoardHoldImage) =>
                  PositionedCustomBoardHoldImage(
                      isSelected: false,
                      customBoardHoldImage: customBoardHoldImage,
                      boardSize: boardSize)),
      ],
    );
  }
}
