import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/screens/custom_board.screen.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/state/boards.state.dart';
import 'package:tenso_app/state/settings.state.dart';
import 'package:tenso_app/view_models/board_settings_state.vm.dart';

class BoardSettingsViewModel {
  SettingsState _settingsState;
  BoardsState _boardsState;
  NavigationService _navigationService;

  StreamSubscription _sub;
  StreamSubscription _sub2;

  BehaviorSubject<BoardSettingsViewModelState> _state$;
  Stream<BoardSettingsViewModelState> get state$ => _state$.stream;
  BoardSettingsViewModelState get state => _state$.value;

  BoardSettingsViewModel() {
    _settingsState = SettingsState();
    _boardsState = BoardsState();
    _navigationService = NavigationService();
    _init();
  }

  void _init() {
    _state$ = BehaviorSubject.seeded(BoardSettingsViewModelState(
        boards: _boardsState.boardsList,
        defaultBoard: _settingsState.settings.defaultBoard));

    _sub = _boardsState.boards$.listen((Boards boards) {
      _state$.add(state.copyWith(boards: boards.boards.toList()));
    });

    _sub2 = _settingsState.settings$.listen((Settings settings) {
      _state$.add(state.copyWith(defaultBoard: settings.defaultBoard));
    });
  }

  void handleBoardChanged(Board board) {
    _setDefaultBoard(board);
  }

  void _setDefaultBoard(Board board) {
    _settingsState.setDefaultBoard(board);
  }

  void handleAddBoardTap() {
    _navigationService.pushNamed(Routes.customBoardScreen);
  }

  void handleBackNavigation() {
    _navigationService.pushNamed(Routes.settingsScreen);
  }

  void handleDeleteCustomBoard(Board customBoard) {
    if (state.defaultBoard == customBoard) {
      _setDefaultBoard(
          state.boards.firstWhere((Board board) => board.id != customBoard.id));
    }
    _boardsState.deleteBoard(customBoard);
    _navigationService.pop();
  }

  void handleEditCustomBoard(Board customBoard) async {
    _navigationService.pop();
    _navigationService.pushNamed(Routes.customBoardScreen,
        arguments: CustomBoardScreenArguments(boardToEdit: customBoard));
  }

  void dispose() {
    _state$.close();
    _sub.cancel();
    _sub2.cancel();
  }
}
