import 'package:flutter/cupertino.dart';

enum WorkoutPages { generalPage, holdPage, extraPage }

@immutable
class WorkoutNavigatorPage {
  final WorkoutPages page;
  final bool active;
  final int index;
  final int holdIndex;

  const WorkoutNavigatorPage(
      {@required this.page,
      @required this.active,
      @required this.index,
      @required this.holdIndex});
}

enum WorkoutNavigatorType { forward, back }

class NavigationValidationState {}

class ValidationUnknown extends NavigationValidationState {}

class ValidationPending extends NavigationValidationState {
  WorkoutNavigatorType navigationType;

  ValidationPending({
    @required this.navigationType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValidationPending &&
          runtimeType == other.runtimeType &&
          navigationType == other.navigationType;

  @override
  int get hashCode => navigationType.hashCode;
}
