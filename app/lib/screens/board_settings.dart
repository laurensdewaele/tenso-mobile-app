import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/board_settings.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/top_navigation.dart';

class BoardSettingsScreen extends StatefulWidget {
  BoardSettingsScreen({Key key}) : super(key: key);

  @override
  _BoardSettingsScreenState createState() => _BoardSettingsScreenState();
}

class _BoardSettingsScreenState extends State<BoardSettingsScreen> {
  BoardSettingsViewModel _viewModel;

  @override
  void initState() {
    _viewModel = BoardSettingsViewModel();
    _viewModel.addListener(_viewModelListener);
    super.initState();
  }

  void _viewModelListener() {
    setState(() {});
  }

  @override
  void dispose() {
    _viewModel.removeListener(_viewModelListener);
    super.dispose();
  }

  void _handleAddBoardTap() {
    Navigator.of(context).pushNamed(Routes.customBoardScreen);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Screen(
          gradientStartColor: styles.Colors.bgGrayStart,
          gradientStopColor: styles.Colors.bgGrayStop,
          child: KeyboardListView(children: [
            Column(
              children: <Widget>[
                TopNavigation(
                  handleBackNavigation: () {
                    Navigator.of(context).pop();
                  },
                  title: 'board settings',
                  dark: true,
                ),
                Divider(height: styles.Measurements.xxl),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                  child: Card(
                    padding: EdgeInsets.symmetric(
                        horizontal: styles.Measurements.m,
                        vertical: styles.Measurements.l),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Section(
                                title: 'default board',
                                children: <Widget>[],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Section(
                                title: 'custom boards',
                                children: <Widget>[],
                              ),
                            ],
                          ),
                          Button(
                              text: 'Add custom board',
                              handleTap: _handleAddBoardTap,
                              leadingIcon: icons.plusIconWhiteXl)
                        ]),
                  ),
                ),
                Divider(
                  height: styles.Measurements.xxl,
                )
              ],
            )
          ])),
    );
  }
}
