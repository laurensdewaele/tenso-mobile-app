import 'package:app/models/hold_type.dart';
import 'package:app/services/navigation.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/custom_board/custom_board.dart';
import 'package:flutter/cupertino.dart';

enum InputPageInputTypes {
  sloperDegrees,
  pocketDepth,
  edgeDepth,
  pocketSupportedFingers
}

class InputPageInput {
  final InputPageInputTypes type;
  final String description;
  final bool isInt;

  const InputPageInput(
      {@required this.type, @required this.description, @required this.isInt});
}

class HoldInputViewModel extends ChangeNotifier {
  NavigationService _navigationService;
  CustomBoardViewModel _customBoardViewModel;

  List<InputPageInput> inputPageInputs;
  bool isChooseHoldTypePageActive;
  HoldType _activeHoldType;

  double _sloperDegrees;
  double _pocketDepth;
  double _edgeDepth;
  int _pocketSupportedFingers;

  String _sloperDegreesInput;
  String _pocketDepthInput;
  String _edgeDepthInput;
  String _pocketSupportedFingersInput;

  HoldInputViewModel({@required CustomBoardViewModel customBoardViewModel}) {
    _customBoardViewModel = customBoardViewModel;
    _navigationService = NavigationService();
    inputPageInputs = [];
    isChooseHoldTypePageActive = true;
    notifyListeners();
  }

  void handleHoldTypeTap(HoldType type) {
    switch (type) {
      case HoldType.pinchBlock:
        _customBoardViewModel.handlePinchBlockInput();
        _navigationService.pop();
        break;
      case HoldType.jug:
        _customBoardViewModel.handleJugInput();
        _navigationService.pop();
        break;
      case HoldType.sloper:
        inputPageInputs = []..add(InputPageInput(
            type: InputPageInputTypes.sloperDegrees,
            description: 'degrees of slope',
            isInt: false));
        isChooseHoldTypePageActive = false;
        break;
      case HoldType.pocket:
        inputPageInputs = []
          ..add(InputPageInput(
              type: InputPageInputTypes.pocketDepth,
              description: 'mm of depth',
              isInt: false))
          ..add(InputPageInput(
              type: InputPageInputTypes.pocketSupportedFingers,
              description: 'amount of supported fingers',
              isInt: true));
        isChooseHoldTypePageActive = false;
        break;
      case HoldType.edge:
        inputPageInputs = []..add(InputPageInput(
            type: InputPageInputTypes.edgeDepth,
            description: 'mm of depth',
            isInt: false));
        isChooseHoldTypePageActive = false;
        break;
    }
    _activeHoldType = type;
    notifyListeners();
  }

  void handleInput({String input, InputPageInputTypes type}) {
    switch (type) {
      case InputPageInputTypes.edgeDepth:
        _edgeDepthInput = input;
        break;
      case InputPageInputTypes.pocketSupportedFingers:
        _pocketSupportedFingersInput = input;
        break;
      case InputPageInputTypes.pocketDepth:
        _pocketDepthInput = input;
        break;
      case InputPageInputTypes.sloperDegrees:
        _sloperDegreesInput = input;
        break;
    }
  }

  bool _validateInputs() {
    List<bool> validInputs = [];

    switch (_activeHoldType) {
      case HoldType.sloper:
        _sloperDegrees = InputParsers.parseToDouble(
            string: _sloperDegreesInput, inputField: 'degrees');
        validInputs.add(Validators.biggerThanZero(
            value: _sloperDegrees, inputField: 'degrees'));
        break;
      case HoldType.pocket:
        _pocketDepth = InputParsers.parseToDouble(
            string: _pocketDepthInput, inputField: 'depth');
        _pocketSupportedFingers = InputParsers.parseToInt(
            string: _pocketSupportedFingersInput,
            inputField: 'supported fingers');
        validInputs.add(Validators.biggerThanZero(
            value: _pocketDepth, inputField: 'depth'));
        validInputs.add(Validators.biggerThanZero(
            value: _pocketSupportedFingers, inputField: 'supported fingers'));
        break;
      case HoldType.edge:
        _edgeDepth = InputParsers.parseToDouble(
            string: _edgeDepthInput, inputField: 'depth');
        validInputs.add(
            Validators.biggerThanZero(value: _edgeDepth, inputField: 'depth'));
        break;
      default:
        return false;
    }
    return validInputs.fold(true, (a, b) => a && b);
  }

  void handleNextTap() {
    if (_validateInputs() == true) {
      switch (_activeHoldType) {
        case HoldType.sloper:
          _customBoardViewModel.handleSloperInput(degrees: _sloperDegrees);
          break;
        case HoldType.pocket:
          _customBoardViewModel.handlePocketInput(
              depth: _pocketDepth, supportedFingers: _pocketSupportedFingers);
          break;
        case HoldType.edge:
          _customBoardViewModel.handleEdgeInput(depth: _edgeDepth);
          break;
        default:
          return;
      }
    }
  }
}
