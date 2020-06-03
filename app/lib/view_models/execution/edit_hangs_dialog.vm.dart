import 'package:app/models/models.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/services/parser.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hang {
  final int duration;
  final String durationInput;
  final double addedWeight;
  final String addedWeightInput;
  final int totalSets;
  final int totalHangsPerSet;
  final int currentHangPerSet;
  final int currentSet;
  final int currentHang;
  final bool isPastHang;
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

  const Hang({
    @required this.duration,
    @required this.durationInput,
    @required this.addedWeight,
    @required this.addedWeightInput,
    @required this.totalSets,
    @required this.totalHangsPerSet,
    @required this.currentHangPerSet,
    @required this.currentSet,
    @required this.currentHang,
    @required this.isPastHang,
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

  Hang copyWith({
    int duration,
    String durationInput,
    double addedWeight,
    String addedWeightInput,
    int totalSets,
    int totalHangsPerSet,
    int currentHangPerSet,
    int currentSet,
    int currentHang,
    bool isPastHang,
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
    return new Hang(
      duration: duration ?? this.duration,
      durationInput: durationInput ?? this.durationInput,
      addedWeight: addedWeight ?? this.addedWeight,
      addedWeightInput: addedWeightInput ?? this.addedWeightInput,
      totalSets: totalSets ?? this.totalSets,
      totalHangsPerSet: totalHangsPerSet ?? this.totalHangsPerSet,
      currentHangPerSet: currentHangPerSet ?? this.currentHangPerSet,
      currentSet: currentSet ?? this.currentSet,
      currentHang: currentHang ?? this.currentHang,
      isPastHang: isPastHang ?? this.isPastHang,
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

class LoggedEffectiveMetrics {
  final int duration;
  final double addedWeight;
  final int currentHang;

  const LoggedEffectiveMetrics({
    @required this.duration,
    @required this.addedWeight,
    @required this.currentHang,
  });
}

class EditHangsDialogViewModel extends ChangeNotifier {
  NavigationService _navigationService;
  void Function(List<LoggedEffectiveMetrics> loggedEffectiveMetrics)
      handleLoggedEffectiveMetrics;

  List<Hang> _hangs;
  List<Hang> get hangs => _hangs;

  Hang get selectedHang =>
      _hangs.firstWhere((Hang hang) => hang.isSelected == true);
  int get _selectedHangIndex => _hangs.indexOf(selectedHang);

  bool _canScroll;
  bool get canScroll => _canScroll;

  String get hangText =>
      'Hang ${selectedHang.currentHangPerSet}/${selectedHang.totalHangsPerSet}';
  String get setText =>
      'set ${selectedHang.currentSet}/${selectedHang.totalSets}';

  EditHangsDialogViewModel(
      {@required List<Hang> hangs,
      @required this.handleLoggedEffectiveMetrics}) {
    _hangs = hangs;
    _canScroll = true;
    _navigationService = NavigationService();
    notifyListeners();
  }

  void setSelectedHang(int index) {
    List<Hang> _newHangs = []..addAll(_hangs);
    _newHangs[_selectedHangIndex] = selectedHang.copyWith(isSelected: false);
    _newHangs[index] = _newHangs[index].copyWith(isSelected: true);
    _hangs = _newHangs;
    notifyListeners();
  }

  void setHangTimeInput(String s) {
    List<Hang> _newHangs = []..addAll(_hangs);
    _newHangs[_selectedHangIndex] = selectedHang.copyWith(durationInput: s);
    _hangs = _newHangs;
    try {
      final int _duration =
          InputParsers.parseToInt(string: s, inputField: 'Duration');
      Validators.biggerOrEqualToZero(value: _duration, inputField: 'Duration');
      _canScroll = true;
    } on FormatException {
      _canScroll = false;
    } on ParseException {
      _canScroll = false;
    }
    notifyListeners();
  }

  void setAddedWeightInput(String s) {
    List<Hang> _newHangs = []..addAll(_hangs);
    _newHangs[_selectedHangIndex] = selectedHang.copyWith(addedWeightInput: s);
    _hangs = _newHangs;
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
    final int _duration = InputParsers.parseToInt(
        string: selectedHang.durationInput, inputField: 'Duration');

    final bool _validDuration = Validators.biggerOrEqualToZero(
        value: _duration, inputField: 'Duration');

    final double _addedWeight = InputParsers.parseToDouble(
        string: selectedHang.addedWeightInput, inputField: 'Added weight');

    final bool _isValid = _addedWeight != null && _validDuration == true;

    if (_isValid == true) {
      List<Hang> _newHangs = []..addAll(_hangs);
      _newHangs[_selectedHangIndex] = selectedHang.copyWith(
          duration: _duration,
          addedWeight: _addedWeight,
          currentHang: selectedHang.currentHang);
      _hangs = _newHangs;
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
        final List<LoggedEffectiveMetrics> _loggedMetrics = _hangs
            .map((Hang hang) => LoggedEffectiveMetrics(
                addedWeight: hang.addedWeight,
                currentHang: hang.currentHang,
                duration: hang.duration))
            .toList();
        _navigationService.pop();
        handleLoggedEffectiveMetrics(_loggedMetrics);
        return true;
      } else {
        return false;
      }
    });
  }
}
