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

  final Map<int, Grip> _gripsL = {
    4: Grips.openHandL,
    3: Grips.frontThreeL,
    2: Grips.frontTwoL,
    1: Grips.monoIndexL
  };
  final Map<int, Grip> _gripsR = {
    4: Grips.openHandR,
    3: Grips.frontThreeR,
    2: Grips.frontTwoR,
    1: Grips.monoIndexR
  };

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

  Grip _matchGripL(int supportedFingers, int attempt) {
    if (supportedFingers == null) {
      return _gripsL[4];
    }

    if (attempt <= supportedFingers) {
      return _gripsL[attempt];
    } else {
      return _matchGripL(supportedFingers, attempt - 1);
    }
  }

  Grip _matchGripR(int supportedFingers, int attempt) {
    if (supportedFingers == null) {
      return _gripsR[4];
    }

    if (attempt <= supportedFingers) {
      return _gripsR[attempt];
    } else {
      return _matchGripR(supportedFingers, attempt - 1);
    }
  }

  void _setGripsAndBoardHoldsAndNotify() {
    _leftGripBoardHold = _boardHolds[0];
    _rightGripBoardHold = _boardHolds[boardHolds.length - 1];
    _leftGrip = _matchGripL(_leftGripBoardHold.supportedFingers, 4);
    _rightGrip = _matchGripR(_rightGripBoardHold.supportedFingers, 4);
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
