import 'dart:async';

import 'package:flutter/cupertino.dart';

class ToastService {
  ToastService._();
  static final ToastService _toastService = ToastService._();
  factory ToastService() {
    return _toastService;
  }

  final StreamController<Widget> _errorMessageStreamController =
      StreamController<Widget>();
  Stream<Widget> get errorMessageStream => _errorMessageStreamController.stream;

  void dispose() {
    _errorMessageStreamController.close();
  }

  void add(Widget message) {
    _errorMessageStreamController.sink.add(message);
  }
}
