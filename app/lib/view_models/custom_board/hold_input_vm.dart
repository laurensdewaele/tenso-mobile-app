import 'package:app/models/hold_type.dart';
import 'package:app/services/navigation.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
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
  final String initialValue;

  const InputPageInput(
      {@required this.type,
      @required this.description,
      @required this.isInt,
      @required this.initialValue});
}

class HoldInputViewModel extends ChangeNotifier {
  VoidCallback handlePinchBlockInput;
  VoidCallback handleJugInput;
  void Function({double sloperDegrees}) handleSloperInput;
  void Function({double depth, int supportedFingers}) handlePocketInput;
  void Function({double depth}) handleEdgeInput;
  bool multipleSelection;

  NavigationService _navigationService;

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

  HoldInputViewModel(
      {@required this.handleEdgeInput,
      @required this.handlePocketInput,
      @required this.handleSloperInput,
      @required this.handleJugInput,
      @required this.handlePinchBlockInput,
      @required this.multipleSelection}) {
    _navigationService = NavigationService();
    inputPageInputs = [];
    isChooseHoldTypePageActive = true;
    _sloperDegreesInput = '0';
    _pocketDepthInput = '0';
    _edgeDepthInput = '0';
    _pocketSupportedFingersInput = '5';
    notifyListeners();
  }

  void handleHoldTypeTap(HoldType type) {
    switch (type) {
      case HoldType.pinchBlock:
        handlePinchBlockInput();
        _navigationService.pop();
        break;
      case HoldType.jug:
        handleJugInput();
        _navigationService.pop();
        break;
      case HoldType.sloper:
        inputPageInputs = []..add(InputPageInput(
            type: InputPageInputTypes.sloperDegrees,
            description: 'degrees of slope',
            isInt: false,
            initialValue: _sloperDegreesInput));
        isChooseHoldTypePageActive = false;
        break;
      case HoldType.pocket:
        final List<InputPageInput> _inputs = [];

        _inputs.add(InputPageInput(
            type: InputPageInputTypes.pocketDepth,
            description: 'mm of depth',
            isInt: false,
            initialValue: _pocketDepthInput));
        if (multipleSelection == false) {
          _inputs.add(InputPageInput(
              type: InputPageInputTypes.pocketSupportedFingers,
              description: 'fingers can fit',
              isInt: true,
              initialValue: _pocketSupportedFingersInput));
        }
        inputPageInputs = _inputs;
        isChooseHoldTypePageActive = false;
        break;
      case HoldType.edge:
        inputPageInputs = []..add(InputPageInput(
            type: InputPageInputTypes.edgeDepth,
            description: 'mm of depth',
            isInt: false,
            initialValue: _edgeDepthInput));
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

  void _validateAndSet() {
    if (_validateInputs() == true) {
      switch (_activeHoldType) {
        case HoldType.sloper:
          handleSloperInput(sloperDegrees: _sloperDegrees);
          break;
        case HoldType.pocket:
          handlePocketInput(
              depth: _pocketDepth, supportedFingers: _pocketSupportedFingers);
          break;
        case HoldType.edge:
          handleEdgeInput(depth: _edgeDepth);
          break;
        default:
          return;
      }
    }
  }

  Future<void> handleNextTap() async {
    return Future.sync(_validateAndSet);
  }
}
