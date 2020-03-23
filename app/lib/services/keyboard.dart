import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class KeyboardService {
  StreamController<bool> _resetInitialInputStreamController =
      StreamController<bool>.broadcast();
  Stream<bool> get resetInitialInputStream =>
      _resetInitialInputStreamController.stream;
  StreamController<bool> _shouldLoseFocusStreamController =
      StreamController<bool>.broadcast();
  Stream<bool> get shouldLoseFocusStream =>
      _shouldLoseFocusStreamController.stream;
  StreamController<double> _keyboardOffsetHeightStreamController =
      StreamController<double>.broadcast();
  Stream<double> get keyboardOffsetHeightStream =>
      _keyboardOffsetHeightStreamController.stream;

  double _keyboardHeight = 0;
  double _deviceHeight = 0;
  // We're storing the latest tapPosition, because when it's the first time
  // that the users clicks an input field, handlePointerDow is ran first,
  // and only after, the device keyboard height is known and we need to run handlePointerDown again,
  // but this time we have lost the tapPosition.
  Offset _latestTapPosition = Offset.zero;

  void resetInitialInput() {
    _resetInitialInputStreamController.sink.add(true);
  }

  void dispose() {
    _shouldLoseFocusStreamController.close();
    _keyboardOffsetHeightStreamController.close();
    _resetInitialInputStreamController.close();
  }

  void onScreenTap() {
    _shouldLoseFocusStreamController.sink.add(true);
    _keyboardOffsetHeightStreamController.sink.add(0);
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
