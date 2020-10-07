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
    final double _maxEffectiveAddedWeight = activeLogsForGroup
        .map((SequenceTimerLog log) => log.effectiveAddedWeight.abs())
        .toList()
        .reduce(max);

    _maxWeightAxisValue =
        (((_maxEffectiveAddedWeight ~/ 10) * 10) + 10).toDouble();
    _minWeightAxisValue = 0 - _maxWeightAxisValue;
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

  void handleSelection(SequenceTimerLog log) {
    _selectedLog = log;
    notifyListeners();
  }
}
