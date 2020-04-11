import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';

@immutable
class ExtraPageState {
  final Label label;
  final String name;
  final String nameInput;

  final bool inputsEnabled;
  final Color primaryColor;
  final String extraTabButtonText;

  const ExtraPageState({
    @required this.label,
    @required this.name,
    @required this.nameInput,
    @required this.inputsEnabled,
    @required this.primaryColor,
    @required this.extraTabButtonText,
  });

  ExtraPageState copyWith({
    Label label,
    String name,
    String nameInput,
    bool inputsEnabled,
    Color primaryColor,
    String extraTabButtonText,
  }) {
    return new ExtraPageState(
      label: label ?? this.label,
      name: name ?? this.name,
      nameInput: nameInput ?? this.nameInput,
      inputsEnabled: inputsEnabled ?? this.inputsEnabled,
      primaryColor: primaryColor ?? this.primaryColor,
      extraTabButtonText: extraTabButtonText ?? this.extraTabButtonText,
    );
  }
}
