import 'package:app/models/models.dart';
import 'package:flutter/cupertino.dart';

class LogOverviewViewModel extends ChangeNotifier {
  List<SequenceTimerLog> _logs;
  List<SequenceTimerLog> _selectedGroupLogs;
  List<SequenceTimerLog> get selectedGroupLogs => _selectedGroupLogs;
  SequenceTimerLog _selectedLog;
  SequenceTimerLog get selectedLog => _selectedLog;

  LogOverviewViewModel({logs}) {
    _logs = logs;
    _setSelectedGroupLogsByIndex(0);
    _selectedLog = _selectedGroupLogs[0];
  }

  void _setSelectedGroupLogsByIndex(int groupIndex) {
    _selectedGroupLogs = _logs
        .where((SequenceTimerLog log) => log.groupIndex == groupIndex)
        .toList();
  }

  void setActiveGroupIndex(int groupIndex) {
    _setSelectedGroupLogsByIndex(groupIndex);
    _selectedLog = _selectedGroupLogs[0];
    notifyListeners();
  }

  void setSelectedLog(SequenceTimerLog log) {
    _selectedLog = log;
    notifyListeners();
  }
}
