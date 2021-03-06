import 'package:flutter/cupertino.dart';

class NavigationService {
  NavigationService._();
  static final NavigationService _navigationService = NavigationService._();
  factory NavigationService() => _navigationService;

  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<T> pushNamed<T extends Object>(
    String routeName, {
    Object arguments,
  }) {
    return navigatorKey.currentState
        .pushNamed<T>(routeName, arguments: arguments);
  }

  void pop<T extends Object>([T result]) {
    return navigatorKey.currentState.pop(result);
  }

  void popUntil(RoutePredicate predicate) {
    return navigatorKey.currentState.popUntil(predicate);
  }
}
