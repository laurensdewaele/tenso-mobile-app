import 'package:app/services/navigation.service.dart';
import 'package:app/services/parser.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:app/widgets/execution/edit_hangs_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      {List<EditHangInfo> editHangInfoList,
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
