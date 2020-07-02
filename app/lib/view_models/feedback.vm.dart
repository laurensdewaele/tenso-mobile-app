import 'package:app/services/parser.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:flutter/cupertino.dart';

final List<String> feedbackTypes = [
  'appreciation',
  'board request',
  'feature request',
  'other'
];

class FeedbackViewModel extends ChangeNotifier {
  String _messageInput;
  String _type = feedbackTypes[0];
  bool _awaitingResponse = false;
  bool get awaitingResponse => _awaitingResponse;

  void setMessage(String message) {
    _messageInput = message;
  }

  void setType(String type) {
    _type = type;
  }

  bool _validate() {
    final String _message = InputParsers.parseString(string: _messageInput);
    final bool _valid =
        Validators.stringNotEmpty(string: _message, inputField: 'message');
    return _valid;
  }

  Future<bool> sendMessage() {
    return Future.sync(() async {
      final _isValid = _validate();
      if (_isValid == true) {
        _awaitingResponse = true;
        notifyListeners();
        // TODO: Send to backend.
        _awaitingResponse = false;
        notifyListeners();
      }
      return _isValid;
    });
  }
}
