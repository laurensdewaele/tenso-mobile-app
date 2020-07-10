import 'package:app/models/custom_board_hold_image.model.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

class PositionedCustomBoardHoldImage extends StatelessWidget {
  const PositionedCustomBoardHoldImage({
    @required this.customBoardHoldImage,
    @required this.boardSize,
    @required this.isSelected,
  });

  final CustomBoardHoldImage customBoardHoldImage;
  final Size boardSize;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Widget _image;

    if (isSelected == true) {
      _image = Image.asset(
        customBoardHoldImage.imageAsset,
        color: styles.Colors.primary,
        fit: BoxFit.contain,
      );
    } else {
      _image = Image.asset(
        customBoardHoldImage.imageAsset,
        fit: BoxFit.contain,
      );
    }

    return Positioned.fromRect(
        child: Transform.scale(
          scale: customBoardHoldImage.scale,
          child: _image,
        ),
        rect: customBoardHoldImage.getRect(
            boardWidth: boardSize.width, boardHeight: boardSize.height));
  }
}
