import 'dart:math';

import 'package:app/data/grips.dart';
import 'package:app/models/custom_board_hold_image.dart';
import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:flutter/cupertino.dart';

class SaveCustomBoardViewModel extends ChangeNotifier {
  SaveCustomBoardViewModel({
    @required List<BoardHold> boardHolds,
    @required List<CustomBoardHoldImage> customBoardHoldImages,
  }) {
    _boardHolds = boardHolds;
    _customBoardHoldImages = customBoardHoldImages;
    _setGripsAndBoardHoldsAndNotify();
  }

  List<BoardHold> _boardHolds;
  List<BoardHold> get boardHolds => _boardHolds;
  List<CustomBoardHoldImage> _customBoardHoldImages;
  List<CustomBoardHoldImage> get customBoardHoldImages =>
      _customBoardHoldImages;

  String _nameInput;
  String _name;

  Grip _leftGrip;
  Grip get leftGrip => _leftGrip;
  Grip _rightGrip;
  Grip get rightGrip => _rightGrip;
  BoardHold _leftGripBoardHold;
  BoardHold get leftGripBoardHold => _leftGripBoardHold;
  BoardHold _rightGripBoardHold;
  BoardHold get rightGripBoardHold => _rightGripBoardHold;

  void _setGripsAndBoardHoldsAndNotify() {
    _leftGripBoardHold = _boardHolds[0];
    _rightGripBoardHold = _boardHolds[boardHolds.length - 1];
    final List<int> _supportedFingers = _boardHolds
        .map((BoardHold boardHold) => boardHold.supportedFingers)
        .toList();
    _supportedFingers.removeWhere((f) => f == null);
    final int _lowestSupportedFingers =
        _supportedFingers != null && _supportedFingers.length > 0
            ? _supportedFingers.reduce(min)
            : 5;

    Grips.matchSupportedFingersL(_lowestSupportedFingers);
    _leftGrip = Grips.matchSupportedFingersL(_lowestSupportedFingers);
    _rightGrip = Grips.matchSupportedFingersR(_lowestSupportedFingers);
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
      print('saving');
    }
    return _valid;
  }

  Future<bool> save() {
    return Future.sync(_validateAndSave);
  }
}
