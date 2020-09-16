import 'package:flutter/cupertino.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/execution/adjust_hangs_dialog.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/validation.service.dart';

class PastHang {
  final int sequenceTimerIndex;
  final bool skipped;
  final double effectiveDurationS;
  final String effectiveDurationSInput;
  final double effectiveAddedWeight;
  final String effectiveAddedWeightInput;
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
  final int totalGroups;
  final int currentGroup;
  final int totalSets;
  final int currentSet;
  final int totalReps;
  final int currentRep;

  const PastHang({
    @required this.sequenceTimerIndex,
    @required this.skipped,
    @required this.effectiveDurationS,
    @required this.effectiveDurationSInput,
    @required this.effectiveAddedWeight,
    @required this.effectiveAddedWeightInput,
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
    @required this.totalGroups,
    @required this.currentGroup,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalReps,
    @required this.currentRep,
  });

  PastHang copyWith({
    int sequenceTimerIndex,
    bool skipped,
    double effectiveDurationS,
    String effectiveDurationSInput,
    double effectiveAddedWeight,
    String effectiveAddedWeightInput,
    bool isSelected,
    double boardAspectRatio,
    String imageAsset,
    double imageAssetWidth,
    List<CustomBoardHoldImage> customBoardHoldImages,
    double handToBoardHeightRatio,
    Nullable<BoardHold> leftGripBoardHold,
    Nullable<BoardHold> rightGripBoardHold,
    Nullable<Grip> leftGrip,
    Nullable<Grip> rightGrip,
    String weightUnit,
    int totalGroups,
    int currentGroup,
    int totalSets,
    int currentSet,
    int totalReps,
    int currentRep,
  }) {
    return new PastHang(
      sequenceTimerIndex: sequenceTimerIndex ?? this.sequenceTimerIndex,
      skipped: skipped ?? this.skipped,
      effectiveDurationS: effectiveDurationS ?? this.effectiveDurationS,
      effectiveDurationSInput:
          effectiveDurationSInput ?? this.effectiveDurationSInput,
      effectiveAddedWeight: effectiveAddedWeight ?? this.effectiveAddedWeight,
      effectiveAddedWeightInput:
          effectiveAddedWeightInput ?? this.effectiveAddedWeightInput,
      isSelected: isSelected ?? this.isSelected,
      boardAspectRatio: boardAspectRatio ?? this.boardAspectRatio,
      imageAsset: imageAsset ?? this.imageAsset,
      imageAssetWidth: imageAssetWidth ?? this.imageAssetWidth,
      customBoardHoldImages:
          customBoardHoldImages ?? this.customBoardHoldImages,
      handToBoardHeightRatio:
          handToBoardHeightRatio ?? this.handToBoardHeightRatio,
      leftGripBoardHold: leftGripBoardHold == null
          ? this.leftGripBoardHold
          : leftGripBoardHold.value,
      rightGripBoardHold: rightGripBoardHold == null
          ? this.rightGripBoardHold
          : rightGripBoardHold.value,
      leftGrip: leftGrip == null ? this.leftGrip : leftGrip.value,
      rightGrip: rightGrip == null ? this.rightGrip : rightGrip.value,
      weightUnit: weightUnit ?? this.weightUnit,
      totalGroups: totalGroups ?? this.totalGroups,
      currentGroup: currentGroup ?? this.currentGroup,
      totalSets: totalSets ?? this.totalSets,
      currentSet: currentSet ?? this.currentSet,
      totalReps: totalReps ?? this.totalReps,
      currentRep: currentRep ?? this.currentRep,
    );
  }
}

class AdjustHangsDialogViewModel extends ChangeNotifier {
  NavigationService _navigationService;
  void Function(List<AdjustedHang> adjustedHangs) handleAdjustedHangs;

  List<PastHang> _pastHangs;
  List<PastHang> get pastHangs => _pastHangs;

  PastHang get selectedPastHang =>
      _pastHangs.firstWhere((PastHang pastHang) => pastHang.isSelected == true);
  int get _selectedPastHangIndex => _pastHangs.indexOf(selectedPastHang);

  bool _canScroll;
  bool get canScroll => _canScroll;

  String get repText =>
      'Rep ${selectedPastHang.currentRep}/${selectedPastHang.totalReps}';
  String get setText =>
      'set ${selectedPastHang.currentSet}/${selectedPastHang.totalSets}';
  String get groupText =>
      'group ${selectedPastHang.currentGroup}/${selectedPastHang.totalGroups}';

  AdjustHangsDialogViewModel(
      {@required List<PastHang> pastHangs,
      @required this.handleAdjustedHangs}) {
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
        selectedPastHang.copyWith(effectiveAddedWeightInput: s);
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

    final double _effectiveAddedWeight = InputParsers.parseToDouble(
        string: selectedPastHang.effectiveAddedWeightInput,
        inputField: 'Added weight');

    final bool _isValid =
        _effectiveAddedWeight != null && _validDuration == true;

    if (_isValid == true) {
      List<PastHang> _newPastHangs = []..addAll(_pastHangs);
      _newPastHangs[_selectedPastHangIndex] = selectedPastHang.copyWith(
        effectiveDurationS: _effectiveDurationS,
        effectiveAddedWeight: _effectiveAddedWeight,
      );
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
        final List<AdjustedHang> _adjustedHangs = _pastHangs
            .map((PastHang pastHang) => AdjustedHang(
                sequenceTimerIndex: pastHang.sequenceTimerIndex,
                effectiveAddedWeight: pastHang.effectiveAddedWeight,
                effectiveDurationS: pastHang.effectiveDurationS))
            .toList();
        _navigationService.pop();
        handleAdjustedHangs(_adjustedHangs);
        return true;
      } else {
        return false;
      }
    });
  }
}
