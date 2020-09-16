import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/styles/styles.dart' as styles;

class Box extends StatelessWidget {
  Box({Key key, @required this.handleTap}) : super(key: key);

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border:
                Border.all(width: 1, color: styles.Colors.whiteTranslucent)),
        child: Center(
          child: icons.plusIconWhiteS,
        ),
      ),
    );
  }
}

class SelectedBox extends StatelessWidget {
  SelectedBox({Key key, @required this.handleTap}) : super(key: key);

  final VoidCallback handleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: styles.kBorderRadiusAll,
            border: Border.all(width: 1, color: styles.Colors.black)),
        child: Center(
          child: icons.selectedIconBlackS,
        ),
      ),
    );
  }
}
