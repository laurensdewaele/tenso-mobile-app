import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tenso_app/dto/feedback.dto.dart';
import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/services/validation.service.dart';
import 'package:tenso_app/widgets/toast_message.dart';

final List<String> feedbackTypes = [
  'appreciation',
  'board request',
  'bug',
  'feature request',
  'other'
];

class FeedbackViewModel extends ChangeNotifier {
  FeedbackViewModel();

  ToastService _toastService = ToastService();
  String _messageInput;
  String _message;
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
    _message = InputParsers.parseString(string: _messageInput);
    final bool _valid =
        Validators.stringNotEmpty(string: _message, inputField: 'message');
    return _valid;
  }

  Future<bool> sendMessage() async {
    return Future.sync(() async {
      final _isValid = _validate();
      if (_isValid == true) {
        _awaitingResponse = true;
        notifyListeners();
        final Feedback _feedback = Feedback((b) => b
          ..message = _message
          ..type = _type);
        final Response _response = await http.post(
            "https://tenso-server.ue.r.appspot.com/feedback",
            headers: {HttpHeaders.contentTypeHeader: 'application/json'},
            body: _feedback.toJson());
        if (_response.statusCode == 201) {
          _toastService.add(ToastMessages.feedbackSuccess());
        } else {
          _toastService.add(ToastMessages.feedbackError());
        }
        _awaitingResponse = false;
        notifyListeners();
      }
      return _isValid;
    });
  }
}
