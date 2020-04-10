import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:rxdart/rxdart.dart';

enum Pages { generalPage, holdPage, extraPage }

@immutable
class NavigatorPage {
  final Pages page;
  final bool active;
  final int index;
  final int holdIndex;

  const NavigatorPage(
      {@required this.page,
      @required this.active,
      @required this.index,
      @required this.holdIndex});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigatorPage &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          active == other.active &&
          index == other.index &&
          holdIndex == other.holdIndex;

  @override
  int get hashCode =>
      page.hashCode ^ active.hashCode ^ index.hashCode ^ holdIndex.hashCode;

  @override
  String toString() {
    return 'NavigatorPage{page: $page, active: $active, index: $index, holdIndex: $holdIndex}';
  }
}

List<NavigatorPage> initialPages = [
  NavigatorPage(
    page: Pages.generalPage,
    index: 0,
    holdIndex: null,
    active: true,
  ),
  NavigatorPage(
    page: Pages.holdPage,
    index: 1,
    holdIndex: 0,
    active: false,
  ),
  NavigatorPage(
    page: Pages.extraPage,
    index: 2,
    holdIndex: null,
    active: false,
  )
];

class WorkoutNavigator {
  BehaviorSubject<List<NavigatorPage>> _pages$ =
      BehaviorSubject.seeded(initialPages);
  Stream<List<NavigatorPage>> get pages$ => _pages$.stream;

  NavigatorPage get _activePage =>
      _pages$.value.firstWhere((page) => page.active == true);
  Stream<NavigatorPage> get activePage$ => _pages$
      .map((pages) => pages.firstWhere((page) => page.active == true))
      .distinct();

  BehaviorSubject<ValidationState> _validationState$ =
      BehaviorSubject.seeded(ValidationUnknown());
  ValidationState get _validationState => _validationState$.value;

  Stream<bool> get shouldValidate$ => _validationState$.stream
      .where((state) => state is ValidationPending)
      .mapTo(true);

  StreamController<bool> _shouldPopRoute = StreamController.broadcast();
  Stream<bool> get shouldPopRoute$ => _shouldPopRoute.stream;

  int _holdCount;

  WorkoutNavigator({int initialHoldCount}) {
    _holdCount = initialHoldCount;
  }

  void buildPagesDueToHoldCount(int holdCount) {
    if (_holdCount == holdCount) {
      return;
    } else {
      _holdCount = holdCount;
      _buildPages(count: holdCount, activeIndex: 0);
    }
  }

  void _buildPages({int count, int activeIndex}) {
    _pages$.add([
      NavigatorPage(
          page: Pages.generalPage,
          active: activeIndex == 0,
          index: 0,
          holdIndex: null),
      ...List.generate(count - 2, (i) => i).map(
        (n) => NavigatorPage(
            page: Pages.holdPage,
            active: activeIndex == n + 1,
            index: n + 1,
            holdIndex: n),
      ),
      NavigatorPage(
          page: Pages.extraPage,
          active: activeIndex == count - 1,
          index: count - 1,
          holdIndex: null)
    ]);
  }

  void handleForwardRequest() {
    _validationState$
        .add(ValidationPending(navigationType: NavigationType.forward));
  }

  void handleBackRequest() {
    _validationState$
        .add(ValidationPending(navigationType: NavigationType.back));
  }

  void handleValidationSuccess() {
    if (_validationState$.value is ValidationPending) {
      if ((_validationState as ValidationPending).navigationType ==
          NavigationType.forward) {
        _forward();
      } else {
        _back();
      }
    }
  }

  void _forward() {
    if (_activePage.index <= _pages$.value.length - 2) {
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

enum NavigationType { forward, back }

class ValidationState {}

class ValidationPending extends ValidationState {
  NavigationType navigationType;

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

  @override
  String toString() {
    return 'ValidationPending{navigationType: $navigationType}';
  }
}

class ValidationUnknown extends ValidationState {}
