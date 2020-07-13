import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/board_settings.vm.dart';
import 'package:app/view_models/board_settings_state.vm.dart';
import 'package:app/widgets/board/board_picker.dart';
import 'package:app/widgets/board/hang_board.dart';
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/dialog.dart';
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

  void _handleCustomBoardPress(Board customBoard) async {
    await showAppDialog(
        smallWidth: true,
        context: context,
        content: _CustomBoardPressDialog(
          customBoardName: customBoard.name,
          handleDeleteTap: () =>
              _viewModel.handleDeleteCustomBoard(customBoard),
          handleBackTap: () => Navigator.of(context).pop(),
          handleEditTap: () => _viewModel.handleEditCustomBoard(customBoard),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAndToastProvider(
      child: Screen(
          handleBackNavigation: () {
            Navigator.of(context).pop();
          },
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
                          final List<Board> _customBoards = _state.boards
                              .where((Board board) => board.isCustom)
                              .toList();

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
                                      children: <Widget>[
                                        if (_customBoards.length == 0)
                                          Text(
                                            'No custom boards have been created.',
                                            style: styles.Lato.xsBlack,
                                          ),
                                        ..._customBoards.map((Board
                                                customBoard) =>
                                            GestureDetector(
                                              onTap: () =>
                                                  _handleCustomBoardPress(
                                                      customBoard),
                                              onHorizontalDragEnd: (details) =>
                                                  _handleCustomBoardPress(
                                                      customBoard),
                                              child: Column(
                                                children: <Widget>[
                                                  _CustomBoard(
                                                    customBoard: customBoard,
                                                  ),
                                                  if (_customBoards.indexOf(
                                                          customBoard) !=
                                                      _customBoards.length - 1)
                                                    Divider(
                                                      height: styles
                                                          .Measurements.xl,
                                                    )
                                                ],
                                              ),
                                            ))
                                      ],
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

class _CustomBoard extends StatelessWidget {
  _CustomBoard({Key key, @required this.customBoard}) : super(key: key);

  final Board customBoard;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            customBoard.capitalizedName,
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.s,
          ),
          HangBoard(
            boardSize: Size(constraints.maxWidth,
                constraints.maxWidth / customBoard.aspectRatio),
            customBoardHoldImages: customBoard.customBoardHoldImages?.toList(),
            boardImageAsset: customBoard.imageAsset,
            boardImageAssetWidth: customBoard.imageAssetWidth,
          )
        ],
      );
    });
  }
}

class _CustomBoardPressDialog extends StatelessWidget {
  _CustomBoardPressDialog(
      {Key key,
      @required this.handleDeleteTap,
      @required this.handleEditTap,
      @required this.handleBackTap,
      @required this.customBoardName})
      : super(key: key);

  final VoidCallback handleEditTap;
  final VoidCallback handleDeleteTap;
  final VoidCallback handleBackTap;
  final String customBoardName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          customBoardName,
          style: styles.Staatliches.lBlack,
        ),
        Divider(height: styles.Measurements.l),
        Button(
            text: 'Edit',
            backgroundColor: styles.Colors.blue,
            displayBackground: true,
            leadingIcon: icons.editIconWhiteXl,
            handleTap: handleEditTap,
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.m),
        Button(
            text: 'Delete',
            backgroundColor: styles.Colors.primary,
            displayBackground: true,
            leadingIcon: icons.deleteIconWhiteXl,
            handleTap: handleDeleteTap,
            leadingIconTextCentered: true),
        Divider(height: styles.Measurements.l),
        Button(
            displayBackground: false,
            text: 'Back',
            handleTap: handleBackTap,
            small: true)
      ],
    );
  }
}
