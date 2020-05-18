import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/board_settings.vm.dart';
import 'package:app/view_models/board_settings_state.vm.dart';
import 'package:app/widgets/board/board_picker.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/keyboard_and_toast_provider.dart';
import 'package:app/widgets/keyboard_list_view.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/section.dart';
import 'package:app/widgets/top_navigation.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class BoardSettingsScreen extends StatefulWidget {
  BoardSettingsScreen({Key key}) : super(key: key);

  @override
  _BoardSettingsScreenState createState() => _BoardSettingsScreenState();
}

class _BoardSettingsScreenState extends State<BoardSettingsScreen> {
  BoardSettingsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = BoardSettingsViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Screen(
          handleBackNavigation: () {
            Navigator.of(context).pop();
          },
          gradientStartColor: styles.Colors.bgGrayStart,
          gradientStopColor: styles.Colors.bgGrayStop,
          child: KeyboardListView(children: [
            Column(
              children: <Widget>[
                TopNavigation(
                  handleBackNavigation: _viewModel.handleBackNavigation,
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
                    child: StreamBuilder<Object>(
                        initialData: _viewModel.state,
                        stream: _viewModel.state$,
                        builder: (context, snapshot) {
                          final BoardSettingsViewModelState _state =
                              snapshot.data;
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Section(
                                      title: 'default board',
                                      children: <Widget>[
                                        BoardPicker(
                                          primaryColor: styles.Colors.primary,
                                          boards: _state.boards,
                                          handleBoardChanged:
                                              _viewModel.handleBoardChanged,
                                          selectedBoard: _state.defaultBoard,
                                        )
                                      ],
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
                                    handleTap: _viewModel.handleAddBoardTap,
                                    leadingIcon: icons.plusIconWhiteXl)
                              ]);
                        }),
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
