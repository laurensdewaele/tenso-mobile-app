import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/models.dart';

class LogOverviewViewModel extends ChangeNotifier {
  List<SequenceTimerLog> _sequenceTimerLogs;
  List<SequenceTimerLog> _activeLogsForGroup;
  List<SequenceTimerLog> get activeLogsForGroup => _activeLogsForGroup;
  SequenceTimerLog _selectedLog;
  SequenceTimerLog get selectedLog => _selectedLog;
  String _weightUnit;
  String get weightUnit => _weightUnit;
  double _minWeightAxisValue;
  double get minWeightAxisValue => _minWeightAxisValue;
  double _maxWeightAxisValue;
  double get maxWeightAxisValue => _maxWeightAxisValue;

  LogOverviewViewModel({sequenceTimerLogs}) {
    _sequenceTimerLogs = sequenceTimerLogs;
    _setActiveLogsForGroup(0);
    _weightUnit = selectedLog.weightSystem.unit;
  }

  void _setWeightAxisValues() {
    final List<double> _effectiveAddedWeights = activeLogsForGroup
        .map((SequenceTimerLog log) => log.effectiveAddedWeight)
        .toList();
    _minWeightAxisValue = _effectiveAddedWeights.reduce(min);
    _maxWeightAxisValue = _effectiveAddedWeights.reduce(max);
  }

  void _setActiveLogsForGroup(int groupIndex) {
    _activeLogsForGroup = _sequenceTimerLogs
        .where((SequenceTimerLog log) => log.groupIndex == groupIndex)
        .toList();
    _selectedLog = _activeLogsForGroup[0];
    _setWeightAxisValues();
  }

  void setActiveGroupIndex(int groupIndex) {
    _setActiveLogsForGroup(groupIndex);
    notifyListeners();
  }

  void setSelectedLog(SequenceTimerLog log) {
    notifyListeners();
  }

  void handleSelection(SequenceTimerLog log) {
    _selectedLog = log;
    notifyListeners();
  }
}
