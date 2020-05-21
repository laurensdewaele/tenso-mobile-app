import 'package:app/widgets/execution/edit_hangs_dialog.dart';
import 'package:flutter/cupertino.dart';

class EditHangsDialogViewModel extends ChangeNotifier {
  List<EditHangInfo> _editHangInfoList;
  List<EditHangInfo> get editHangInfoList => _editHangInfoList;
  int _currentHang;
  int get currentHang => currentHang;
  int _totalHangs;
  int get totalHangs => _totalHangs;

  int _selectedHang;
  int get selectedHang => _selectedHang;

  EditHangInfo _selectedHangInfo;
  EditHangInfo get selectedHangInfo => _selectedHangInfo;

  EditHangsDialogViewModel(
      {List<EditHangInfo> editHangInfoList, int currentHang, int totalHangs}) {
    _editHangInfoList = editHangInfoList;
    _currentHang = currentHang;
    _totalHangs = totalHangs;
    _selectedHangInfo = _editHangInfoList
        .firstWhere((EditHangInfo i) => i.currentHang == currentHang);
    _selectedHang = _selectedHangInfo.currentHang;
  }

  void setHangTime(String s) {}
  void setAddedWeight(String weight) {}
}
