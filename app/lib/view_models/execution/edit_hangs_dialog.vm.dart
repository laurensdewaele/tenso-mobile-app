import 'package:app/widgets/execution/edit_hangs_dialog.dart';
import 'package:flutter/cupertino.dart';

class EditHangsDialogViewModel extends ChangeNotifier {
  List<EditHangInfo> _editHangInfoList;
  List<EditHangInfo> get editHangInfoList => _editHangInfoList;
  int _currentHang;
  int get currentHang => _currentHang;
  int _totalHangs;
  int get totalHangs => _totalHangs;

  int get selectedHang => _selectedHangInfo.currentHang;

  EditHangInfo _selectedHangInfo;
  EditHangInfo get selectedHangInfo => _selectedHangInfo;

  EditHangsDialogViewModel(
      {List<EditHangInfo> editHangInfoList, int currentHang, int totalHangs}) {
    _editHangInfoList = editHangInfoList;
    _totalHangs = totalHangs;
    _currentHang = currentHang;
    _selectedHangInfo = _editHangInfoList
        .firstWhere((EditHangInfo i) => i.currentHang == currentHang);
    notifyListeners();
  }

  void setHangTime(String s) {}
  void setAddedWeight(String weight) {}

  void setSelectedHang(int index) {
    _selectedHangInfo = _editHangInfoList[index];
    notifyListeners();
  }
}
