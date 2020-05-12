import 'package:app/models/custom_board_hold_image.model.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

class PositionedImage extends StatelessWidget {
  const PositionedImage({
    @required this.customBoardHoldImage,
    @required this.boardSize,
  });

  final CustomBoardHoldImage customBoardHoldImage;
  final Size boardSize;

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
        child: Transform.scale(
          scale: customBoardHoldImage.scale,
          child: Image.asset(
            customBoardHoldImage.imageAsset,
            color: styles.Colors.primary,
            fit: BoxFit.contain,
          ),
        ),
        rect: customBoardHoldImage.getRect(
            boardWidth: boardSize.width, boardHeight: boardSize.height));
  }
}
