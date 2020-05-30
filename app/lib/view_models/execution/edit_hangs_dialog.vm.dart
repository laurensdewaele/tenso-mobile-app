import 'package:app/models/models.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/services/parser.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hang {
  int duration;
  String durationInput;
  double addedWeight;
  String addedWeightInput;

  int totalSets;
  int totalHangsPerSet;
  int currentHangPerSet;
  int currentSet;
  int currentHang;

  bool isPastHang;
  bool isSelected;

  String imageAsset;
  double imageAssetWidth;
  List<CustomBoardHoldImage> customBoardHoldImages;
  double handToBoardHeightRatio;
  BoardHold leftGripBoardHold;
  BoardHold rightGripBoardHold;
  Grip leftGrip;
  Grip rightGrip;
  String weightUnit;

  Hang({
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

class EditedHang {
  final int duration;
  final double addedWeight;
  final int currentHang;

  const EditedHang({
    @required this.duration,
    @required this.addedWeight,
    @required this.currentHang,
  });
}

class EditHangInfo {
  final int duration;
  final Board board;
  final int currentHang;
  final int currentHangPerSet;
  final int currentSet;
  final int totalSets;
  final int totalHangsPerSet;
  final WeightSystem weightSystem;
  final Hold hold;

  const EditHangInfo({
    @required this.duration,
    @required this.board,
    @required this.currentHang,
    @required this.currentHangPerSet,
    @required this.currentSet,
    @required this.totalSets,
    @required this.weightSystem,
    @required this.hold,
    @required this.totalHangsPerSet,
  });
}

class _EditedHangInput {
  final int currentHang;
  final String durationInput;
  final String addedWeightInput;

  const _EditedHangInput({
    @required this.currentHang,
    @required this.durationInput,
    @required this.addedWeightInput,
  });

  _EditedHangInput copyWith({
    int currentHang,
    String durationInput,
    String addedWeightInput,
  }) {
    return new _EditedHangInput(
      currentHang: currentHang ?? this.currentHang,
      durationInput: durationInput ?? this.durationInput,
      addedWeightInput: addedWeightInput ?? this.addedWeightInput,
    );
  }
}

class EditHangsDialogViewModel extends ChangeNotifier {
  NavigationService _navigationService;
  List<EditHangInfo> _editHangInfoList;
  List<EditHangInfo> get editHangInfoList => _editHangInfoList;
  List<_EditedHangInput> _editedHangInputs;
  _EditedHangInput get _affectedHangInput => _editedHangInputs
      .firstWhere((input) => input.currentHang == selectedHang);
  int _nextHang;
  int get nextHang => _nextHang;
  int _totalHangs;
  int get totalHangs => _totalHangs;
  int get selectedHang => _selectedHangInfo.currentHang;
  EditHangInfo _selectedHangInfo;
  EditHangInfo get selectedHangInfo => _selectedHangInfo;
  void Function(List<EditedHang> editedHangs) handleEditedHangs;
  bool get isPastHang => nextHang > selectedHang;

  EditHangsDialogViewModel(
      {List<Hang> hangs,
      List<EditHangInfo> editHangInfoList,
      int nextHang,
      int totalHangs,
      this.handleEditedHangs}) {
    _navigationService = NavigationService();
    _editHangInfoList = editHangInfoList;
    _editedHangInputs = _editHangInfoList
        .map((EditHangInfo editHangInfo) => _EditedHangInput(
            currentHang: editHangInfo.currentHang,
            addedWeightInput: editHangInfo.hold.addedWeight.toString(),
            durationInput: editHangInfo.duration.toString()))
        .toList();
    _totalHangs = totalHangs;
    _nextHang = nextHang;
    _selectedHangInfo = _editHangInfoList
        .firstWhere((EditHangInfo i) => i.currentHang == nextHang);
    notifyListeners();
  }

  void setHangTime(String s) {
    final _index = _editedHangInputs.indexOf(_affectedHangInput);
    _editedHangInputs[_index] = _affectedHangInput.copyWith(durationInput: s);
  }

  void setAddedWeight(String s) {
    final _index = _editedHangInputs.indexOf(_affectedHangInput);
    _editedHangInputs[_index] =
        _affectedHangInput.copyWith(addedWeightInput: s);
  }

  List<EditedHang> _validate() {
    bool _valid = true;

    final List<EditedHang> _editedHangs =
        _editedHangInputs.map((_EditedHangInput editedHangInput) {
      final int _duration = InputParsers.parseToInt(
          string: editedHangInput.durationInput,
          inputField:
              'Hang ${editedHangInput.currentHang}/$totalHangs duration');

      final bool _validDuration = Validators.biggerOrEqualToZero(
          value: _duration,
          inputField:
              'Hang ${editedHangInput.currentHang}/$totalHangs duration');

      final double _addedWeight = InputParsers.parseToDouble(
          string: editedHangInput.addedWeightInput,
          inputField:
              'Hang ${editedHangInput.currentHang}/$totalHangs added weight');

      if (_addedWeight == null || _validDuration == false) {
        _valid = false;
      }

      return EditedHang(
          currentHang: editedHangInput.currentHang,
          duration: _duration,
          addedWeight: _addedWeight);
    }).toList();

    return _valid == true ? _editedHangs : null;
  }

  Future<bool> handleDone() {
    return Future.sync(() {
      final List<EditedHang> _editedHangs = _validate();

      if (_editedHangs != null) {
        _navigationService.pop();
        handleEditedHangs(_editedHangs);
        return true;
      } else {
        return false;
      }
    });
  }

  void setSelectedHang(int index) {
    _selectedHangInfo = _editHangInfoList[index];
    notifyListeners();
  }
}
