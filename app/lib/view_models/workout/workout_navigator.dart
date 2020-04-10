import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:app/view_models/workout/workout_navigator_state.dart';

WorkoutNavigatorPage _initialNavigatorPage = WorkoutNavigatorPage(
  page: WorkoutPages.generalPage,
  index: 0,
  holdIndex: null,
  active: true,
);

class WorkoutNavigator {
  BehaviorSubject<List<WorkoutNavigatorPage>> _pages$ =
      BehaviorSubject.seeded([_initialNavigatorPage]);
  WorkoutNavigatorPage get initialPage => _pages$.value[0];

  WorkoutNavigatorPage get _activePage =>
      _pages$.value.firstWhere((page) => page.active == true);
  Stream<WorkoutNavigatorPage> get activePage$ => _pages$
      .map((pages) => pages.firstWhere((page) => page.active == true))
      .distinct();
  WorkoutNavigatorPage get activePage =>
      _pages$.value.firstWhere((page) => page.active == true);

  BehaviorSubject<NavigationValidationState> _validationState$ =
      BehaviorSubject.seeded(ValidationUnknown());
  Stream<bool> get shouldValidate$ => _validationState$.stream
      .where((state) => state is ValidationPending)
      .mapTo(true);

  StreamController<bool> _shouldPopRoute = StreamController.broadcast();
  Stream<bool> get shouldPopRoute$ => _shouldPopRoute.stream;

  WorkoutNavigator({int initialHoldCount}) {
    buildPagesDueToHoldCount(initialHoldCount);
  }

  void buildPagesDueToHoldCount(int holdCount) {
    _buildPages(count: holdCount + 2, activeIndex: 0);
  }

  void _buildPages({int count, int activeIndex}) {
    _pages$.add([
      WorkoutNavigatorPage(
          page: WorkoutPages.generalPage,
          active: activeIndex == 0,
          index: 0,
          holdIndex: null),
      ...List.generate(count - 2, (i) => i).map(
        (n) => WorkoutNavigatorPage(
            page: WorkoutPages.holdPage,
            active: activeIndex == n + 1,
            index: n + 1,
            holdIndex: n),
      ),
      WorkoutNavigatorPage(
          page: WorkoutPages.extraPage,
          active: activeIndex == count - 1,
          index: count - 1,
          holdIndex: null)
    ]);
  }

  void handleForwardRequest() {
    _validationState$
        .add(ValidationPending(navigationType: WorkoutNavigatorType.forward));
  }

  void handleBackRequest() {
    _validationState$
        .add(ValidationPending(navigationType: WorkoutNavigatorType.back));
  }

  void handleValidationSuccess() {
    if (_validationState$.value is ValidationPending) {
      if ((_validationState$.value as ValidationPending).navigationType ==
          WorkoutNavigatorType.forward) {
        _forward();
      } else {
        _back();
      }
    }
  }

  void _forward() {
    if (_activePage.index <= _pages$.value.length - 1) {
      _buildPages(
          count: _pages$.value.length, activeIndex: _activePage.index + 1);
      _validationState$.add(ValidationUnknown());
    } else {
      _shouldPopRoute.add(true);
    }
  }

  void _back() {
    if (_activePage.index >= 1) {
      _buildPages(
          count: _pages$.value.length, activeIndex: _activePage.index - 1);
      _validationState$.add(ValidationUnknown());
    }
    if (_activePage.index == 0) {
      _shouldPopRoute.add(true);
    }
  }

  void dispose() {
    _pages$.close();
    _validationState$.close();
    _shouldPopRoute.close();
  }
}
