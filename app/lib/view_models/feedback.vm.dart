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
    if (_valid == true) {
      //TODO: Send to backend
    }
    return _valid;
  }

  Future<bool> validate() {
    return Future.sync(_validate);
  }
}
