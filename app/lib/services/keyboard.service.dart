import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class KeyboardService {
  KeyboardService._();
  static final KeyboardService _keyboardService = KeyboardService._();
  factory KeyboardService() => _keyboardService;

  final StreamController<bool> _resetInitialValueStreamController =
      StreamController.broadcast();
  final StreamController<bool> _shouldLoseFocusStreamController =
      StreamController.broadcast();
  final StreamController<double> _keyboardOffsetHeightStreamController =
      StreamController.broadcast();
  final StreamController<bool> _inputCompleteController =
      StreamController.broadcast();

  Stream<bool> get resetInitialValue$ =>
      _resetInitialValueStreamController.stream;
  Stream<bool> get shouldLoseFocus$ => _shouldLoseFocusStreamController.stream;
  Stream<double> get keyboardOffsetHeight$ =>
      _keyboardOffsetHeightStreamController.stream;
  Stream<bool> get inputComplete$ => _inputCompleteController.stream;

  double _keyboardHeight = 0;
  double _deviceHeight = 0;
  // We're storing the latest tapPosition, because when it's the first time
  // that the users clicks an input field, handlePointerDown is ran first,
  // and only after, the device keyboard height is known and we need to run handlePointerDown again,
  // but this time we have lost the tapPosition.
  Offset _latestTapPosition = Offset.zero;

  void resetInitialValue() {
    _resetInitialValueStreamController.sink.add(true);
  }

  void dispose() {
    _shouldLoseFocusStreamController.close();
    _keyboardOffsetHeightStreamController.close();
    _resetInitialValueStreamController.close();
    _inputCompleteController.close();
  }

  void handleScreenTap() {
    _shouldLoseFocusStreamController.sink.add(true);
    _keyboardOffsetHeightStreamController.sink.add(0);
  }

  void handleInputComplete() {
    resetKeyboardOffset();
    _inputCompleteController.add(true);
  }

  void _handleKeyboardOffset(Offset offset) {
    _keyboardOffsetHeightStreamController.sink.add(offset.dy);
  }

  void handlePointerDown(Offset tapPosition) {
    _latestTapPosition = tapPosition;

    final double cutoffHeight = _deviceHeight - _keyboardHeight;
    final double idealCutoffHeight = cutoffHeight - styles.Measurements.xxl;

    if (tapPosition.dy > idealCutoffHeight) {
      final double offset = _latestTapPosition.dy - idealCutoffHeight;
      _handleKeyboardOffset(Offset(0.0, offset));
    }
  }

  void setDeviceHeight(double deviceHeight, double keyboardHeight) {
    if (_deviceHeight != deviceHeight && deviceHeight > 0) {
      _deviceHeight = deviceHeight;
      _shouldLoseFocusStreamController.sink.add(true);
    }

    if (_keyboardHeight != keyboardHeight && keyboardHeight > 0) {
      _keyboardHeight = keyboardHeight;
      handlePointerDown(_latestTapPosition);
    }
  }

  void resetKeyboardOffset() {
    _handleKeyboardOffset(Offset.zero);
  }
}
