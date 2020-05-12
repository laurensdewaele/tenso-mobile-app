import 'dart:async';

import 'package:flutter/cupertino.dart';

class ToastService {
  ToastService._();
  static final ToastService _toastService = ToastService._();
  factory ToastService() {
    return _toastService;
  }

  final StreamController<Widget> _errorMessageController =
      StreamController<Widget>.broadcast();
  Stream<Widget> get errorMessage$ => _errorMessageController.stream;

  void dispose() {
    _errorMessageController.close();
  }

  void add(Widget message) {
    _errorMessageController.sink.add(message);
  }
}
