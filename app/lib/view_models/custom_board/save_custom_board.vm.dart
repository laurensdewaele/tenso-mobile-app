import 'dart:math';

import 'package:app/data/custom_board.data.dart';
import 'package:app/data/grips.data.dart';
import 'package:app/helpers/unique_id.dart';
import 'package:app/models/custom_board_hold_image.model.dart';
import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/services/parser.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:app/state/boards.state.dart';
import 'package:app/state/settings.state.dart';
import 'package:flutter/cupertino.dart';

class SaveCustomBoardViewModel extends ChangeNotifier {
  SaveCustomBoardViewModel({
    @required List<BoardHold> boardHolds,
    @required List<CustomBoardHoldImage> customBoardHoldImages,
    @required String boardToEditName,
    @required String boardToEditId,
  }) {
    _boardsState = BoardsState();
    _settingsState = SettingsState();
    _boardToEditId = boardToEditId;
    _nameInput = boardToEditName;
    _name = boardToEditName;
    _boardHolds = boardHolds;
    _customBoardHoldImages = customBoardHoldImages;
    _setGripsAndBoardHoldsAndNotify();
  }

  BoardsState _boardsState;
  SettingsState _settingsState;

  List<BoardHold> _boardHolds;
  List<BoardHold> get boardHolds => _boardHolds;
  List<CustomBoardHoldImage> _customBoardHoldImages;
  List<CustomBoardHoldImage> get customBoardHoldImages =>
      _customBoardHoldImages;

  String _nameInput;
  String _name;
  String get initialName => _name;
  String _boardToEditId;

  Grip _leftGrip;
  Grip get leftGrip => _leftGrip;
  Grip _rightGrip;
  Grip get rightGrip => _rightGrip;
  BoardHold _leftGripBoardHold;
  BoardHold get leftGripBoardHold => _leftGripBoardHold;
  BoardHold _rightGripBoardHold;
  BoardHold get rightGripBoardHold => _rightGripBoardHold;

  void _setGripsAndBoardHoldsAndNotify() {
    final _sorted = []..addAll(_boardHolds);
    _sorted.sort((a, b) => a.position.compareTo(b.position));
    _leftGripBoardHold = _sorted[0];
    _rightGripBoardHold = _sorted[_sorted.length - 1];
    final List<int> _supportedFingers = _boardHolds
        .map((BoardHold boardHold) => boardHold.supportedFingers)
        .toList();
    _supportedFingers.removeWhere((f) => f == null);
    final int _minSupportedFingers =
        _supportedFingers != null && _supportedFingers.length > 0
            ? _supportedFingers.reduce(min)
            : 5;

    _leftGrip = Grips.matchSupportedFingersL(_minSupportedFingers);
    _rightGrip = Grips.matchSupportedFingersR(_minSupportedFingers);
    notifyListeners();
  }

  void handleLeftGripBoardHoldChanged(BoardHold boardHold) {
    _leftGripBoardHold = boardHold;
    notifyListeners();
  }

  void handleRightGripBoardHoldChanged(BoardHold boardHold) {
    _rightGripBoardHold = boardHold;
    notifyListeners();
  }

  void setName(String nameInput) {
    _nameInput = nameInput;
  }

  bool _validateAndSave() {
    _name = InputParsers.parseString(string: _nameInput);
    final _valid = Validators.stringNotEmpty(string: _name, inputField: 'Name');
    if (_valid == true) {
      final Board _board = Board((b) => b
        ..id = _boardToEditId ?? generateUniqueId()
        ..name = _name
        ..imageAsset = kImageAsset
        ..imageAssetWidth = kImageAssetWidth
        ..imageAssetHeight = kImageAssetHeight
        ..handToBoardHeightRatio = kHandToBoardHeightRatio
        ..boardHolds.addAll(boardHolds)
        ..customBoardHoldImages.addAll(customBoardHoldImages)
        ..defaultLeftGripHold = leftGripBoardHold.toBuilder()
        ..defaultRightGripHold = rightGripBoardHold.toBuilder());

      if (_boardToEditId != null) {
        _boardsState.editBoard(boardId: _boardToEditId, updatedBoard: _board);
        if (_settingsState.settings.defaultBoard.id == _boardToEditId) {
          _settingsState.setDefaultBoard(_board);
        }
      } else {
        _boardsState.addBoard(_board);
      }

      NavigationService().pushNamed(Routes.boardSettingsScreen);
    }
    return _valid;
  }

  Future<bool> save() {
    return Future.sync(_validateAndSave);
  }
}
