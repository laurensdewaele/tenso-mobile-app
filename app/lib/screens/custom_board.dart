import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/bottom_menu_drawer.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';

class CustomBoardScreen extends StatefulWidget {
  CustomBoardScreen({Key key}) : super(key: key);

  @override
  _CustomBoardScreenState createState() => _CustomBoardScreenState();
}

class _CustomBoardScreenState extends State<CustomBoardScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Screen(
          gradientStartColor: styles.Colors.bgGrayStart,
          gradientStopColor: styles.Colors.bgGrayStop,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TopNavigation(
                title: 'custom board',
                dark: true,
                handleBackNavigation: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                styles.Measurements.xs, 64, styles.Measurements.xs, 45),
            child: ClipRRect(
                borderRadius: styles.kBorderRadiusAll,
                child: Image.asset('assets/images/boards/custom_board.png')),
          ),
        ),
        BottomMenuDrawer()
      ],
    );
  }
}
