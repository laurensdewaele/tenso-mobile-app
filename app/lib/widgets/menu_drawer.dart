import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/dividers.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key key, this.menuItems, this.handleMenuItemTap})
      : super(key: key);

  final List<MenuItem> menuItems;
  final VoidCallback handleMenuItemTap;

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: styles.Colors.bgWhite,
            borderRadius: BorderRadius.only(
                topLeft: styles.kAppBorderRadius,
                topRight: styles.kAppBorderRadius),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0005, 0.005],
              colors: [styles.Colors.bgGrayStop, styles.Colors.bgWhite],
            ),
          ),
          child: SafeArea(
              top: false,
              child: Column(
                children: <Widget>[
                  Divider(),
                  _RedDragIndicatorRectangle(),
                ],
              )),
        )
      ],
    );
  }
}

class _RedDragIndicatorRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 3.0,
      decoration: BoxDecoration(
          color: styles.Colors.primary,
          borderRadius: styles.kAppBorderRadiusAll),
    );
  }
}
