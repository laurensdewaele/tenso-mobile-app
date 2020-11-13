import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/common/icon_button.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/styles/styles.dart' as styles;

class SectionForwardNav extends StatelessWidget {
  SectionForwardNav(
      {Key key,
      @required this.title,
      @required this.handleNavigation,
      this.padding})
      : super(key: key);

  final String title;
  final VoidCallback handleNavigation;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
                padding: padding ?? EdgeInsets.zero,
                child: Text(
                  title,
                  style: styles.Staatliches.xlBlack,
                )),
            IconButton(handleTap: () {}, icon: icons.forwardIconBlackL)
          ],
        ),
        GestureDetector(
            onTap: handleNavigation,
            child: Container(
              decoration: BoxDecoration(color: styles.Colors.translucent),
              width: double.infinity,
              height: 66,
            )),
      ],
    );
  }
}
