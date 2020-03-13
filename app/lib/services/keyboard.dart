import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/styles/styles.dart' as styles;

class KeyboardService {
  StreamController<bool> _shouldLoseFocusStreamController =
      StreamController<bool>.broadcast();
  Stream get shouldLoseFocusStream => _shouldLoseFocusStreamController.stream;
  StreamController<double> _keyboardOffsetHeightStreamController =
      StreamController<double>.broadcast();
  Stream get keyboardOffsetHeightStream =>
      _keyboardOffsetHeightStreamController.stream;

  double _keyboardHeight = 0;
  double _deviceHeight = 0;

  void dispose() {
    _shouldLoseFocusStreamController.close();
    _keyboardOffsetHeightStreamController.close();
  }

  void onScreenTap() {
    _shouldLoseFocusStreamController.sink.add(true);
    _keyboardOffsetHeightStreamController.sink.add(0);
  }

  void _handleKeyboardOffset(Offset offset) {
    _keyboardOffsetHeightStreamController.sink.add(offset.dy);

    // TODO: Move logic to screen themselves
//    if (offset.dy == 0) return;
//    final double originalScrollDifference =
//        _scrollController.position.maxScrollExtent - _scrollController.offset;
//
//    SchedulerBinding.instance.addPostFrameCallback((_) {
//      _scrollController.animateTo(
//        _scrollController.position.maxScrollExtent - originalScrollDifference,
//        duration: const Duration(milliseconds: 200),
//        curve: Curves.easeOut,
//      );
//    });
  }

  void handlePointerDown(Offset tapPosition) {
    final double cutoffHeight = _deviceHeight - _keyboardHeight;
    final double idealCutoffHeight = cutoffHeight - styles.Measurements.xxl;

    if (tapPosition.dy > idealCutoffHeight) {
      final double offset = tapPosition.dy - idealCutoffHeight;
      _handleKeyboardOffset(Offset(0.0, offset));
    }
  }

  void setDeviceHeight(double deviceHeight, double keyboardHeight) {
    if (_deviceHeight != deviceHeight && deviceHeight > 0) {
      _deviceHeight = deviceHeight;
    }

    if (_keyboardHeight != keyboardHeight && keyboardHeight > 0) {
      _keyboardHeight = keyboardHeight;
    }
  }

  void resetKeyboardOffset() {
    _handleKeyboardOffset(Offset.zero);
  }
}
