import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tenso_app/data/versioning.data.dart';
import 'package:tenso_app/dto/feedback.dto.dart';
import 'package:tenso_app/services/parser.service.dart';
import 'package:tenso_app/services/toast.service.dart';
import 'package:tenso_app/services/validation.service.dart';
import 'package:tenso_app/widgets/toast_message.dart';

final List<String> feedbackTypes = [
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
  String _emailInput;
  String _email;
  String _type = feedbackTypes[0];
  bool _awaitingResponse = false;
  bool get awaitingResponse => _awaitingResponse;

  void setEmail(String emailInput) {
    _emailInput = emailInput;
  }

  void setMessage(String message) {
    _messageInput = message;
  }

  void setType(String type) {
    _type = type;
  }

  bool _validate() {
    final List<bool> _validations = [];

    _message = InputParsers.parseString(string: _messageInput);
    _validations.add(
        Validators.stringNotEmpty(string: _message, inputField: 'message'));

    _email = InputParsers.parseString(string: _emailInput);

    return _validations.fold(true, (a, b) => a && b);
  }

  Future<bool> sendMessage() async {
    return Future.sync(() async {
      final _isValid = _validate();
      if (_isValid == true) {
        _awaitingResponse = true;
        notifyListeners();
        final Feedback _feedback = Feedback((b) => b
          ..message = _message
          ..type = _type
          ..email = _email
          ..versionNo = latestVersioning.versions[0].no);
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
