import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:flutter/foundation.dart';

@immutable
class ExtraPageState {
  final Label label;
  final String name;
  final String nameInput;

  final bool inputsEnabled;
  final Color primaryColor;
  final String extraTabButtonText;

  final int totalPages;

  const ExtraPageState(
      {@required this.label,
      @required this.name,
      @required this.nameInput,
      @required this.inputsEnabled,
      @required this.primaryColor,
      @required this.extraTabButtonText,
      @required this.totalPages});

  ExtraPageState copyWith({
    Label label,
    String name,
    String nameInput,
    bool inputsEnabled,
    Color primaryColor,
    String extraTabButtonText,
    int totalPages,
  }) {
    return new ExtraPageState(
      label: label ?? this.label,
      name: name ?? this.name,
      nameInput: nameInput ?? this.nameInput,
      inputsEnabled: inputsEnabled ?? this.inputsEnabled,
      primaryColor: primaryColor ?? this.primaryColor,
      extraTabButtonText: extraTabButtonText ?? this.extraTabButtonText,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}
