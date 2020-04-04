import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:rxdart/rxdart.dart';

import 'package:app/view_models/workout/workout_vm.dart';

enum Pages { generalPage, holdPage, extraPage }

@immutable
class NavigatorPage {
  final Pages page;
  final bool active;
  final int index;

  const NavigatorPage({
    @required this.page,
    @required this.active,
    @required this.index,
  });
}

class WorkoutNavigator {
  WorkoutViewModel _workoutViewModel;

  List<NavigatorPage> _pages;
  NavigatorPage get _activePage => _pages.firstWhere((p) => p.active == true);
  BehaviorSubject<List<NavigatorPage>> _pages$ =
      BehaviorSubject<List<NavigatorPage>>();
  Stream<NavigatorPage> get activePage$ =>
      _pages$.map((pages) => pages.firstWhere((page) => page.active == true));

  _ValidationState _validationState;

  StreamController<bool> _shouldValidateController =
      StreamController<bool>.broadcast();
  Stream<bool> get shouldValidate$ => _shouldValidateController.stream;

  StreamSubscription _subscription;

  WorkoutNavigator({WorkoutViewModel workoutViewModel}) {
    _workoutViewModel = workoutViewModel;
    // We will always be on the General page when the holdCount changes.
    _subscription = _workoutViewModel.holdCount$.listen(
        (int holdCount) => _buildPages(count: holdCount + 2, activeIndex: 0));
  }

  void _buildPages({int count, int activeIndex}) {
    _validationState = _ValidationUnknown();
    _pages = [
      NavigatorPage(
          page: Pages.generalPage, active: activeIndex == 0, index: 0),
      ...List.generate(count - 2, (i) => i).map(
        (n) => NavigatorPage(
            page: Pages.holdPage, active: activeIndex == n + 1, index: n + 1),
      ),
      NavigatorPage(
        page: Pages.extraPage,
        active: activeIndex == count - 1,
        index: count - 1,
      )
    ];
    _pages$.add(_pages);
  }

  void handleForwardRequest() {
    _validationState =
        _ValidationPending(navigationType: NavigationType.forward);
    _shouldValidateController.add(true);
  }

  void handleBackRequest() {
    _validationState = _ValidationPending(navigationType: NavigationType.back);
    _shouldValidateController.add(true);
  }

  void handleValidationSuccess() {
    if (_validationState is _ValidationPending) {
      if ((_validationState as _ValidationPending).navigationType ==
          NavigationType.forward) {
        _forward();
      } else {
        _back();
      }
    }
    _validationState = _ValidationSuccess();
  }

  void _forward() {
    if (_activePage.index <= _pages.length - 2) {
      _buildPages(count: _pages.length, activeIndex: _activePage.index + 1);
    }
  }

  void _back() {
    if (_activePage.index <= _pages.length - 2) {
      _buildPages(count: _pages.length, activeIndex: _activePage.index + 1);
    }
  }

  void dispose() {
    _subscription.cancel();
    _pages$.close();
    _shouldValidateController.close();
  }
}

enum NavigationType { forward, back }

class _ValidationState {}

class _ValidationPending extends _ValidationState {
  NavigationType navigationType;

  _ValidationPending({
    @required this.navigationType,
  });
}

class _ValidationSuccess extends _ValidationState {}

class _ValidationUnknown extends _ValidationState {}
