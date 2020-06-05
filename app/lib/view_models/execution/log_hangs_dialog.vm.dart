import 'package:app/models/models.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/services/parser.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:app/widgets/execution/log_hangs_dialog.dart';
import 'package:flutter/cupertino.dart';

class PastHang {
  final bool skipped;
  final double effectiveDurationS;
  final String effectiveDurationSInput;
  final double addedWeight;
  final String addedWeightInput;
  final int totalSets;
  final int totalHangsPerSet;
  final int currentHangPerSet;
  final int currentSet;
  final int currentHang;
  final bool isSelected;
  final double boardAspectRatio;
  final String imageAsset;
  final double imageAssetWidth;
  final List<CustomBoardHoldImage> customBoardHoldImages;
  final double handToBoardHeightRatio;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final String weightUnit;

  const PastHang({
    @required this.skipped,
    @required this.effectiveDurationS,
    @required this.effectiveDurationSInput,
    @required this.addedWeight,
    @required this.addedWeightInput,
    @required this.totalSets,
    @required this.totalHangsPerSet,
    @required this.currentHangPerSet,
    @required this.currentSet,
    @required this.currentHang,
    @required this.isSelected,
    @required this.boardAspectRatio,
    @required this.imageAsset,
    @required this.imageAssetWidth,
    @required this.customBoardHoldImages,
    @required this.handToBoardHeightRatio,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.weightUnit,
  });

  PastHang copyWith({
    bool skipped,
    double effectiveDurationS,
    String effectiveDurationSInput,
    double addedWeight,
    String addedWeightInput,
    int totalSets,
    int totalHangsPerSet,
    int currentHangPerSet,
    int currentSet,
    int currentHang,
    bool isSelected,
    double boardAspectRatio,
    String imageAsset,
    double imageAssetWidth,
    List<CustomBoardHoldImage> customBoardHoldImages,
    double handToBoardHeightRatio,
    BoardHold leftGripBoardHold,
    BoardHold rightGripBoardHold,
    Grip leftGrip,
    Grip rightGrip,
    String weightUnit,
  }) {
    return new PastHang(
      skipped: skipped ?? this.skipped,
      effectiveDurationS: effectiveDurationS ?? this.effectiveDurationS,
      effectiveDurationSInput:
          effectiveDurationSInput ?? this.effectiveDurationSInput,
      addedWeight: addedWeight ?? this.addedWeight,
      addedWeightInput: addedWeightInput ?? this.addedWeightInput,
      totalSets: totalSets ?? this.totalSets,
      totalHangsPerSet: totalHangsPerSet ?? this.totalHangsPerSet,
      currentHangPerSet: currentHangPerSet ?? this.currentHangPerSet,
      currentSet: currentSet ?? this.currentSet,
      currentHang: currentHang ?? this.currentHang,
      isSelected: isSelected ?? this.isSelected,
      boardAspectRatio: boardAspectRatio ?? this.boardAspectRatio,
      imageAsset: imageAsset ?? this.imageAsset,
      imageAssetWidth: imageAssetWidth ?? this.imageAssetWidth,
      customBoardHoldImages:
          customBoardHoldImages ?? this.customBoardHoldImages,
      handToBoardHeightRatio:
          handToBoardHeightRatio ?? this.handToBoardHeightRatio,
      leftGripBoardHold: leftGripBoardHold ?? this.leftGripBoardHold,
      rightGripBoardHold: rightGripBoardHold ?? this.rightGripBoardHold,
      leftGrip: leftGrip ?? this.leftGrip,
      rightGrip: rightGrip ?? this.rightGrip,
      weightUnit: weightUnit ?? this.weightUnit,
    );
  }
}

class LogHangsDialogViewModel extends ChangeNotifier {
  NavigationService _navigationService;
  void Function(List<LoggedHang> loggedHangs) handleLoggedHangs;

  List<PastHang> _pastHangs;
  List<PastHang> get pastHangs => _pastHangs;

  PastHang get selectedPastHang =>
      _pastHangs.firstWhere((PastHang pastHang) => pastHang.isSelected == true);
  int get _selectedPastHangIndex => _pastHangs.indexOf(selectedPastHang);

  bool _canScroll;
  bool get canScroll => _canScroll;

  String get hangText =>
      'Hang ${selectedPastHang.currentHangPerSet}/${selectedPastHang.totalHangsPerSet}';
  String get setText =>
      'set ${selectedPastHang.currentSet}/${selectedPastHang.totalSets}';

  LogHangsDialogViewModel(
      {@required List<PastHang> pastHangs, @required this.handleLoggedHangs}) {
    _pastHangs = pastHangs;
    _canScroll = true;
    _navigationService = NavigationService();
    notifyListeners();
  }

  void setSelectedPastHang(int index) {
    List<PastHang> _newPastHangs = []..addAll(_pastHangs);
    _newPastHangs[_selectedPastHangIndex] =
        selectedPastHang.copyWith(isSelected: false);
    _newPastHangs[index] = _newPastHangs[index].copyWith(isSelected: true);
    _pastHangs = _newPastHangs;
    notifyListeners();
  }

  void setHangTimeInput(String s) {
    List<PastHang> _newPastHangs = []..addAll(_pastHangs);
    _newPastHangs[_selectedPastHangIndex] =
        selectedPastHang.copyWith(effectiveDurationSInput: s);
    _pastHangs = _newPastHangs;
    try {
      final double _effectiveDurationS =
          InputParsers.parseToDouble(string: s, inputField: 'Duration');
      Validators.biggerOrEqualToZero(
          value: _effectiveDurationS, inputField: 'Duration');
      _canScroll = true;
    } on FormatException {
      _canScroll = false;
    } on ParseException {
      _canScroll = false;
    }
    notifyListeners();
  }

  void setAddedWeightInput(String s) {
    List<PastHang> _newPastHangs = []..addAll(_pastHangs);
    _newPastHangs[_selectedPastHangIndex] =
        selectedPastHang.copyWith(addedWeightInput: s);
    _pastHangs = _newPastHangs;
    try {
      InputParsers.parseToDouble(string: s, inputField: 'Added weight');
      _canScroll = true;
    } on FormatException {
      _canScroll = false;
    } on ParseException {
      _canScroll = false;
    }
    notifyListeners();
  }

  bool _validate() {
    final double _effectiveDurationS = InputParsers.parseToDouble(
        string: selectedPastHang.effectiveDurationSInput,
        inputField: 'Duration');

    final bool _validDuration = Validators.biggerOrEqualToZero(
        value: _effectiveDurationS, inputField: 'Duration');

    final double _addedWeight = InputParsers.parseToDouble(
        string: selectedPastHang.addedWeightInput, inputField: 'Added weight');

    final bool _isValid = _addedWeight != null && _validDuration == true;

    if (_isValid == true) {
      List<PastHang> _newPastHangs = []..addAll(_pastHangs);
      _newPastHangs[_selectedPastHangIndex] = selectedPastHang.copyWith(
          effectiveDurationS: _effectiveDurationS,
          addedWeight: _addedWeight,
          currentHang: selectedPastHang.currentHang);
      _pastHangs = _newPastHangs;
    }

    return _isValid;
  }

  Future<bool> handleScrollAttempt() {
    return Future.sync(_validate);
  }

  Future<bool> handleDone() {
    return Future.sync(() {
      final bool _isValid = _validate();
      if (_isValid == true) {
        final List<LoggedHang> _loggedHangs = _pastHangs
            .map((PastHang pastHang) => LoggedHang(
                addedWeight: pastHang.addedWeight,
                currentHang: pastHang.currentHang,
                effectiveDurationS: pastHang.effectiveDurationS))
            .toList();
        _navigationService.pop();
        handleLoggedHangs(_loggedHangs);
        return true;
      } else {
        return false;
      }
    });
  }
}
